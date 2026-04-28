import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/header/sbb_header_style_scope.dart';

/// The SBB Header.
///
/// {@template sbb_design_system.header_description}
/// A top app bar that follows the SBB Design System and builds on top of
/// Flutter’s [AppBar]. Use it to display a page title, a navigation affordance
/// (menu, back, close) and optional actions.
///
/// Provide either [titleText] for a simple, text-only title with standard
/// styling, or [title] for a fully custom title widget. These two parameters
/// are mutually exclusive.
///
/// Leading behavior:
/// - By default, when [automaticallyImplyLeading] is true, the header chooses
///   a leading icon based on context:
///   1) If the surrounding [Scaffold] has a drawer, a menu button is shown.
///   2) If the current route can pop, a back button is shown.
///   3) If the current route is a fullscreen dialog, a close button is shown.
/// - To override the automatic behavior, pass a widget to [leading] directly
///   (e.g. one of the SBB buttons [SBBHeaderLeadingMenuButton],
///   [SBBHeaderLeadingBackButton], [SBBHeaderLeadingCloseButton]) or a custom widget.
/// - To remove leading, set [automaticallyImplyLeading] to false with [leading] null.
/// - If [leadingWidth] is not provided and the leading widget is one of the
///   SBB-provided buttons, a default width is applied.
///
/// Actions:
/// - Use [actions] to show trailing action widgets (e.g. icon buttons).
/// - If [actions] is null, the SBB logo is shown. To suppress it, provide
///   an empty list.
///
/// Bottom:
/// - Use [bottom] to attach a [PreferredSizeWidget].
///
/// Custom appearance can be provided via [style], which will override
/// non-null properties from the theme.
///
/// This widget is normally used inside a [Scaffold] as the appBar parameter to
/// properly constrain its height. If used otherwise, you must make sure to
/// properly constrain its height, e.g. by using the [SBBHeaderStyle.toolbarHeight]
/// or [SBBHeaderStyle.smallToolbarHeight] in addition to the height of the bottom widget.
/// {@endtemplate}
///
/// Sample code:
///
/// ```dart
/// // Simple header with a text title and automatic leading.
/// SBBHeader(titleText: 'SBB');
///
/// // A header with a menu icon leading, custom title and style.
/// SBBHeader(
///   leading: SBBHeaderLeadingMenuButton(),
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
/// {@template sbb_design_system.header_see_also}
/// See also:
/// - [SBBHeaderLeadingMenuButton], [SBBHeaderLeadingBackButton],
///   and [SBBHeaderLeadingCloseButton] for SBB-styled leading widgets.
/// - [SBBHeaderStyle], for customizing the header’s appearance.
/// - [SBBHeaderThemeData], to provide theme-wide defaults for headers.
/// - [AppBar], which is used by this widget under the hood.
/// - [Design Specification](https://digital.sbb.ch/de/design-system-mobile-new/module/header)
/// {@endtemplate}
/// - [SBBHeaderSmall], small variant of the SBB header
class SBBHeader extends StatelessWidget implements PreferredSizeWidget {
  const SBBHeader({
    super.key,
    this.titleText,
    this.title,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.bottom,
    this.excludeHeaderSemantics = false,
    this.automaticallyImplyLeading = true,
    this.useDefaultSemanticsOrder = true,
    this.style,
  }) : assert(title == null || titleText == null, 'Only one of title or titleText can be set');

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
  ///
  /// You can pass one of the provided SBB leading icon buttons:
  /// - [SBBHeaderLeadingMenuButton]
  /// - [SBBHeaderLeadingBackButton]
  /// - [SBBHeaderLeadingCloseButton]
  final Widget? leading;

  /// {@macro flutter.material.appbar.leadingWidth}
  ///
  /// If null and [leading] is one of the provided SBB leading icon buttons,
  /// a default width is used. When [automaticallyImplyLeading] is true, the
  /// correct widths are supplied.
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

