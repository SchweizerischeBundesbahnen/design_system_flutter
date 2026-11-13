import 'package:font_script/checks.dart';
import 'package:test/test.dart';
import 'package:version/version.dart';

void main() {
  group('latestVersionTag', () {
    test('returns the highest vX.Y.Z tag by semver', () {
      final tags = ['v1.8.9', 'v1.8.38', 'v1.10.0', 'v1.9.99'];

      expect(latestVersionTag(tags), Version(1, 10, 0));
    });

    test('ignores tags that are not vX.Y.Z', () {
      final tags = ['v1.8.38', 'v2.0.0-beta.1', '2.0.0', 'v2', 'latest', 'v2.0.0.1'];

      expect(latestVersionTag(tags), Version(1, 8, 38));
    });

    test('returns null without any vX.Y.Z tag', () {
      expect(latestVersionTag(['latest', 'main']), isNull);
    });
  });
}
