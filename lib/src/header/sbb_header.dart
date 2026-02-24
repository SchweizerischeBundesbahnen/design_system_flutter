import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/header/leading_buttons.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Header.
///
/// A top app bar that follows the SBB Design System and builds on top of
/// Flutter’s [AppBar]. Use it to display a page title, a navigation affordance
/// (menu, back, close), and optional actions.
///
/// Provide either [titleText] for a simple, text-only title with standard
/// styling, or [title] for a fully custom title widget. These two parameters
/// are mutually exclusive.
///
/// Leading behavior:
/// - By default, when [automaticallyImplyLeading] is true, the header chooses
///   an appropriate leading icon (menu, close, back) based on context.
/// - To override the automatic behavior, set [automaticallyImplyLeading] to
///   false and use one of the named constructors or provide [leading] directly.
/// - The named constructors [SBBHeader.menu], [SBBHeader.back], and
///   [SBBHeader.close] construct the header with a predefined leading icon
///   and optional callbacks.
///
/// Actions:
/// - Use [actions] to show trailing action widgets (e.g. icon buttons).
/// - If [actions] is null or empty, the SBB logo is shown as a trailing action
///   to reinforce branding. To suppress it, provide at least one trailing
///   widget yourself (e.g. a zero-sized widget).
///
/// Bottom:
/// - Use [bottom] to attach a [PreferredSizeWidget] such as a [TabBar].
///
/// Custom appearance can be provided via [style], which will override
/// non-null properties from the theme.
///
/// Sample code:
///
/// ```dart
/// // Simple header with a text title and automatic leading.
/// SBBHeader(titleText: 'SBB');
///
/// // A header with a menu icon leading, custom title and style.
/// SBBHeader.menu(
///   title: Row(
///     spacing: 8.0,
///     children: [
///       const Icon(SBBIcons.train_small),
///       const Text('SBB Mobile'),
///     ],
///   ),
///   style: const SBBHeaderStyle(
///     backgroundColor: Color(0xFF000000),
///     foregroundColor: Color(0xFFFFFFFF),
///     centerTitle: false,
///   ),
/// );
/// ```
///
/// See also:
/// - [SBBHeaderStyle], for customizing the header’s appearance.
/// - [SBBHeaderThemeData], to provide theme-wide defaults for headers.
/// - [AppBar], which is used by this widget under the hood.
/// - [Design Specification](https://digital.sbb.ch/de/design-system-mobile-new/module/header)
class SBBHeader extends StatelessWidget implements PreferredSizeWidget {
  const SBBHeader({
    Key? key,
    String? titleText,
    Widget? title,
    Widget? leading,
    double? leadingWidth,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    bool excludeHeaderSemantics = false,
    bool automaticallyImplyLeading = true,
    bool useDefaultSemanticsOrder = true,
    SBBHeaderStyle? style,
  }) : this._(
         key: key,
         title: title,
         titleText: titleText,
         leading: leading,
         leadingWidth: leadingWidth,
         bottom: bottom,
         excludeHeaderSemantics: excludeHeaderSemantics,
         useDefaultSemanticsOrder: useDefaultSemanticsOrder,
         automaticallyImplyLeading: automaticallyImplyLeading,
         actions: actions,
         style: style,
       );

  /// Creates an SBB header with a menu leading icon.
  ///
  /// The [onMenuPressed] callback is invoked when the menu icon is tapped.
  /// Automatic leading is disabled for this constructor.
  SBBHeader.menu({
    Key? key,
    String? titleText,
    Widget? title,
    Widget? leading,
    double? leadingWidth,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    bool excludeHeaderSemantics = false,
    bool useDefaultSemanticsOrder = true,
    VoidCallback? onMenuPressed,
    SBBHeaderStyle? style,
  }) : this._(
         key: key,
         title: title,
         titleText: titleText,
         bottom: bottom,
         excludeHeaderSemantics: excludeHeaderSemantics,
         useDefaultSemanticsOrder: useDefaultSemanticsOrder,
         automaticallyImplyLeading: false,
         leadingIconBuilder: HeaderLeadingIconBuilder.menu(onPressed: onMenuPressed),
         actions: actions,
         style: style,
       );

  /// Creates an SBB header with a back leading icon.
  ///
  /// The [onBackPressed] callback is invoked when the back icon is tapped.
  /// Automatic leading is disabled for this constructor.
  SBBHeader.back({
    Key? key,
    String? titleText,
    Widget? title,
    Widget? leading,
    double? leadingWidth,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    bool excludeHeaderSemantics = false,
    bool useDefaultSemanticsOrder = true,
    VoidCallback? onBackPressed,
    SBBHeaderStyle? style,
  }) : this._(
         key: key,
         title: title,
         titleText: titleText,
         bottom: bottom,
         excludeHeaderSemantics: excludeHeaderSemantics,
         useDefaultSemanticsOrder: useDefaultSemanticsOrder,
         automaticallyImplyLeading: false,
         leadingIconBuilder: HeaderLeadingIconBuilder.back(onPressed: onBackPressed),
         actions: actions,
         style: style,
       );

