import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/header_box/sbb_header_box_content.dart';
import 'package:sbb_design_system_mobile/src/shared/bottom_loading_indicator.dart';

import '../../sbb_design_system_mobile.dart';

/// The default [SBBHeaderBox].
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/container/)
///
/// To place over non scrollable screen content, place this Widget in a [Stack] with the content underneath.
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return Stack(
///     children: [
///       _PageContentWidget(),
///       SBBHeaderBox(
///         title: 'Awesome Headerbox'
///       ),
///     ],
///   );
/// }
/// ```
///
/// This will lead to the expected behavior of the header box.
///
/// See [SBBSliverHeaderBox] for a headerbox that behaves as expected in scrollable content,
/// or [SBBSliverFloatingHeaderBox] for a fully dynamic version in scrolling contexts.
class SBBHeaderBox extends StatelessWidget {
  const SBBHeaderBox({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.flap,
    this.isLoading = false,
    this.margin,
    this.padding,
    this.style,
    this.semanticsLabel,
  }) : assert(title != null || titleText != null, 'Either title or titleText must be provided'),
       assert(title == null || titleText == null, 'Only one of title or titleText can be set'),
       assert(subtitle == null || subtitleText == null, 'Only one of subtitle or subtitleText can be set'),
       assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set');

  /// {@template sbb_design_system.header_box.leading}
  /// A custom widget displayed as the header box's leading content.
  ///
  /// For simple icons, use [leadingIconData] instead.
  ///
  /// The Widget is vertically centered with [titleText] or [title].
  ///
  /// Cannot be used together with [leadingIconData].
  /// {@endtemplate}
  final Widget? leading;

  /// {@template sbb_design_system.header_box.leadingIconData}
  /// Icon data for the leading icon.
  ///
  /// The icon is vertically centered with [titleText] or [title].
  ///
  /// Cannot be used together with [leading].
  /// {@endtemplate}
  final IconData? leadingIconData;

  /// {@template sbb_design_system.header_box.title}
  /// A custom widget displayed as the header box's title.
  ///
  /// For simple text labels, use [titleText] instead.
  ///
  /// The title is vertically centered with [leading] or [leadingIconData].
  ///
  /// Cannot be used together with [titleText].
  /// {@endtemplate}
  final Widget? title;

  /// {@template sbb_design_system.header_box.titleText}
  /// Text string to display as the header box's title using standard styling.
  ///
  /// The text is clamped to a single line with ellipsis overflow.
  /// The title is vertically centered with [leading] or [leadingIconData].
  ///
  /// Cannot be used together with [title].
  /// {@endtemplate}
  final String? titleText;

  /// {@template sbb_design_system.header_box.subtitle}
  /// A custom widget displayed as the header box's subtitle below the title.
  ///
  /// For simple text labels, use [subtitleText] instead.
  ///
  /// Cannot be used together with [subtitleText].
  /// {@endtemplate}
  final Widget? subtitle;

  /// {@template sbb_design_system.header_box.subtitleText}
  /// Text string to display as the header box's subtitle using standard styling.
  ///
  /// The subtitle is positioned below the title and leading widget.
  ///
  /// Cannot be used together with [subtitle].
  /// {@endtemplate}
  final String? subtitleText;

  /// {@template sbb_design_system.header_box.trailing}
  /// A custom widget displayed as the header box's trailing content.
  ///
  /// This generally is a [SBBTertiaryButtonSmall].
  ///
  /// [trailing] is vertically centered relative to the header box.
  /// {@endtemplate}
  final Widget? trailing;

  /// {@template sbb_design_system.header_box.flap}
  /// The content to display inside the flap below the header box.
  ///
  /// You may use [SBBHeaderBoxFlap] to achieve the default look.
  ///
  /// When not set, no flap will be displayed.
  /// {@endtemplate}
  final Widget? flap;

  /// {@template sbb_design_system.header_box.isLoading}
  /// Whether to show a loading indicator at the bottom of the header box.
  ///
  /// When true, a [BottomLoadingIndicator] is displayed at the bottom of the header box.
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool isLoading;

  /// {@template sbb_design_system.header_box.margin}
  /// The empty space that surrounds the header box.
  ///
  /// If this property is null then [SBBHeaderBoxStyle.margin] is used.
  /// {@endtemplate}
  final EdgeInsetsGeometry? margin;

  /// {@template sbb_design_system.header_box.padding}
  /// The empty space that separates the [child] and the edge of [SBBContentBox].
  ///
  /// If this property is null then [SBBHeaderBoxStyle.padding] is used.
  /// {@endtemplate}
  final EdgeInsetsGeometry? padding;

  /// {@template sbb_design_system.header_box.style}
  /// Customizes this header box appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBHeaderBoxThemeData.style] of the theme found in [context].
  /// {@endtemplate}
  final SBBHeaderBoxStyle? style;

  /// {@template sbb_design_system.header_box.semanticsLabel}
  /// The semantic label for the header box that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  /// {@endtemplate}
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).sbbHeaderBoxTheme;
    final effectiveStyle = (themeData?.style ?? SBBHeaderBoxStyle())
        .merge(style)
        .merge(
          SBBHeaderBoxStyle(
            margin: margin,
            padding: padding,
          ),
        );

    return _HeaderBoxAppBarInset(
      style: effectiveStyle,
      child: _HeaderBoxForeground(
        style: effectiveStyle,
        flap: flap,
        semanticsLabel: semanticsLabel,
        isLoading: isLoading,
        child: DefaultHeaderBoxContent(
          leading: leading,
          leadingIconData: leadingIconData,
          title: title,
          titleText: titleText,
          subtitle: subtitle,
          subtitleText: subtitleText,
          trailing: trailing,
          style: effectiveStyle,
        ),
      ),
    );
  }
}

