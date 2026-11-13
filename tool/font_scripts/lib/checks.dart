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
