// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:font_script/checks.dart';
import 'package:http/http.dart';
import 'package:version/version.dart';

const repository = 'sbb-design-systems/sbb-icons';
const retries = 3;

/// Failed checks that stop the update. Each message names one thing that went wrong.
class UpdateFailure implements Exception {
  UpdateFailure(String message) : messages = [message];

  UpdateFailure.all(this.messages);

  final List<String> messages;

  @override
  String toString() => messages.join('\n');
}

Future<void> main() async {
  final client = Client();
  try {
    await update(client);
  } on UpdateFailure catch (e) {
    print('Update failed:');
    for (final message in e.messages) {
      print('  - $message');
    }
    exitCode = 1;
  } finally {
    client.close();
  }
}

Future<void> update(Client client) async {
  final newVersion = await fetchLatestVersion(client);
  final versionFile = File('icons/.version');

  if (await versionFile.exists()) {
    final oldVersion = Version.parse(await versionFile.readAsString());
    print('Remote Version: $newVersion - Local Version: $oldVersion');
    if (oldVersion >= newVersion) {
      print('All up to date!');
      return;
    } else {
      print('Starting update process...');
    }
  }

  print('Downloading icons v$newVersion');
  final files = await downloadArchive(client, newVersion);
  final indexFile = files['icons/index.json'];
  if (indexFile == null) throw UpdateFailure('The archive of v$newVersion has no icons/index.json');
  final index = jsonDecode(utf8.decode(indexFile)) as Map<String, dynamic>;
  final svgNames = {
    for (final path in files.keys)
      if (path.startsWith('icons/') && path.endsWith('.svg'))
        path.substring('icons/'.length, path.length - '.svg'.length),
  };
  final failures = checkIndex(index, newVersion, svgNames);

  for (final size in sizes) {
    await prepareIcons(size, iconNames(index, size), files);
    await Directory('icons/$size').create(recursive: true);
  }

  print('Preparing ttf files');
  await Process.run('npm', ['install'], runInShell: true);
  await Process.run('npm', ['run', 'fix'], runInShell: true);
  await Process.run('npm', ['run', 'generate'], runInShell: true);
  if (failures.isNotEmpty) throw UpdateFailure.all(failures);

  print('Generating dart files');
  await createFlutterFontMap();

  await File('icons/.version').writeAsString(newVersion.toString());
  for (final size in sizes) {
    await Directory('icons/$size').delete(recursive: true);
    await Directory('icons/$size-tmp').delete(recursive: true);
    await File('icons/sbb_icons_$size.json').delete();
  }
}

Map<String, String> get githubHeaders {
  final token = Platform.environment['GITHUB_TOKEN'];
  return {
    'Accept': 'application/vnd.github+json',
    if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
  };
}

/// Returns the highest `vX.Y.Z` tag of the icon repository, following the pagination of the tags API.
Future<Version> fetchLatestVersion(Client client) async {
  final tagNames = <String>[];
  Uri? uri = Uri.https('api.github.com', '/repos/$repository/tags', {'per_page': '100'});
  while (uri != null) {
    final response = await getWithRetry(client, uri, headers: githubHeaders);
    final tags = jsonDecode(response.body) as List<dynamic>;
    tagNames.addAll(tags.map((tag) => tag['name'] as String));
    uri = nextPage(response.headers['link']);
  }
  final latest = latestVersionTag(tagNames);
  if (latest == null) throw UpdateFailure('No vX.Y.Z tag found in $repository');
  return latest;
}

Uri? nextPage(String? linkHeader) {
  final match = RegExp(r'<([^>]+)>;\s*rel="next"').firstMatch(linkHeader ?? '');
  return match == null ? null : Uri.parse(match[1]!);
}

/// Downloads the tagged archive and returns its files keyed by their path inside the repository.
Future<Map<String, List<int>>> downloadArchive(Client client, Version version) async {
  final uri = Uri.https('github.com', '/$repository/archive/refs/tags/v$version.zip');
  final response = await getWithRetry(client, uri);
  final archive = ZipDecoder().decodeBytes(response.bodyBytes);
  return {
    for (final file in archive.files)
      if (file.isFile) file.name.substring(file.name.indexOf('/') + 1): file.content,
  };
}

