import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/shared/bottom_loading_indicator.dart';

import '../../sbb_design_system_mobile.dart';
import 'header_box_app_bar_inset.dart';
import 'header_box_content.dart';
import 'header_box_foreground.dart';

/// The SBB Header-Box.
///
/// A prominent container used to present page-related information at the top of
/// a screen. It supports optional leading, title, subtitle, trailing, body, and
/// flap content.
///
/// The title row aligns the [leading] and [title] vertically. If a subtitle is
/// provided, it is displayed below the title row. Additional [body] content is
/// rendered below the title/subtitle area.
///
/// {@template sbb_design_system.header_box_description}
/// Provide either [title] for fully custom title content or [titleText] for a
/// simple text title with standard styling. These parameters are mutually
/// exclusive.
///
/// Optionally, provide either [subtitle] for fully custom subtitle content or
/// [subtitleText] for a simple text subtitle with standard styling. These
/// parameters are mutually exclusive.
///
/// Leading content can be supplied either as a custom widget via [leading] or
/// as an icon via [leadingIconData]. These parameters are mutually exclusive.
///
/// Trailing content can be supplied via [trailing].
///
/// When [flap] is provided, it is displayed below the header box as an attached
/// extension area.
///
/// When [isLoading] is true, a loading indicator is displayed at the bottom of
/// the header box.
///
/// Use [semanticsLabel] to provide an additional accessibility label announced
/// by assistive technologies.
/// {@endtemplate}
///
/// ## Sample code
///
/// ```dart
/// SBBHeaderBox(
///   leadingIconData: SBBIcons.train_small,
///   titleText: 'Title',
///   subtitleText: 'Subtitle',
///   trailing: SBBTertiaryButtonSmall(
///     icon: SBBIcons.pencil_small,
///     onPressed: () {},
///   ),
/// )
/// ```
///
/// ## Sample code with body and flap
///
/// ```dart
/// SBBHeaderBox(
///   titleText: 'Journey details',
///   subtitleText: 'IC 3 to Zürich HB',
///   body: Text('Departure: 14:32'),
///   flap: SBBHeaderBoxFlap(
///     labelText: 'Additional travel information',
///   ),
/// )
/// ```
///
/// ## Customization
///
/// Use [style] to customize the appearance of a single header box, or
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
///  * [SBBHeaderBoxFlap], for flap content.
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
  /// Cannot be used together with [leadingIconData].
  /// {@endtemplate}
  final Widget? leading;

  /// {@template sbb_design_system.header_box.leadingIconData}
  /// Icon data for the leading icon.
  ///
  /// Cannot be used together with [leading].
  /// {@endtemplate}
  final IconData? leadingIconData;

  /// {@template sbb_design_system.header_box.title}
  /// A custom widget displayed as the header box's title.
  ///
  /// For simple text labels, use [titleText] instead.
  ///
  /// Cannot be used together with [titleText].
  /// {@endtemplate}
  final Widget? title;

  /// {@template sbb_design_system.header_box.titleText}
  /// Text string to display as the header box's title using standard styling.
  ///
  /// The text is clamped to a single line with ellipsis overflow.
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
  /// The subtitle is positioned below the title.
  ///
  /// Cannot be used together with [subtitle].
  /// {@endtemplate}
  final String? subtitleText;

  /// {@template sbb_design_system.header_box.trailing}
  /// A custom widget displayed as the header box's trailing content.
  ///
  /// This is commonly an action widget such as [SBBTertiaryButtonSmall].
  ///
  /// The trailing widget is vertically centered relative to the header box
  /// title row.
  /// {@endtemplate}
  final Widget? trailing;

  /// {@template sbb_design_system.header_box.body}
  /// A custom widget displayed as the body of the header box.
  ///
  /// This content is rendered below the title/subtitle section, if present.
  ///
  /// The body can also be used on its own when no title is provided.
  /// {@endtemplate}
  final Widget? body;

  /// {@template sbb_design_system.header_box.flap}
  /// The content to display inside the flap below the header box.
  ///
  /// You may use [SBBHeaderBoxFlap] to achieve the default look.
  ///
  /// If null, no flap is displayed.
  /// {@endtemplate}
  final Widget? flap;

  /// {@template sbb_design_system.header_box.isLoading}
  /// Whether to show a loading indicator at the bottom of the header box.
  ///
  /// When true, a [BottomLoadingIndicator] is displayed at the bottom of the
  /// header box.
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool isLoading;

  /// {@template sbb_design_system.header_box.margin}
  /// The empty space that surrounds the header box.
  ///
  /// If null, [SBBHeaderBoxStyle.margin] is used.
  /// {@endtemplate}
  final EdgeInsetsGeometry? margin;

  /// {@template sbb_design_system.header_box.padding}
  /// The empty space between the header box content and its outer container.
  ///
  /// If null, [SBBHeaderBoxStyle.padding] is used.
  /// {@endtemplate}
  final EdgeInsetsGeometry? padding;

  /// {@template sbb_design_system.header_box.style}
  /// Customizes this header box's appearance.
  ///
  /// Non-null properties of this style override the corresponding properties
  /// in [SBBHeaderBoxThemeData.style] from the current theme.
  /// {@endtemplate}
  final SBBHeaderBoxStyle? style;

  /// {@template sbb_design_system.header_box.semanticsLabel}
  /// The semantic label for the header box announced by screen readers.
  ///
  /// This is exposed to assistive technologies such as TalkBack and
  /// VoiceOver.
  ///
  /// This label is not shown in the UI.
  /// {@endtemplate}
  final String? semanticsLabel;

  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return (Theme.of(context).sbbHeaderBoxTheme?.style ?? SBBHeaderBoxStyle())
        .merge(style)
        .copyWith(margin: margin, padding: padding);
  }

  Widget? _defaultContent(BuildContext context) {
    if (title == null && titleText == null) {
      return null;
    }

    return HeaderBoxContent(
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
    Widget? contentWidget = _defaultContent(context);

    if (body != null && contentWidget != null) {
      contentWidget = Column(
        mainAxisSize: .min,
        children: [
          contentWidget,
          body!,
        ],
      );
    } else if (body != null) {
      contentWidget = body;
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

/// The SBB Header-Box in its large variant.
///
/// A prominent container used to present page-related information at the top of
/// a screen. It supports optional leading, title, subtitle, trailing, body, and
/// flap content.
///
/// The title row displays the icon besides the title and subtitle. Additional [body] content is
/// rendered below this area.
///
/// {@macro sbb_design_system.header_box_description}
///
/// ## Sample code
///
/// ```dart
/// SBBHeaderBoxLarge(
///   leadingIconData: SBBIcons.train_small,
///   titleText: 'Title',
///   subtitleText: 'Subtitle',
///   trailing: SBBTertiaryButtonSmall(
///     icon: SBBIcons.pencil_small,
///     onPressed: () {},
///   ),
/// )
/// ```
///
/// ## Customization
///
/// Use [style] to customize the appearance of a single header box, or
/// [SBBHeaderBoxThemeData.largeStyle] to apply consistent styling across your app:
///
/// ```dart
/// SBBHeaderBoxLarge(
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
///  * [SBBHeaderBox], for the default-sized variant.
///  * [SBBSliverHeaderBoxLarge], for a sliver variant that can be used inside scroll views.
///  * [SBBHeaderBoxFlap], for styled flap content.
///  * [SBBHeaderBoxStyle], for customizing the appearance.
///  * [SBBHeaderBoxThemeData], for setting header box theme properties across your app.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/header-box)
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?m=auto&node-id=192-861&t=rQTLXnChqHrpKLB4-1) (internal only)
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
  Widget? _defaultContent(BuildContext context) {
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
