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

  group('iconNames', () {
    test('returns the unique names tagged with the size', () {
      final index = {
        'icons': [
          {
            'name': 'arrow-turn-right-small',
            'tags': ['Size=small'],
          },
          {
            'name': 'arrow-turn-right-small',
            'tags': ['Size=small'],
          },
          {
            'name': 'bike-small',
            'tags': ['Size=small', 'Bike'],
          },
          {
            'name': 'bike-medium',
            'tags': ['Size=medium'],
          },
          {
            'name': 'sbb-logo',
            'tags': ['Logo'],
          },
        ],
      };

      expect(iconNames(index, 'small'), {'arrow-turn-right-small', 'bike-small'});
      expect(iconNames(index, 'medium'), {'bike-medium'});
      expect(iconNames(index, 'large'), isEmpty);
    });
  });

  group('checkIndex', () {
    final index = {
      'version': '1.8.38',
      'icons': [
        {
          'name': 'bike-small',
          'tags': ['Size=small'],
        },
        {
          'name': 'bike-medium',
          'tags': ['Size=medium'],
        },
        {
          'name': 'bike-large',
          'tags': ['Size=large'],
        },
        {
          'name': 'sbb-logo',
          'tags': ['Logo'],
        },
      ],
    };

    test('passes when the version matches and every sized icon has an SVG', () {
      final svgs = {'bike-small', 'bike-medium', 'bike-large'};

      expect(checkIndex(index, Version(1, 8, 38), svgs), isEmpty);
    });

    test('reports a version that differs from the tag', () {
      final svgs = {'bike-small', 'bike-medium', 'bike-large'};

      expect(checkIndex(index, Version(1, 8, 39), svgs), [
        'index.json has version 1.8.38, expected 1.8.39 from the tag',
      ]);
    });

    test('reports sized icons without an SVG per size', () {
      final svgs = {'bike-medium'};

      expect(checkIndex(index, Version(1, 8, 38), svgs), [
        'small: no SVG in the archive for bike-small',
        'large: no SVG in the archive for bike-large',
      ]);
    });
  });

  group('checkGlyphs', () {
    final expected = {'arrow-turn-right-small', 'bike-small', 'train-small'};

    test('passes when every expected icon has exactly one glyph', () {
      final glyphs = ['arrow_turn_right_small', 'bike_small', 'train_small'];

      expect(checkGlyphs('small', expected, glyphs), isEmpty);
    });

    test('reports missing glyphs with the counts', () {
      final glyphs = ['bike_small'];

      expect(checkGlyphs('small', expected, glyphs), [
        'small: 1 glyphs, expected 3; missing arrow_turn_right_small, train_small',
      ]);
    });

    test('reports unexpected glyphs with the counts', () {
      final glyphs = ['arrow_turn_right_small', 'bike_small', 'train_small', 'tram_small'];

      expect(checkGlyphs('small', expected, glyphs), ['small: 4 glyphs, expected 3; unexpected tram_small']);
    });
  });
}