/// GETs [uri], retrying network errors and 5xx responses with exponential backoff.
/// Throws an [UpdateFailure] if the final response is not 200.
Future<Response> getWithRetry(Client client, Uri uri, {Map<String, String>? headers}) async {
  for (var attempt = 0; ; attempt++) {
    String problem;
    try {
      final response = await client.get(uri, headers: headers).timeout(const Duration(minutes: 2));
      if (response.statusCode == 200) return response;
      if (response.statusCode < 500) throw UpdateFailure('GET $uri failed with HTTP ${response.statusCode}');
      problem = 'HTTP ${response.statusCode}';
    } on Exception catch (e) {
      if (e is! ClientException && e is! SocketException && e is! TimeoutException && e is! HttpException) rethrow;
      problem = e.toString();
    }
    if (attempt >= retries) throw UpdateFailure('GET $uri failed after ${retries + 1} attempts: $problem');
    final delay = Duration(seconds: 2 << attempt);
    print('GET $uri failed ($problem), retrying in ${delay.inSeconds}s');
    await Future<void>.delayed(delay);
  }
}

Future<void> prepareIcons(String size, Set<String> names, Map<String, List<int>> files) async {
  final dir = await Directory('icons/$size-tmp').create(recursive: true);
  for (final name in names) {
    final svg = files['icons/$name.svg'];
    if (svg == null) continue;
    await File('${dir.path}/${name.replaceAll('-', '_')}.svg').writeAsBytes(svg);
  }
}

Future<void> createFlutterFontMap() async {
  final sb = StringBuffer();

  final small = await getMap('small');
  final medium = await getMap('medium');
  final large = await getMap('large');
  void mapFont(String name, String value) => sb.writeln('  static const $name = $value;');

  sb.writeln('import \'package:flutter/material.dart\';');
  sb.writeln();
  sb.writeln('const sbbIconSizeSmall = 24.0;');
  sb.writeln('const sbbIconSizeMedium = 36.0;');
  sb.writeln('const sbbIconSizeLarge = 48.0;');
  sb.writeln();
  sb.writeln('const smallFontFamily = \'packages/sbb_design_system_mobile/SBBIconsSmall\';');
  sb.writeln('const mediumFontFamily = \'packages/sbb_design_system_mobile/SBBIconsMedium\';');
  sb.writeln('const largeFontFamily = \'packages/sbb_design_system_mobile/SBBIconsLarge\';');
  sb.writeln();
  sb.writeln('// The names are given by digital.sbb.ch');
  sb.writeln('// ignore_for_file: constant_identifier_names');
  sb.writeln('// dart format off');
  sb.writeln('sealed class SBBIcons {');
  small.entries.forEach((e) => mapFont(e.key, e.value));
  medium.entries.forEach((e) => mapFont(e.key, e.value));
  large.entries.forEach((e) => mapFont(e.key, e.value));
  sb.writeln('}');
  sb.writeln('// dart format on');

  await File('icons/sbb_icons.dart').writeAsString(sb.toString());

  void mapFont2(String name) => sb.writeln('    {\'icon\': SBBIcons.$name, \'name\': \'$name\'},');

  sb.clear();
  sb.writeln('import \'package:sbb_design_system_mobile/sbb_design_system_mobile.dart\';');
  sb.writeln();
  sb.writeln('// dart format off');
  sb.writeln('sealed class SBBIconsIndex {');
  sb.writeln('  static const iconsSmall = [');
  small.entries.forEach((e) => mapFont2(e.key));
  sb.writeln('  ];');
  sb.writeln('  static const iconsMedium = [');
  medium.entries.forEach((e) => mapFont2(e.key));
  sb.writeln('  ];');
  sb.writeln('  static const iconsLarge = [');
  large.entries.forEach((e) => mapFont2(e.key));
  sb.writeln('  ];');
  sb.writeln('}');
  sb.writeln('// dart format on');

  await File('icons/sbb_icons_index.dart').writeAsString(sb.toString());
}

Future<Map<String, String>> getMap(String type) async {
  final name = 'sbb_icons_$type';
  final fontFamily = '${type}FontFamily';
  final uri = Uri.parse('icons/$name.json');
  final file = File.fromUri(uri);
  final json = await file.readAsString();
  final map = jsonDecode(json) as Map<String, dynamic>;
  return map.map((key, value) {
    final v = value.toRadixString(16);
    return MapEntry(key, 'IconData(0x$v, fontFamily: $fontFamily)');
  });
}