  /// Creates an SBB header with a close leading icon.
  ///
  /// The [onClosePressed] callback is invoked when the close icon is tapped.
  /// Automatic leading is disabled for this constructor.
  SBBHeader.close({
    Key? key,
    String? titleText,
    Widget? title,
    Widget? leading,
    double? leadingWidth,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    bool excludeHeaderSemantics = false,
    bool useDefaultSemanticsOrder = true,
    VoidCallback? onClosePressed,
    SBBHeaderStyle? style,
  }) : this._(
         key: key,
         title: title,
         titleText: titleText,
         bottom: bottom,
         excludeHeaderSemantics: excludeHeaderSemantics,
         useDefaultSemanticsOrder: useDefaultSemanticsOrder,
         automaticallyImplyLeading: false,
         leadingIconBuilder: HeaderLeadingIconBuilder.close(onPressed: onClosePressed),
         actions: actions,
         style: style,
       );

  const SBBHeader._({
    required this.automaticallyImplyLeading,
    required this.excludeHeaderSemantics,
    required this.useDefaultSemanticsOrder,
    super.key,
    this.title,
    this.titleText,
    this.leading,
    this.leadingWidth,
    this.bottom,
    this.actions,
    this.style,
    HeaderLeadingIconBuilder? leadingIconBuilder,
  }) : _leadingIconBuilder = leadingIconBuilder,
       assert(title == null || titleText == null, 'Only one of title or titleText can be set');

  /// A custom widget displayed as the header's title.
  ///
  /// For simple text labels, use [titleText] instead.
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the header's title.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// {@macro flutter.material.appbar.leading}
  final Widget? leading;

  /// {@macro flutter.material.appbar.leadingWidth}
  final double? leadingWidth;

  /// {@macro flutter.material.appbar.bottom}
  final PreferredSizeWidget? bottom;

  /// {@macro flutter.material.appbar.automaticallyImplyLeading}
  final bool automaticallyImplyLeading;

  /// {@macro flutter.material.appbar.excludeHeaderSemantics}
  final bool excludeHeaderSemantics;

  /// {@macro flutter.material.appbar.useDefaultSemanticsOrder}
  final bool useDefaultSemanticsOrder;

  /// {@macro flutter.material.appbar.actions}
  final List<Widget>? actions;

  /// Customizes this header's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBHeaderThemeData.style] of the theme found in [context].
  final SBBHeaderStyle? style;

  final HeaderLeadingIconBuilder? _leadingIconBuilder;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).sbbHeaderTheme;
    final effectiveStyle = (themeData?.style ?? SBBHeaderStyle()).merge(style);

    return AppBar(
      leading: _resolveLeading(context, effectiveStyle),
      leadingWidth: _resolveLeadingWidth(context),
      title: _resolveTitle(),
      bottom: bottom,
      foregroundColor: effectiveStyle.foregroundColor,
      backgroundColor: effectiveStyle.backgroundColor,
      titleSpacing: effectiveStyle.titleSpacing,
      titleTextStyle: effectiveStyle.titleTextStyle,
      centerTitle: effectiveStyle.centerTitle,
      clipBehavior: effectiveStyle.clipBehavior,
      elevation: effectiveStyle.elevation,
      systemOverlayStyle: effectiveStyle.systemOverlayStyle,
      toolbarTextStyle: effectiveStyle.toolbarTextStyle,
      actionsPadding: effectiveStyle.actionsPadding,
      automaticallyImplyLeading: automaticallyImplyLeading,
      useDefaultSemanticsOrder: useDefaultSemanticsOrder,
      excludeHeaderSemantics: excludeHeaderSemantics,
      actions: actions != null && actions!.isNotEmpty ? actions : [_sbbLogo()],
    );
  }

  Widget _sbbLogo() {
    return ExcludeSemantics(
      child: Container(
        alignment: .centerRight,
        padding: const .only(right: SBBSpacing.xSmall),
        height: SBBHeaderStyle.toolbarHeight,
        width: SBBHeaderStyle.toolbarHeight,
        child: const SBBLogo(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SBBHeaderStyle.toolbarHeight + (bottom?.preferredSize.height ?? 0));

  Widget? _resolveLeading(BuildContext context, SBBHeaderStyle style) {
    if (leading == null && automaticallyImplyLeading) {
      return _resolveLeadingIcon(context)?.build(context, style);
    }
    return leading ?? _leadingIconBuilder?.build(context, style);
  }

  double? _resolveLeadingWidth(BuildContext context) {
    if (leading == null && automaticallyImplyLeading) {
      return _resolveLeadingIcon(context)?.leadingWidth;
    }
    return leadingWidth ?? _leadingIconBuilder?.leadingWidth;
  }

  Widget? _resolveTitle() {
    if (title == null && titleText != null) {
      return Text(titleText!);
    }
    return title;
  }

  HeaderLeadingIconBuilder? _resolveLeadingIcon(BuildContext context) {
    if (!automaticallyImplyLeading) return null;

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    if (Scaffold.of(context).hasDrawer) {
      return .menu();
    } else if (parentRoute?.canPop ?? false) {
      return .back();
    } else if (parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog) {
      return .close();
    }

    return null;
  }
}
