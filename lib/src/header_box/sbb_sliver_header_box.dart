import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/header_box/header_box_content.dart';
import 'package:sbb_design_system_mobile/src/header_box/header_box_foreground.dart';

import '../../sbb_design_system_mobile.dart';
import 'header_box_app_bar_inset.dart';
import 'sliver/sliver_pinned_floating_widget.dart';

/// A floating version of [SBBHeaderBox].
///
/// This widget behaves similarly to [SBBHeaderBox], but is designed for use inside custom scroll views.
/// It supports floating behavior as well as transitioning its own size depending on scrolling and its [body] argument.
///
/// The title row aligns the [leading] and [title] vertically. If a subtitle is provided, it is displayed below the
/// title row. Additional [body] content is rendered below the title/subtitle area.
///
/// [body] can be a [SBBContractible] or an [SBBCascadeColumn] and will behave accordingly.
/// When using a contractible widget, make sure to add [SBBSliverHeaderBoxSpacer] at the end of your list of slivers.
///
/// {@macro sbb_design_system.header_box_description}
///
/// {@template sbb_design_system.sliver_header_box_description}
/// To achieve the resizing effect, this widget transitions between the minimum and maximum intrinsic heights of its
/// subtree.
/// {@endtemplate}
///
/// ## Sample code with a dynamic body
///
/// ```dart
/// SBBSliverHeaderBox(
///   leadingIconData: SBBIcons.train_small,
///   titleText: 'Journey details',
///   subtitleText: 'IC 3 to Zürich HB',
///   body: SBBContractible(
///     child: Text('Departure: 14:32'),
///   ),
/// )
/// ```
///
/// ## Sample code with complete customization
///
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SBBSliverHeaderBox(
///       body: SBBCascadeColumn(
///         children: [
///           Text('First line'),
///           SBBContractible(child: Text('Second line', behavior: .clip)),
///           SBBContractible(child: Text('Third line', behavior: .displace)),
///         ],
///       ),
///     ),
///     // ...
///     const SBBSliverHeaderBoxSpacer(),
///   ]
/// )
/// ```
///
/// See also:
///
///  * [SBBHeaderBox], for the normal RenderBox variant.
///  * [SBBSliverHeaderBoxLarge], for the larger variant.
///  * [SBBHeaderBoxFlap], for flap content.
///  * [SBBHeaderBoxStyle], for customizing the appearance.
///  * [SBBHeaderBoxThemeData], for setting header box theme properties across your app.
///  * [SBBCascadeColumn] and [SBBContractible], for ways to build contracting items.
///  * [SBBSliverHeaderBoxSpacer], for a widget that should always come last in the list of slivers.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/header-box)
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?m=auto&node-id=192-861&t=rQTLXnChqHrpKLB4-1) (internal only)
///
/// ## Limitations & Considerations
///
/// This widget makes heavy use of intrinsics. This means two things:
///
/// - It is relatively expensive, see [IntrinsicHeight].
/// - You cannot use [LayoutBuilder].
class SBBSliverHeaderBox extends StatelessWidget {
  const SBBSliverHeaderBox({
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
    this.config,
    this.body,
    this.top,
  }) : assert(title != null || titleText != null || body != null, 'Either title or titleText or body must be provided'),
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

  /// A configuration for the sliver-specific behavior of the header box.
  ///
  /// Defaults to [SBBHeaderBoxConfig] with its default values.
  final SBBSliverHeaderBoxConfig? config;

  /// {@macro sbb_design_system.header_box.semanticsLabel}
  final String? semanticsLabel;

  /// A widget displayed above the header box that participates in the resize
  /// motion when [config.resizing] is enabled.
  ///
  /// This is useful for content such as a [SBBSegmentedButtonFilled] that
  /// should visually belong to the header area while scrolling with it.
  final Widget? top;

  /// {@macro sbb_design_system.header_box.body}
  ///
  /// You can use [SBBContractible] within this content to make parts of the
  /// body collapse during scroll.
  final Widget? body;

