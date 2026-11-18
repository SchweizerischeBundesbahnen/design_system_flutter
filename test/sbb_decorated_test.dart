import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('decorated', (WidgetTester tester) async {
    final tappableKey = ValueKey('tappableDecorated');
    final widget = Padding(
      padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: _decoratedItems(
          tappableItemKey: tappableKey,
          borderType: .standalone,
        ),
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated',
      find.byType(Column).first,
    );

    await tester.press(find.byKey(tappableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_pressed',
      find.byType(Column).first,
    );
  });

  testWidgets('decorated_listed', (WidgetTester tester) async {
    final tappableKey = ValueKey('tappableDecoratedListed');
    final widget = Builder(
      builder: (context) {
        return Padding(
          padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
          child: SBBContentBox(
            child: Column(
              mainAxisSize: .min,
              spacing: SBBSpacing.medium,
              children: SBBDivider.divideItems(
                context: context,
                items: _decoratedItems(
                  tappableItemKey: tappableKey,
                  borderType: .boxedOrListed,
                ),
              ),
            ),
          ),
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_listed',
      find.byType(Column).first,
    );

    await tester.press(find.byKey(tappableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_listed_pressed',
      find.byType(Column).first,
    );
  });

  testWidgets('decorated_boxed', (WidgetTester tester) async {
    final tappableKey = ValueKey('tappableDecoratedBoxed');
    final widget = Padding(
      padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBDecoratedBoxed(
            key: tappableKey,
            decoration: SBBDecoration(
              labelText: 'Default',
              leadingIconData: SBBIcons.unicorn_small,
            ),
            onTap: () {},
            child: const _Badge('Value'),
          ),
          SBBDecoratedBoxed(
            decoration: SBBDecoration(
              labelText: 'With Placeholder',
              placeholderText: 'Placeholder',
              leadingIconData: SBBIcons.unicorn_small,
            ),
            isEmpty: true,
            onTap: () {},
            child: const _Badge('Value'),
          ),
          SBBDecoratedBoxed(
            decoration: SBBDecoration(
              labelText: 'With Trailing Icon',
              leadingIconData: SBBIcons.unicorn_small,
              trailingIconData: SBBIcons.circle_information_small_small,
            ),
            onTap: () {},
            child: const _Badge('Value'),
          ),
          SBBDecoratedBoxed(
            decoration: SBBDecoration(
              labelText: 'Error',
              errorText: 'Error Text',
              leadingIconData: SBBIcons.unicorn_small,
            ),
            onTap: () {},
            child: const _Badge('With Error'),
          ),
          SBBDecoratedBoxed(
            decoration: SBBDecoration(
              labelText: 'Disabled',
              leadingIconData: SBBIcons.unicorn_small,
            ),
            child: const _Badge('Disabled'),
          ),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_boxed',
      find.byType(Column).first,
    );

    await tester.press(find.byKey(tappableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_boxed_pressed',
      find.byType(Column).first,
    );
  });

  testWidgets('decorated_layout', (WidgetTester tester) async {
    final widget = Padding(
      padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBDecorated(
            decoration: SBBDecoration(
              labelText: 'Min Content Height',
              leadingIconData: SBBIcons.dog_small,
              style: SBBDecorationStyle(borderType: .standalone),
            ),
            minContentHeight: 64.0,
            onTap: () {},
            child: const _Badge('Reserves 64px'),
          ),
          SBBDecorated(
            decoration: SBBDecoration(
              labelText: 'Top Aligned Affixes',
              leadingIconData: SBBIcons.dog_small,
              trailingIconData: SBBIcons.circle_information_small_small,
              style: SBBDecorationStyle(
                contentPadding: .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
                borderType: .standalone,
              ),
            ),
            topAlignAffixes: true,
            onTap: () {},
            child: const _TallContent(),
          ),
          SBBDecorated(
            decoration: SBBDecoration(
              labelText: 'Centered Affixes',
              leadingIconData: SBBIcons.dog_small,
              trailingIconData: SBBIcons.circle_information_small_small,
              style: SBBDecorationStyle(borderType: .standalone),
            ),
            onTap: () {},
            child: const _TallContent(),
          ),
          SBBDecorated(
            decoration: SBBDecoration(
              labelText: 'Empty With Tall Content',
              placeholderText: 'Placeholder',
              leadingIconData: SBBIcons.dog_small,
              trailingIconData: SBBIcons.circle_information_small_small,
              style: SBBDecorationStyle(borderType: .standalone),
            ),
            isEmpty: true,
            onTap: () {},
            child: const _TallContent(),
          ),
          SizedBox(
            height: 140.0,
            child: SBBDecorated(
              decoration: SBBDecoration(
                labelText: 'Expands',
                leadingIconData: SBBIcons.dog_small,
                errorText: 'Anchored to the bottom',
                style: SBBDecorationStyle(
                  contentPadding: EdgeInsets.only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
                  borderType: .standalone,
                ),
              ),
              expands: true,
              topAlignAffixes: true,
              onTap: () {},
              child: const _Badge('Fills the height'),
            ),
          ),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_layout',
      find.byType(Column).first,
    );
  });
}

List<Widget> _decoratedItems({required ValueKey<String> tappableItemKey, required SBBDecorationBorderType borderType}) {
  return [
    SBBDecorated(
      key: tappableItemKey,
      decoration: SBBDecoration(
        labelText: 'Default',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'Empty',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      isEmpty: true,
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'With Placeholder',
        placeholderText: 'Placeholder',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      isEmpty: true,
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'With Placeholder Widget',
        placeholder: const _Badge('Placeholder Widget'),
        style: SBBDecorationStyle(borderType: borderType),
      ),
      isEmpty: true,
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'With Leading Icon',
        leadingIconData: SBBIcons.dog_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'Custom Style',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      style: SBBDecoratedStyle(contentForegroundColor: const WidgetStatePropertyAll(SBBColors.granite)),
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'With Trailing Icon',
        leadingIconData: SBBIcons.dog_small,
        trailingIconData: SBBIcons.chevron_small_right_circle_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'Error',
        errorText: 'This is an error!',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTap: () {},
      child: const _Badge('Value'),
    ),
    SBBDecorated(
      decoration: SBBDecoration(
        labelText: 'Disabled',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      child: const _Badge('Value'),
    ),
  ];
}

/// A small arbitrary widget standing in for whatever a consumer supplies.
///
/// Deliberately not a design system component, so the goldens capture the layout of
/// [SBBDecorated] rather than the rendering of another widget. It inherits its text
/// color from the decorator, which is what makes the disabled goldens meaningful.
class _Badge extends StatelessWidget {
  const _Badge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: SBBSpacing.xxSmall,
      children: [
        Icon(SBBIcons.circle_tick_small, size: 16.0),
        Text(label),
      ],
    );
  }
}

/// Arbitrary content tall enough to show the difference between centered and
/// top-aligned affixes.
class _TallContent extends StatelessWidget {
  const _TallContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: SBBSpacing.xxSmall,
      children: [
        _Badge('First line'),
        _Badge('Second line'),
        _Badge('Third line'),
      ],
    );
  }
}
