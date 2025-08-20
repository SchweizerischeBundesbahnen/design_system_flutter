import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/headerbox/sbb_headerbox_content.dart';

import '../../sbb_design_system_mobile.dart';
import 'sliver_pinned_floating_widget.dart';

const defaultAnimationStyle = AnimationStyle(
  duration: Durations.short4,
  curve: Curves.easeInOutCubic,
);

/// A floating, expanding, and contracting version of the SBB Sliver Headerbox.
///
/// This widget behaves the same as [SBBSliverHeaderbox] but allows you to include contracting children.
/// To achieve this effect, the widget looks at the minimum and maximum intrinsic heights and transitions between them.
///
/// The most flexible way to use it is like so:
///
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SBBSliverFloatingHeaderbox.stacked(
///       _StaticHeader(),
///       SBBStackedItem.aligned(
///         alignment: Alignment.bottomLeft,
///         child: ...
///       ).
///     )
///   ]
/// )
/// ```
///
/// See [SBBStackedColumn] and [SBBStackedItem] for ways to build contracting items.
class SBBSliverFloatingHeaderbox extends StatefulWidget {
  SBBSliverFloatingHeaderbox({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    Widget? contractingWidget,
    bool floating = true,
    AnimationStyle snapStyle = defaultAnimationStyle,
  }) : this.custom(
          key: key,
          child: contractingWidget == null
              ? DefaultHeaderBoxContent(
                  title: title,
                  leadingIcon: leadingIcon,
                  secondaryLabel: secondaryLabel,
                  trailingWidget: trailingWidget,
                )
              : SBBStackedColumn(
                  children: [
                    DefaultHeaderBoxContent(
                      title: title,
                      leadingIcon: leadingIcon,
                      secondaryLabel: secondaryLabel,
                      trailingWidget: trailingWidget,
                    ),
                    SBBStackedItem.aligned(
                      builder: (context, state, child) => Opacity(
                        opacity: state.expansionRate,
                        child: child,
                      ),
                      child: contractingWidget,
                    )
                  ],
                ),
          margin: margin,
          flap: flap,
          semanticsLabel: semanticsLabel,
        );

  SBBSliverFloatingHeaderbox.large({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    Widget? collapsingWidget,
    bool floating = true,
    AnimationStyle snapStyle = defaultAnimationStyle,
  }) : this.custom(
          key: key,
          child: collapsingWidget == null
              ? LargeHeaderBoxContent(
                  title: title,
                  leadingIcon: leadingIcon,
                  secondaryLabel: secondaryLabel,
                  trailingWidget: trailingWidget,
                )
              : SBBStackedColumn(
                  children: [
                    LargeHeaderBoxContent(
                      title: title,
                      leadingIcon: leadingIcon,
                      secondaryLabel: secondaryLabel,
                      trailingWidget: trailingWidget,
                    ),
                    SBBStackedItem.aligned(
                      child: collapsingWidget,
                    )
                  ],
                ),
          margin: margin,
          flap: flap,
          semanticsLabel: semanticsLabel,
        );

  SBBSliverFloatingHeaderbox.stacked({
    super.key,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    EdgeInsets padding = const EdgeInsets.all(sbbDefaultSpacing),
    SBBHeaderboxFlap? flap,
    String? semanticsLabel,
    this.floating = true,
    this.snapStyle = defaultAnimationStyle,
    Widget? leading,
    required List<Widget> children,
  }) : child = leading != null
            ? SBBStackedColumn(
                children: [
                  leading,
                  SBBHeaderbox.custom(
                    margin: margin,
                    padding: padding,
                    flap: flap,
                    semanticsLabel: semanticsLabel,
                    child: SBBStackedColumn(children: children),
                  )
                ],
              )
            : SBBHeaderbox.custom(
                margin: margin,
                padding: padding,
                flap: flap,
                semanticsLabel: semanticsLabel,
                child: SBBStackedColumn(children: children),
              );

  /// Allows complete customization of the [SBBSliverStaticHeaderbox].
  SBBSliverFloatingHeaderbox.custom({
    super.key,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    EdgeInsets padding = const EdgeInsets.all(sbbDefaultSpacing),
    SBBHeaderboxFlap? flap,
    String? semanticsLabel,
    this.floating = true,
    this.snapStyle = defaultAnimationStyle,
    Widget? leading,
    required Widget child,
  }) : child = leading != null
            ? SBBStackedColumn(
                children: [
                  leading,
                  SBBHeaderbox.custom(
                    margin: margin,
                    padding: padding,
                    flap: flap,
                    semanticsLabel: semanticsLabel,
                    child: child,
                  )
                ],
              )
            : SBBHeaderbox.custom(
                margin: margin,
                padding: padding,
                flap: flap,
                semanticsLabel: semanticsLabel,
                child: child,
              );

  final Widget child;
  final AnimationStyle snapStyle;
  final bool floating;

  @override
  State<SBBSliverFloatingHeaderbox> createState() => _SBBSliverFloatingHeaderboxState();
}

class _SBBSliverFloatingHeaderboxState extends State<SBBSliverFloatingHeaderbox> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverPinnedFloatingWidget(
      vsync: this,
      animationStyle: widget.snapStyle,
      snapMode: FloatingHeaderSnapMode.scroll,
      floating: widget.floating,
      child: _SnapTrigger(
        widget.child,
      ),
    );
  }
}

class _SnapTrigger extends StatefulWidget {
  const _SnapTrigger(this.child);

  final Widget child;

  @override
  _SnapTriggerState createState() => _SnapTriggerState();
}

class _SnapTriggerState extends State<_SnapTrigger> {
  ScrollPosition? position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (position != null) {
      position!.isScrollingNotifier.removeListener(isScrollingListener);
    }
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

  // Called when the sliver starts or ends scrolling.
  void isScrollingListener() {
    assert(position != null);
    final RenderSliverPinnedFloatingWidget? renderer =
        context.findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();
    renderer?.isScrollingUpdate(position!);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