  /// Expands the nearest ancestor sliver header box.
  ///
  /// The provided [context] must be a descendant of an [SBBSliverHeaderBox] or
  /// [SBBSliverHeaderBoxLarge].
  static Future<void> expand(BuildContext context) async {
    await context.findAncestorStateOfType<_SnapTriggerState>()?.onSnapRequested(true);
  }

  /// Contracts the nearest ancestor sliver header box.
  ///
  /// The provided [context] must be a descendant of an [SBBSliverHeaderBox] or
  /// [SBBSliverHeaderBoxLarge].
  static Future<void> contract(BuildContext context) async {
    await context.findAncestorStateOfType<_SnapTriggerState>()?.onSnapRequested(false);
  }

  /// Resolves the effective style for this sliver header box.
  ///
  /// The final style is built from the current theme and then overridden by the
  /// widget-level [style], [margin], and [padding] values if provided.
  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return (Theme.of(context).sbbHeaderBoxTheme?.style ?? SBBHeaderBoxStyle())
        .merge(style)
        .copyWith(margin: margin, padding: padding);
  }

  /// Builds the default content widget shown inside the header box.
  ///
  /// This resolves leading, title, subtitle, and trailing content using the
  /// standard-sized header-box layout.
  Widget _resolveContent(BuildContext context) {
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
    return _BaseHeaderBox(
      flap: flap,
      content: _resolveContent(context),
      body: body,
      isLoading: isLoading,
      semanticsLabel: semanticsLabel,
      top: top,
      style: _resolveStyle(context),
      config: config ?? const SBBSliverHeaderBoxConfig(),
    );
  }
}

/// The large variant of [SBBSliverHeaderBox].
///
/// This widget behaves like [SBBSliverHeaderBox] but uses the large header-box
/// content layout and the themed [SBBHeaderBoxThemeData.largeStyle].
///
/// The title row displays the icon besides the title and subtitle. Additional [body] content is
/// rendered below this area.
///
/// [body] can be a [SBBContractible] or an [SBBCascadeColumn] and will behave accordingly.
///
/// {@macro sbb_design_system.header_box_description}
///
/// {@macro sbb_design_system.sliver_header_box_description}
///
/// ## Sample code
///
/// ```dart
/// SBBSliverHeaderBoxLarge(
///   leadingIconData: SBBIcons.train_small,
///   titleText: 'Journey details',
///   subtitleText: 'IC 3 to Zürich HB',
///   body: SBBContractible(
///     child: Padding(
///       padding: const EdgeInsets.only(top: SBBSpacing.small),
///       child: Text('Departure: 14:32'),
///     ),
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBHeaderBoxLarge], for the normal RenderBox variant.
///  * [SBBSliverHeaderBox], for the default variant.
///  * [SBBHeaderBoxFlap], for flap content.
///  * [SBBHeaderBoxStyle], for customizing the appearance.
///  * [SBBHeaderBoxThemeData], for setting header box theme properties across your app.
///  * [SBBCascadeColumn] and [SBBContractible], for ways to build contracting items.
///  * [SBBSliverHeaderBoxSpacer], for a widget that should always come last in the list of slivers.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/header-box)
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?m=auto&node-id=192-861&t=rQTLXnChqHrpKLB4-1) (internal only)
///
/// ## Limitations & Considerations
///
/// This widget makes heavy use of intrinsics. This means two things:
///
/// - It is relatively expensive, see [IntrinsicHeight].
/// - You cannot use [LayoutBuilder].
class SBBSliverHeaderBoxLarge extends SBBSliverHeaderBox {
  const SBBSliverHeaderBoxLarge({
    super.key,
    super.leading,
    super.leadingIconData,
    super.title,
    super.titleText,
    super.subtitle,
    super.subtitleText,
    super.trailing,
    super.flap,
    super.isLoading = false,
    super.margin,
    super.padding,
    super.style,
    super.semanticsLabel,
    super.top,
  });