  @override
  Widget build(BuildContext context) {
    return _BaseHeader(
      title: title,
      titleText: titleText,
      leading: leading,
      leadingWidth: leadingWidth,
      bottom: _resolvedBottom,
      actions: actions,
      style: style,
      excludeHeaderSemantics: excludeHeaderSemantics,
      automaticallyImplyLeading: automaticallyImplyLeading,
      useDefaultSemanticsOrder: useDefaultSemanticsOrder,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_toolbarHeight + (bottom?.preferredSize.height ?? 0));

  double get _toolbarHeight => SBBHeaderStyle.toolbarHeight;

  PreferredSizeWidget? get _resolvedBottom => _DefaultBottomSpacer(bottom: bottom);
}

/// The small variant of SBB Header
///
/// {@macro sbb_design_system.header_description}
///
/// Sample code:
///
/// ```dart
/// // Simple header with a text title and automatic leading.
/// SBBHeaderSmall(titleText: 'SBB');
///
/// // A header with a menu icon leading, custom title and style.
/// SBBHeaderSmall(
///   leading: SBBHeaderLeadingMenuButton(),
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
/// {@macro sbb_design_system.header_see_also}
/// - [SBBHeader], default variant of the SBB header
class SBBHeaderSmall extends SBBHeader {
  const SBBHeaderSmall({
    super.key,
    super.titleText,
    super.title,
    super.leading,
    super.leadingWidth,
    super.actions,
    super.bottom,
    super.excludeHeaderSemantics = false,
    super.automaticallyImplyLeading = true,
    super.useDefaultSemanticsOrder = true,
    super.style,
  });

  @override
  double get _toolbarHeight => SBBHeaderStyle.smallToolbarHeight;

  @override
  PreferredSizeWidget? get _resolvedBottom => bottom;
}

/// Base class for building both the small and the normal variant of [SBBHeader].
class _BaseHeader extends StatelessWidget {
  const _BaseHeader({
    required this.title,
    required this.titleText,
    required this.leading,
    required this.leadingWidth,
    required this.bottom,
    required this.actions,
    required this.style,
    required this.excludeHeaderSemantics,
    required this.automaticallyImplyLeading,
    required this.useDefaultSemanticsOrder,
  });

  final Widget? title;
  final String? titleText;
  final Widget? leading;
  final double? leadingWidth;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final bool excludeHeaderSemantics;
  final bool useDefaultSemanticsOrder;
  final List<Widget>? actions;
  final SBBHeaderStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).sbbHeaderTheme;
    final effectiveStyle = (themeData?.style ?? SBBHeaderStyle()).merge(style);

    final resolvedLeading = _resolveLeading(context);
    final leadingWithScope = resolvedLeading == null
        ? null
        : SBBHeaderStyleScope(style: effectiveStyle, child: resolvedLeading);

    return AppBar(
      leading: leadingWithScope,
      leadingWidth: _resolveLeadingWidth(context, resolvedLeading),
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
      actions: actions ?? [_sbbLogo()],
    );
  }

  Widget _sbbLogo() {
    return ExcludeSemantics(
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: SBBSpacing.xSmall),
        height: SBBHeaderStyle.toolbarHeight,
        width: SBBHeaderStyle.toolbarHeight,
        child: const SBBLogo(),
      ),
    );
  }

  Widget? _resolveLeading(BuildContext context) {
    if (leading != null) return leading;

    if (!automaticallyImplyLeading) return null;

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    if (Scaffold.of(context).hasDrawer) {
      return SBBHeaderLeadingMenuButton();
    } else if (parentRoute?.canPop ?? false) {
      return SBBHeaderLeadingBackButton();
    } else if (parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog) {
      return SBBHeaderLeadingCloseButton();
    }

    return null;
  }

  double? _resolveLeadingWidth(BuildContext context, Widget? resolvedLeading) {
    if (leadingWidth != null) return leadingWidth;

    if (resolvedLeading is SBBHeaderLeadingMenuButton) return SBBHeaderLeadingMenuButton.leadingWidth;
    if (resolvedLeading is SBBHeaderLeadingBackButton) return SBBHeaderLeadingBackButton.leadingWidth(context);
    if (resolvedLeading is SBBHeaderLeadingCloseButton) return SBBHeaderLeadingCloseButton.leadingWidth;

    return null;
  }

  Widget? _resolveTitle() {
    if (title == null && titleText != null) {
      return Text(titleText!);
    }
    return title;
  }
}

/// Workaround for bottom spacing of [SBBHeader] as setting [AppBar.toolbarHeight] centers elements of AppBar.
class _DefaultBottomSpacer extends StatelessWidget implements PreferredSizeWidget {
  const _DefaultBottomSpacer({this.bottom});

  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(extraSpace + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (bottom != null) bottom!,
        SizedBox(height: extraSpace),
      ],
    );
  }

  double get extraSpace => SBBHeaderStyle.toolbarHeight - SBBHeaderStyle.smallToolbarHeight;
}
