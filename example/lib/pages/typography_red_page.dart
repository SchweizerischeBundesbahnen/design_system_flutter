import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class TypographyRedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = SBBBaseStyle.of(context).redTextTheme;
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        _TypographyExample(
          'Large',
          textTheme.titleLarge!,
          textTheme.bodyLarge!,
        ),
        const SizedBox(height: sbbDefaultSpacing),
        _TypographyExample(
          'Medium',
          textTheme.titleMedium!,
          textTheme.bodyMedium!,
        ),
        const SizedBox(height: sbbDefaultSpacing),
        _TypographyExample(
          'Small',
          textTheme.titleSmall!,
          textTheme.bodySmall!,
        ),
      ],
    );
  }
}

class _TypographyExample extends StatelessWidget {
  const _TypographyExample(
    this.name,
    this.titleStyle,
    this.style,
  );

  final String name;
  final TextStyle titleStyle;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SBBListHeader(name, textStyle: titleStyle),
        SBBGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: Text(
                  'The quick brown fox jumps over the lazy dog',
                  style: style,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: Text(
                  'FontSize: ${style.fontSize}\n'
                  'Height: ${style.height?.toStringAsFixed(2)}',
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
