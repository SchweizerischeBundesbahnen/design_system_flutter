import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'sliver_pinned_floating_widget.dart';

class SBBSliverFloatingHeaderbox extends StatefulWidget {
  SBBSliverFloatingHeaderbox({
    super.key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin =
        const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    this.snapStyle = const AnimationStyle(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOutCubic,
    ),
  }) : child = SBBHeaderbox(
          title: title,
          leadingIcon: leadingIcon,
          secondaryLabel: secondaryLabel,
          trailingWidget: trailingWidget,
          margin: margin,
          flap: flap,
          semanticsLabel: semanticsLabel,
        );

  SBBSliverFloatingHeaderbox.large({
    super.key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin =
        const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    this.snapStyle = const AnimationStyle(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOutCubic,
    ),
  }) : child = SBBHeaderbox.large(
          title: title,
          leadingIcon: leadingIcon,
          secondaryLabel: secondaryLabel,
          trailingWidget: trailingWidget,
          margin: margin,
          flap: flap,
          semanticsLabel: semanticsLabel,
        );

  /// Allows complete customization of the [SBBSliverStaticHeaderbox].
  SBBSliverFloatingHeaderbox.custom({
    super.key,
    required Widget child,
    EdgeInsets margin =
        const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    EdgeInsets padding = const EdgeInsets.all(sbbDefaultSpacing),
    SBBHeaderboxFlap? flap,
    String? semanticsLabel,
    bool floating = false,
    this.snapStyle = const AnimationStyle(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOutCubic,
    ),
  }) : child = SBBHeaderbox.custom(
          margin: margin,
          padding: padding,
          flap: flap,
          semanticsLabel: semanticsLabel,
          child: child,
        );

  final Widget child;
  final AnimationStyle snapStyle;

  @override
  State<SBBSliverFloatingHeaderbox> createState() =>
      _SBBSliverFloatingHeaderboxState();
}

class _SBBSliverFloatingHeaderboxState extends State<SBBSliverFloatingHeaderbox>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverPinnedFloatingWidget(
      vsync: this,
      animationStyle: widget.snapStyle,
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

  int eventCounter = 0;

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
    final RenderSliverPinnedFloatingWidget? renderer = context
        .findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();
    renderer?.isScrollingUpdate(position!);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
