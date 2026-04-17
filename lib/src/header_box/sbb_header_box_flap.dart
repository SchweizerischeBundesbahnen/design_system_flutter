import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default flap content for a SBB Header-Box.
///
/// Use this widget in conjunction with the [SBBHeaderBox] or any of its variants.
///
/// Provide either [label] for custom content or [labelText] for text-only content with
/// standard styling. These parameters are mutually exclusive.
///
/// Leading and trailing icons can be provided either as custom [Widget]s via [leading] and
/// [trailing], or as [IconData] via [leadingIconData] and [trailingIconData]. These parameter
/// pairs are mutually exclusive.
///
/// ## Customization
///
/// Use [style] to customize appearance of the flap, or
/// [SBBHeaderBoxThemeData] to apply consistent styling across your app:
///
/// ```dart
/// SBBHeaderBoxFlap(
///   labelText: 'Styled Label',
///   style: SBBHeaderBoxFlapStyle(
///     foregroundColor: Colors.blue,
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBHeaderBox], for a way to use this widget.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/header-box)
class SBBHeaderBoxFlap extends StatelessWidget {
  const SBBHeaderBoxFlap({
    super.key,
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

  /// A custom widget displayed as the flap's label.
  ///
  /// For simple text labels, use [labelText] instead.
  ///
  /// The label is vertically centered with [leading] or [leadingIconData].
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// Text string to display as the flap's label using standard styling.
  ///
  /// The text is clamped to a single line with ellipsis overflow.
  /// The label is vertically centered with [leading] or [leadingIconData].
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed as the flap's leading content.
  ///
  /// For simple icons, use [leadingIconData] instead.
  ///
  /// The Widget is vertically centered with [labelText] or [label].
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon data for the leading icon.
  ///
  /// The icon is vertically centered with [labelText] or [label].
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// A custom widget displayed as the flap's trailing content.
  ///
  /// For simple icons, use [trailingIconData] instead.
  ///
  /// Cannot be used together with [trailingIconData].
  final Widget? trailing;

  /// Icon data for the trailing icon.
  ///
  /// Cannot be used together with [trailing].
  final IconData? trailingIconData;

  /// Padding around the flap's content.
  final EdgeInsetsGeometry? padding;

  /// Customizes this flap's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBHeaderBoxThemeData.flapStyle] of the theme found in [context].
  final SBBHeaderBoxFlapStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (Theme.of(context).sbbHeaderBoxTheme!.flapStyle ?? SBBHeaderBoxFlapStyle())
        .merge(style)
        .copyWith(padding: padding);

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

  Widget _resolveTitle() {
    if (labelText != null) {
      return Text(
        labelText!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return label!;
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
