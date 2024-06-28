import 'dart:convert';
import 'dart:io';

import 'package:console_bars/console_bars.dart';
import 'package:http/http.dart';
import 'package:version/version.dart';

final baseUri = Uri.https('icons.app.sbb.ch');
final basePath = ['icons'];

late FillingBar progress;

Future<void> main() async {
  final uri = makeUrlUri('index.json');
  final response = await get(uri);
  final decoded = utf8.decode(response.bodyBytes);
  final responseJson = jsonDecode(decoded);
  final versionFile = File('icons/.version');
  final newVersion = responseJson['version'];

  print('Version: $newVersion');
  if (await versionFile.exists()) {
    final oldVersion = await versionFile.readAsString();
    if (Version.parse(oldVersion) >= Version.parse(newVersion)) {
      print('already imported. exiting…');
      return;
    }
  }

  final icons = responseJson['icons'] as List<dynamic>;
  final total = icons
      .cast<Map<String, dynamic>>()
      .where((e) =>
          (e['tags'] as List).cast<String>().any((t) => t.contains('Size=')))
      .length;
  progress = FillingBar(total: total + 4, width: 10, desc: 'Downloading icons');

  await prepareIcons('small', icons);
  await prepareIcons('medium', icons);
  await prepareIcons('large', icons);

  await Directory('icons/small').create(recursive: true);
  await Directory('icons/medium').create(recursive: true);
  await Directory('icons/large').create(recursive: true);

  progress.desc = 'Preparing ttf files';
  await Process.run('npm', ['install'], runInShell: true);
  progress.increment();
  await Process.run('npm', ['run', 'fix'], runInShell: true);
  progress.increment();
  await Process.run('npm', ['run', 'generate'], runInShell: true);
  progress.increment();
  progress.desc = 'Generating dart files';
  await createFlutterFontMap();
  progress.increment();

  await File('icons/.version').writeAsString(newVersion);
  await Directory('icons/small').delete(recursive: true);
  await Directory('icons/small-tmp').delete(recursive: true);
  await Directory('icons/medium').delete(recursive: true);
  await Directory('icons/medium-tmp').delete(recursive: true);
  await Directory('icons/large').delete(recursive: true);
  await Directory('icons/large-tmp').delete(recursive: true);
  await File('icons/sbb_icons_small.json').delete();
  await File('icons/sbb_icons_medium.json').delete();
  await File('icons/sbb_icons_large.json').delete();
}

Uri makeUrlUri(String path) {
  final uri = Uri(pathSegments: basePath.followedBy([path]));
  return baseUri.resolveUri(uri);
}

Future<void> prepareIcons(String type, List<dynamic> icons) async {
  final filter = icons.where((e) => e['tags'].contains('Size=$type'));
  final dir = await Directory('icons/$type-tmp').create(recursive: true);
  final downloads = <Future<void>>[];
  for (final icon in filter) {
    final name = icon['name'];
    final fileName = '$name.svg';
    final svgUri = makeUrlUri(fileName);
    final download = downloadSvg(
      svgUri,
      fileName.replaceAll('-', '_'),
      dir.path,
    );
    downloads.add(download);
  }

  await Future.wait(downloads);
}

Future<void> downloadSvg(Uri uri, String fileName, String path) async {
  final svg = await get(uri);
  await File('$path/$fileName').writeAsBytes(svg.bodyBytes);
  progress.increment();
}

Future<void> createFlutterFontMap() async {
  final sb = StringBuffer();

  final small = await getMap('small');
  final medium = await getMap('medium');
  final large = await getMap('large');
  mapFont(String name, String value) =>
      sb.writeln('  static const ${name} = $value;');

  sb.writeln('library sbb_icons;');
  sb.writeln();
  sb.writeln('import \'package:flutter/material.dart\';');
  sb.writeln();
  sb.writeln('const sbbIconSizeSmall = 24.0;');
  sb.writeln('const sbbIconSizeMedium = 36.0;');
  sb.writeln('const sbbIconSizeLarge = 48.0;');
  sb.writeln();
  sb.writeln('const smallFontFamily = \'packages/design_system_flutter/SBBIconsSmall\';');
  sb.writeln('const mediumFontFamily = \'packages/design_system_flutter/SBBIconsMedium\';');
  sb.writeln('const largeFontFamily = \'packages/design_system_flutter/SBBIconsLarge\';');
  sb.writeln();
  sb.writeln('// The names are given by digital.sbb.ch');
  sb.writeln('// ignore_for_file: prefer_final_fields');
  sb.writeln('sealed class SBBIcons {');
  small.entries.forEach((e) => mapFont(e.key, e.value));
  medium.entries.forEach((e) => mapFont(e.key, e.value));
  large.entries.forEach((e) => mapFont(e.key, e.value));
  sb.writeln('}');

  await File('icons/sbb_icons.dart').writeAsString(sb.toString());

  mapFont2(String name) =>
      sb.writeln('    {\'icon\': SBBIcons.$name, \'name\': \'$name\'},');

  sb.clear();
  sb.writeln('import \'package:design_system_flutter/design_system_flutter.dart\';');
  sb.writeln();
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
