import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/header_box/header_box_content.dart';
import 'package:sbb_design_system_mobile/src/header_box/theme/default_sbb_header_box_theme_data.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';

/// The SBB Header-Box with a predictable size.
///
/// {@template @sbb_design_system.experimental}
/// **⚠️ Experimental:** This API is experimental and may change or be removed
/// in any future release without notice. Let us know what you think.
/// {@endtemplate}
///
/// Behaves the same as [SBBHeaderBox] but implements [PreferredSizeWidget] and can therefore be used for
/// [SBBHeaderSmall.bottom]. This has the benefit of cleaner scrolling effects (no distortion) but imposes some additional
/// constraints due to how [PreferredSizeWidget]s work.
///
/// Important caveats:
///
/// - Contextual style changes are ignored ([SBBHeaderBoxThemeData]). Use the [style] parameter instead.
/// - A text scaler is required to estimate accurate heights.
/// - All text arguments are limited to a single line.
/// - Only compatible with [SBBHeaderSmall].
///
/// ## Sample code
///
/// ```dart
/// SBBHeaderSmall(
///   titleText: 'Title',
///   bottom: SBBHeaderBoxPreferredSize(
///     titleText: 'This works',
///     textScaler: MediaQuery.textScalerOf(context),
///   ),
/// )
/// ```
///
/// ## Customization
///
/// Use [style] to customize the appearance of a single header box, or [SBBHeaderBoxThemeData] to apply consistent
/// styling across your app. However, changes in [SBBHeaderBoxThemeData] will **not be used for size calculations.**
///
/// ```dart
/// SBBHeaderBoxPreferredSize(
///   leadingIconData: SBBIcons.unicorn_small,
///   titleText: 'Title',
///   style: SBBHeaderBoxStyle(
///     titleForegroundColor: Colors.white,
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBHeaderBox], for the normal variant.
///  * [SBBSliverHeaderBox], for a sliver variant that can be used inside scroll views.
///  * [SBBHeaderBoxFlapPreferredSize], for flap content.
///  * [SBBHeaderSmall], for a place to use this widget in.
///  * [SBBHeaderBoxStyle], for customizing the appearance.
///  * [SBBHeaderBoxThemeData], for setting header box theme properties across your app.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/header-box)
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?m=auto&node-id=192-861&t=rQTLXnChqHrpKLB4-1) (internal only)
class SBBHeaderBoxPreferredSize extends StatelessWidget implements PreferredSizeWidget {
  SBBHeaderBoxPreferredSize({
    super.key,
    required this.textScaler,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.flap,
    this.body,
    this.isLoading = false,
    this.margin,
    this.padding,
    this.style,
    this.semanticsLabel,
  }) : assert(title != null || titleText != null || body != null, 'Either title or titleText or body must be provided'),
       assert(title == null || titleText == null, 'Only one of title or titleText can be set'),
       assert(subtitle == null || subtitleText == null, 'Only one of subtitle or subtitleText can be set'),
       assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set');

  /// {@macro sbb_design_system.header_box.leading}
  final PreferredSizeWidget? leading;

  /// {@macro sbb_design_system.header_box.leadingIconData}
  final IconData? leadingIconData;

  /// {@macro sbb_design_system.header_box.title}
  final PreferredSizeWidget? title;

  /// {@macro sbb_design_system.header_box.titleText}
  final String? titleText;

  /// {@macro sbb_design_system.header_box.subtitle}
  final PreferredSizeWidget? subtitle;

  /// {@macro sbb_design_system.header_box.subtitleText}
  ///
  /// Limited to a single line.
  final String? subtitleText;

  /// {@macro sbb_design_system.header_box.trailing}
  ///
  /// For usability reasons, [trailing] is not required to be a [PreferredSizeWidget]. It will be constrained in size
  /// to prevent overflow.
  final Widget? trailing;

  /// {@macro sbb_design_system.header_box.body}
  final PreferredSizeWidget? body;

  /// {@macro sbb_design_system.header_box.flap}
  final PreferredSizeWidget? flap;

  /// {@macro sbb_design_system.header_box.isLoading}
  final bool isLoading;

  /// {@macro sbb_design_system.header_box.margin}
  final EdgeInsetsGeometry? margin;

  /// {@macro sbb_design_system.header_box.padding}
  final EdgeInsetsGeometry? padding;

  /// {@macro sbb_design_system.header_box.style}
  final SBBHeaderBoxStyle? style;

  /// {@macro sbb_design_system.header_box.semanticsLabel}
  final String? semanticsLabel;

  /// The text scaler to use for this widget. Required for accurate size calculations.
  ///
  /// Can usually be obtained using:
  ///
  /// ```
  /// MediaQuery.textScalerOf(context)
  /// ```
  final TextScaler textScaler;

  // Lazy cached computation of preferred size to do as little work as possible
  late final Size _preferredSize = _computePreferredSize();

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasSBBBaseStyle(context));

    final color = Theme.of(context).canvasColor;

    return MediaQuery(
      // Make sure that the passed text scaler is also what is being used
      data: MediaQuery.of(context).copyWith(textScaler: textScaler),
      child: Container(
        color: color,
        child: SBBHeaderBox(
          leading: leading,
          leadingIconData: leadingIconData,
          title: title,
          titleText: titleText,
          subtitle: _resolveSubtitle(),
          trailing: _resolveTrailing(context),
          flap: flap,
          body: body,
          isLoading: isLoading,
          margin: margin,
          padding: padding,
          style: style,
          semanticsLabel: semanticsLabel,
        ),
      ),
    );
  }

  // Ensure one-line subtitle
  Widget? _resolveSubtitle() {
    if (subtitle != null) {
      return subtitle;
    }

    if (subtitleText != null) {
      return Text(
        subtitleText!,
        maxLines: 1,
        overflow: .ellipsis,
      );
    }

    return null;
  }

  Widget? _resolveTrailing(BuildContext context) {
    if (trailing == null) {
      return null;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: _baseHeight(_resolveStyle(context))),
      child: trailing,
    );
  }

  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return Theme.of(context).sbbHeaderBoxTheme.style!.merge(style).copyWith(margin: margin, padding: padding);
  }

  double _baseHeight(SBBHeaderBoxStyle style) {
    return HeaderBoxContent.calculateHeight(
      style: style,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      leading: leading,
      leadingIconData: leadingIconData,
      textScaler: textScaler,
    );
  }

  Size _computePreferredSize() {
    final theme = DefaultSBBHeaderBoxThemeData.sbb;
    final style = theme.style!.merge(this.style).copyWith(padding: padding, margin: margin);

    // Base height
    double height = _baseHeight(style);

    // Body attachment
    if (body != null) {
      height += body!.preferredSize.height;
    }

    // Paddings
    height += style.padding!.vertical;
    height = max(height, SBBHeaderBoxStyle.minHeight);
    height += style.margin!.vertical;

    // Flap
    if (flap != null) {
      height += flap!.preferredSize.height;
    }

    return Size.fromHeight(height);
  }

  @override
  Size get preferredSize => _preferredSize;
}
