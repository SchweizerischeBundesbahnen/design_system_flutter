import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Use in combination with the [SBBHeaderBox] for the [flap] argument.
///
/// See [HeaderBox in documentation](https://digital.sbb.ch/de/design-system/mobile/components/container/).
///
/// For a complete custom variant, use the [custom] constructor.
class SBBHeaderBoxFlap extends StatelessWidget {
  const SBBHeaderBoxFlap({
    super.key,
    this.label,
    this.labelText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.style,
  }) : assert(label != null || labelText != null, 'Either title or titleText must be provided'),
       assert(label == null || labelText == null, 'Only one of title or titleText can be set'),
       assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set'),
       assert(trailing == null || trailingIconData == null, 'Only one of subtitle or subtitleText can be set');

  final Widget? label;
  final String? labelText;

  final Widget? leading;
  final IconData? leadingIconData;

  final Widget? trailing;
  final IconData? trailingIconData;

  final SBBHeaderBoxFlapStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (Theme.of(context).sbbHeaderBoxTheme!.flapStyle ?? SBBHeaderBoxFlapStyle()).merge(style);

    final leadingWidget = _addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.leadingForegroundColor,
      textStyle: effectiveStyle.leadingTextStyle,
      child: _resolveLeading(effectiveStyle),
    );
    final labelWidget = _addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.labelForegroundColor,
      textStyle: effectiveStyle.labelTextStyle,
      child: _resolveTitle(),
    );
    final trailingWidget = _addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.trailingForegroundColor,
      textStyle: effectiveStyle.trailingTextStyle,
      child: _resolveTrailing(effectiveStyle),
    );

    return Padding(
      padding: effectiveStyle.padding ?? EdgeInsets.zero,
      child: Row(
        spacing: SBBSpacing.xSmall,
        children: [
          ?leadingWidget,
          Expanded(
            child: labelWidget!,
          ),
          ?trailingWidget,
        ],
      ),
    );
  }

  Widget? _resolveLeading(SBBHeaderBoxFlapStyle style) {
    if (leadingIconData != null) {
      return Icon(leadingIconData, size: style.iconSize);
    }

    return leading;
  }

  Widget? _resolveTitle() {
    if (labelText != null) {
      return Text(labelText!);
    }

    return label;
  }

  Widget? _resolveTrailing(SBBHeaderBoxFlapStyle style) {
    if (trailingIconData != null) {
      return Icon(trailingIconData, size: style.iconSize);
    }

    return trailing;
  }

  Widget? _addDefaultAncestorWithResolved({
    Widget? child,
    Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    if (child == null) {
      return null;
    }

    final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);

    child = DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
    return child;
  }
}
