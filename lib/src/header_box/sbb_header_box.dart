import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/shared/bottom_loading_indicator.dart';

import '../../sbb_design_system_mobile.dart';
import 'header_box_content.dart';
import 'header_box_foreground.dart';
import 'header_box_inset.dart';

/// The SBB Header-Box.
///
/// Provides a flexible layout with optional leading, title, subtitle, trailing, and body widgets.
/// The title and leading widgets are center-aligned vertically, with the subtitle positioned
/// below them. The body can be used for additional content shown below the titles.
///
/// Provide either [title] for custom content or [titleText] for text-only content with
/// standard styling. These parameters are mutually exclusive.
///
///
///
/// ## Customization
///
/// Use [style] to customize appearance for a specific header box, or
/// [SBBHeaderBoxThemeData] to apply consistent styling across your app:
///
/// ```dart
/// SBBHeaderBox(
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
///  * [SBBHeaderBoxLarge], for a larger variant.
///  * [SBBSliverHeaderBox], for a sliver variant that can be used inside scroll views.
///  * [SBBHeaderBoxStyle], for customizing the appearance.
///  * [SBBHeaderBoxThemeData], for setting header box theme properties across your app.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/header-box)
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?m=auto&node-id=192-861&t=rQTLXnChqHrpKLB4-1) (internal only)
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

  /// {@template sbb_design_system.header_box.body}
  /// A custom widget displayed as the body of the header box.
  ///
  /// This will be displayed below the title and subtitle, if any are set.
  /// {@endtemplate}
  final Widget? body;

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

  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return (Theme.of(context).sbbHeaderBoxTheme?.style ?? SBBHeaderBoxStyle())
        .merge(style)
        .copyWith(margin: margin, padding: padding);
  }

  Widget? _resolveContent(BuildContext context) {
    if (title == null && titleText == null) {
      return null;
    }

    return DefaultHeaderBoxContent(
      leading: leading,
      leadingIconData: leadingIconData,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      style: _resolveStyle(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _resolveStyle(context);
    Widget? contentWidget = _resolveContent(context);

    if (body != null) {
      if (contentWidget != null) {
        contentWidget = Column(
          children: [
            contentWidget,
            body!,
          ],
        );
      } else {
        contentWidget = body;
      }
    }

    return HeaderBoxAppBarInset(
      style: effectiveStyle,
      child: HeaderBoxForeground(
        style: effectiveStyle,
        flap: flap,
        semanticsLabel: semanticsLabel,
        isLoading: isLoading,
        child: contentWidget!,
      ),
    );
  }
}

class SBBHeaderBoxLarge extends SBBHeaderBox {
  const SBBHeaderBoxLarge({
    super.key,
    super.leading,
    super.leadingIconData,
    super.title,
    super.titleText,
    super.subtitle,
    super.subtitleText,
    super.trailing,
    super.body,
    super.flap,
    super.isLoading = false,
    super.margin,
    super.padding,
    super.style,
    super.semanticsLabel,
  });

  @override
  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return (Theme.of(context).sbbHeaderBoxTheme?.largeStyle ?? SBBHeaderBoxStyle())
        .merge(style)
        .copyWith(margin: margin, padding: padding);
  }

  @override
  Widget? _resolveContent(BuildContext context) {
    if (title == null && titleText == null) {
      return null;
    }

    return LargeHeaderBoxContent(
      leading: leading,
      leadingIconData: leadingIconData,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      style: _resolveStyle(context),
    );
  }
}