class SBBHeaderBoxLarge extends StatelessWidget {
  const SBBHeaderBoxLarge({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.flap,
    this.isLoading = false,
    this.margin,
    this.padding,
    this.style,
    this.semanticsLabel,
  }) : assert(title != null || titleText != null, 'Either title or titleText must be provided'),
       assert(title == null || titleText == null, 'Only one of title or titleText can be set'),
       assert(subtitle == null || subtitleText == null, 'Only one of subtitle or subtitleText can be set'),
       assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set');

  /// {@macro sbb_design_system.header_box.leading}
  final Widget? leading;

  /// {@macro sbb_design_system.header_box.leadingIconData}
  final IconData? leadingIconData;

  /// {@macro sbb_design_system.header_box.title}
  final Widget? title;

  /// {@macro sbb_design_system.header_box.titleText}
  final String? titleText;

  /// {@macro sbb_design_system.header_box.subtitle}
  final Widget? subtitle;

  /// {@macro sbb_design_system.header_box.subtitleText}
  final String? subtitleText;

  /// {@macro sbb_design_system.header_box.trailing}
  final Widget? trailing;

  /// {@macro sbb_design_system.header_box.flap}
  final Widget? flap;

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

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).sbbHeaderBoxTheme;
    final effectiveStyle = (themeData?.largeStyle ?? SBBHeaderBoxStyle()).merge(style);

    return _HeaderBoxAppBarInset(
      style: effectiveStyle,
      child: _HeaderBoxForeground(
        style: effectiveStyle,
        flap: flap,
        semanticsLabel: semanticsLabel,
        isLoading: isLoading,
        child: LargeHeaderBoxContent(
          leading: leading,
          leadingIconData: leadingIconData,
          title: title,
          titleText: titleText,
          subtitle: subtitle,
          subtitleText: subtitleText,
          trailing: trailing,
          style: effectiveStyle,
        ),
      ),
    );
  }
}

class _HeaderBoxForeground extends StatelessWidget {
  const _HeaderBoxForeground({
    required this.child,
    required this.style,
    this.semanticsLabel,
    this.flap,
    this.isLoading = false,
  });

  final SBBHeaderBoxStyle style;
  final Widget child;
  final String? semanticsLabel;
  final Widget? flap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: semanticsLabel,
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(
          boxShadow: style.headerBoxShadow,
          borderRadius: SBBHeaderBoxStyle.radius,
          color: style.flapBackgroundColor,
        ),
        child: Column(
          mainAxisSize: .min,
          children: [
            _headerBox(context, style),
            ?flap,
          ],
        ),
      ),
    );
  }

  Widget _headerBox(BuildContext context, SBBHeaderBoxStyle style) {
    return Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: SBBHeaderBoxStyle.radius,
        boxShadow: flap != null ? style.shadowOverFlap : null,
      ),
      child: Stack(
        children: [
          Container(
            padding: style.padding ?? EdgeInsets.zero,
            constraints: BoxConstraints(minHeight: SBBHeaderBoxStyle.minHeight, minWidth: .infinity),
            child: child,
          ),
          if (isLoading)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomLoadingIndicator(),
            ),
        ],
      ),
    );
  }
}

class _HeaderBoxAppBarInset extends StatelessWidget {
  const _HeaderBoxAppBarInset({
    super.key,
    required this.style,
    required this.child,
  });

  final SBBHeaderBoxStyle style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Align(
          alignment: .topCenter,
          child: Container(
            color: theme.appBarTheme.backgroundColor,
            height: style.appBarOverlap,
          ),
        ),
        Padding(
          padding: style.margin ?? EdgeInsets.zero,
          child: child,
        ),
      ],
    );
  }
}
