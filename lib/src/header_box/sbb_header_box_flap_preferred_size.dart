import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/header_box/theme/default_sbb_header_box_theme_data.dart';

/// The default flap content for a SBB Header-Box with a preferred size.
///
/// {@macro @sbb_design_system.experimental}
///
/// Use this widget in conjunction with the [SBBHeaderBoxPreferredSize].
///
/// {@macro sbb_design_system.header_box_flap_description}
///
/// ## Customization
///
/// Use [style] to customize appearance of the flap, or
/// [SBBHeaderBoxThemeData] to apply consistent styling across your app:
///
/// ```dart
/// SBBHeaderBoxFlapPreferredSize(
///   labelText: 'Styled Label',
///   textScaler: MediaQuery.textScalerOf(context),
///   style: SBBHeaderBoxFlapStyle(
///     foregroundColor: Colors.blue,
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBHeaderBoxPreferredSize], for a way to use this widget.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/header-box)
class SBBHeaderBoxFlapPreferredSize extends StatelessWidget implements PreferredSizeWidget {
  const SBBHeaderBoxFlapPreferredSize({
    super.key,
    required this.textScaler,
    this.label,
    this.labelText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.padding,
    this.style,
  }) : assert(label != null || labelText != null, 'Either label or labelText must be provided'),
       assert(label == null || labelText == null, 'Only one of label or labelText can be set'),
       assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set'),
       assert(trailing == null || trailingIconData == null, 'Only one of trailing or trailingIconData can be set');

  /// {@macro sbb_design_system.header_box_flap.label}
  final PreferredSizeWidget? label;

  /// {@macro sbb_design_system.header_box_flap.labelText}
  final String? labelText;

  /// {@macro sbb_design_system.header_box_flap.leading}
  final PreferredSizeWidget? leading;

  /// {@macro sbb_design_system.header_box_flap.leadingIconData}
  final IconData? leadingIconData;

  /// {@macro sbb_design_system.header_box_flap.trailing}
  final PreferredSizeWidget? trailing;

  /// {@macro sbb_design_system.header_box_flap.trailingIconData}
  final IconData? trailingIconData;

  /// {@macro sbb_design_system.header_box_flap.padding}
  final EdgeInsetsGeometry? padding;

  /// {@macro sbb_design_system.header_box_flap.style}
  final SBBHeaderBoxFlapStyle? style;

  /// The text scaler to use for this widget. Required for accurate size calculations.
  ///
  /// Can usually be obtained using:
  ///
  /// ```
  /// MediaQuery.textScalerOf(context)
  /// ```
  final TextScaler textScaler;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: textScaler),
      child: SBBHeaderBoxFlap(
        label: label,
        labelText: labelText,
        leading: leading,
        leadingIconData: leadingIconData,
        trailing: trailing,
        trailingIconData: trailingIconData,
        padding: padding,
        style: style,
      ),
    );
  }

  @override
  Size get preferredSize {
    final style = DefaultSBBHeaderBoxThemeData.sbb.flapStyle!
        .merge(this.style)
        .copyWith(
          padding: padding,
        );
    final iconSize = IconThemeData.fallback().size!;

    final labelHeight = _calculateHeight(label, labelText, style.labelTextStyle, textScaler);
    final leadingHeight = leading?.preferredSize.height ?? (leadingIconData != null ? iconSize : 0.0);
    final trailingHeight = trailing?.preferredSize.height ?? (trailingIconData != null ? iconSize : 0.0);

    final baseHeight = math.max(math.max(labelHeight, leadingHeight), trailingHeight);

    return Size.fromHeight(baseHeight + style.padding!.vertical);
  }
}

double _calculateHeight<T>(PreferredSizeWidget? lhs, T rhs, TextStyle? textStyle, TextScaler textScaler) {
  if (lhs != null) {
    return lhs.preferredSize.height;
  }

  if (rhs != null && textStyle != null) {
    return textStyle.height! * textScaler.scale(textStyle.fontSize!);
  }

  return 0.0;
}
