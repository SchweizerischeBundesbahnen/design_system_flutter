import 'package:version/version.dart';

final _versionTag = RegExp(r'^v(\d+)\.(\d+)\.(\d+)$');

/// Returns the highest semantic version among [tagNames], considering only tags of the form `vX.Y.Z`.
Version? latestVersionTag(Iterable<String> tagNames) {
  Version? latest;
  for (final name in tagNames) {
    final match = _versionTag.firstMatch(name);
    if (match == null) continue;
    final version = Version(int.parse(match[1]!), int.parse(match[2]!), int.parse(match[3]!));
    if (latest == null || version > latest) latest = version;
  }
  return latest;
}

const sizes = ['small', 'medium', 'large'];

/// Returns the unique icon names in [index] that are tagged with `Size=<size>`.
/// The index can list a name more than once, so a set is returned.
Set<String> iconNames(Map<String, dynamic> index, String size) {
  final icons = (index['icons'] as List<dynamic>).cast<Map<String, dynamic>>();
  return {
    for (final icon in icons)
      if ((icon['tags'] as List<dynamic>).contains('Size=$size')) icon['name'] as String,
  };
}

/// Checks that [index] belongs to [version] and that every sized icon has an SVG among [svgNames].
List<String> checkIndex(Map<String, dynamic> index, Version version, Set<String> svgNames) {
  final failures = <String>[];
  if (index['version'] != version.toString()) {
    failures.add('index.json has version ${index['version']}, expected $version from the tag');
  }
  for (final size in sizes) {
    final missing = iconNames(index, size).difference(svgNames);
    if (missing.isNotEmpty) failures.add('$size: no SVG in the archive for ${missing.join(', ')}');
  }
  return failures;
}
