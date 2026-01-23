import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SBBInternal {
  SBBInternal._();

  /// The default button height as in Figma is 44px, 32px respectively with an **inner** stroked border.
  ///
  /// If we draw the border on the inside, the splash will draw over the border. Hence we reduce by
  /// 2 logical px and add an outer margin of 1px on all sides (done in the corresponding Widgets).
  ///
  /// A custom splash factory will also draw over with long press.
  static const defaultButtonHeight = 42.0;
  static const defaultButtonHeightSmall = 30.0;

  static const defaultSegmentedButtonHeight = 44.0;
  static const defaultOnboardingButtonNavigationSpacingHeight = 44.0;
  static const defaultOnboardingButtonNavigationSpacingHeightSmall = 32.0;

  static const barrierColor = Color(0x80000000);

  static const defaultBoxShadow = <BoxShadow>[BoxShadow(color: Color(0x18000000), blurRadius: 15)];

  static const defaultDarkBoxShadow = <BoxShadow>[BoxShadow(color: Color(0xCC000000), blurRadius: 2)];

  static const defaultRedBoxShadow = <BoxShadow>[BoxShadow(color: Color(0x33000000), blurRadius: 2)];

  static const barrierBoxShadow = <BoxShadow>[BoxShadow(color: SBBInternal.barrierColor, blurRadius: 15)];
}

class SBBButtonContent extends StatelessWidget {
  const SBBButtonContent({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Flexible(
    child: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1),
  );
}