  @override
  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return (Theme.of(context).sbbHeaderBoxTheme?.largeStyle ?? SBBHeaderBoxStyle())
        .merge(style)
        .copyWith(margin: margin, padding: padding);
  }

  @override
  Widget _resolveContent(BuildContext context) {
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

class _BaseHeaderBox extends StatefulWidget {
  const _BaseHeaderBox({
    this.top,
    this.content,
    this.body,
    this.flap,
    required this.isLoading,
    required this.style,
    required this.config,
    this.semanticsLabel,
  });

  final Widget? top;
  final Widget? content;
  final Widget? body;
  final Widget? flap;

  final bool isLoading;

  final SBBHeaderBoxStyle style;
  final SBBSliverHeaderBoxConfig config;

  final String? semanticsLabel;

  @override
  State<_BaseHeaderBox> createState() => _BaseHeaderBoxState();
}

class _BaseHeaderBoxState extends State<_BaseHeaderBox> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final children = [
      if (widget.top != null) _Top(child: widget.top!),
      HeaderBoxAppBarInset(
        style: widget.style,
        child: HeaderBoxForeground(
          style: widget.style,
          semanticsLabel: widget.semanticsLabel,
          flap: widget.flap,
          isLoading: widget.isLoading,
          flapMode: widget.config.flapMode,
          child: SBBCascadeColumn(
            children: [
              ?widget.content,
              ?widget.body,
            ],
          ),
        ),
      ),
    ];

    return SliverPinnedFloatingWidget(
      vsync: this,
      animationStyle: widget.config.snapStyle,
      snapMode: widget.config.snapMode,
      resizing: widget.config.resizing,
      floating: widget.config.floating,
      child: _SnapTrigger(
        child: children.singleOrNull ?? SBBCascadeColumn(children: children),
      ),
    );
  }
}

/// Internal widget that exposes imperative expand/contract behavior to
/// descendants via [BuildContext].
///
/// It also listens to scroll activity and forwards updates to the sliver render
/// object so snapping behavior can stay in sync with user interaction.
class _SnapTrigger extends StatefulWidget {
  const _SnapTrigger({
    required this.child,
  });

  /// The subtree wrapped by this snap trigger.
  final Widget child;

  @override
  _SnapTriggerState createState() => _SnapTriggerState();
}

class _SnapTriggerState extends State<_SnapTrigger> {
  ScrollPosition? position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Remove the old scroll listener if the surrounding scrollable changed.
    if (position != null) {
      position!.isScrollingNotifier.removeListener(isScrollingListener);
    }

    // Register with the nearest scrollable so we can forward scrolling updates
    // to the sliver render object.
    position = Scrollable.maybeOf(context)?.position;
    if (position != null) {
      position!.isScrollingNotifier.addListener(isScrollingListener);
    }
  }

  @override
  void dispose() {
    if (position != null) {
      position!.isScrollingNotifier.removeListener(isScrollingListener);
    }
    super.dispose();
  }

  /// Called whenever the surrounding scrollable starts or stops scrolling.
  ///
  /// The sliver render object uses this information to update its snapping
  /// state. On web this is skipped because scroll notifications are unreliable
  /// for this use case.
  void isScrollingListener() {
    // Scrolling events are kind of broken on web.
    if (kIsWeb) return;

    assert(position != null);
    final RenderSliverPinnedFloatingWidget? renderer = context
        .findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();

    renderer?.onScrollingUpdate(position!);
  }

  Future<void> onSnapRequested(bool expand) async {
    final RenderSliverPinnedFloatingWidget? renderer = context
        .findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();

    await renderer?.snap(expand ? .forward : .reverse);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _Top extends StatelessWidget {
  const _Top({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;
    return SBBContractible(
      behavior: .displace,
      child: Container(
        color: appBarTheme.backgroundColor,
        child: child,
      ),
    );
  }
}
