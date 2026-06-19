import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/bottom_loading_indicator.dart';

/// Draws the actual header box.
class HeaderBoxForeground extends StatelessWidget {
  const HeaderBoxForeground({
    super.key,
    required this.child,
    required this.style,
    this.semanticsLabel,
    this.flap,
    this.flapMode = .static,
    this.isLoading = false,
  });

  final SBBHeaderBoxStyle style;
  final Widget child;
  final String? semanticsLabel;
  final Widget? flap;
  final bool isLoading;
  final SBBHeaderBoxFlapMode flapMode;

  @override
  Widget build(BuildContext context) {
    final baseDecoration = BoxDecoration(
      boxShadow: style.headerBoxShadow,
      borderRadius: SBBHeaderBoxStyle.radius,
      color: style.flapBackgroundColor,
    );
    return Semantics(
      header: true,
      label: semanticsLabel,
      child: Container(
        clipBehavior: .hardEdge,
        decoration: switch (style.flapDecoration) {
          final BoxDecoration decoration => decoration.copyWith(
            boxShadow: decoration.boxShadow ?? baseDecoration.boxShadow,
            borderRadius: decoration.borderRadius ?? baseDecoration.borderRadius,
            color: decoration.color ?? baseDecoration.color,
          ),
          final Decoration decoration => decoration,
          null => baseDecoration,
        },
        child: _column(
          _headerBox(context, style),
          _animatedFlap(),
        ),
      ),
    );
  }

  Widget _column(Widget content, Widget? flap) {
    if (flap == null) {
      return content;
    }

    switch (flapMode) {
      case .static:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: content),
            flap,
          ],
        );
      case .contractible:
        return SBBCascadeColumn(
          children: [
            content,
            flap,
          ],
        );
      case .hideable:
        return SBBCascadeColumn(
          children: [
            content,
            SBBContractible(
              behavior: .displace,
              child: flap,
            ),
          ],
        );
    }
  }

  Widget _animatedFlap() {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      switchInCurve: Curves.easeInOutCubic,
      switchOutCurve: Curves.easeInOutCubic,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: .vertical,
          alignment: Alignment(-1.0, 1.0),
          child: child,
        );
      },
      child: flap,
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
