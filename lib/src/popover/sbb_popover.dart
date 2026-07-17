import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_scope.dart';

class SBBPopover extends StatelessWidget {
  const SBBPopover({
    super.key,
    required this.child,
    this.semanticsLabel,
    this.isSemanticContainer = true,
  });

  final Widget child;
  final String? semanticsLabel;
  final bool isSemanticContainer;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final scope = SBBPopoverScope.of(context);

    return Semantics(
      label: semanticsLabel,
      container: isSemanticContainer,
      explicitChildNodes: true,
      child: SBBPopoverLayout(
        preferredDirection: scope.preferredDirection,
        safeAreaInsets: scope.safeAreaInsets,
        triggerGlobalPosition: scope.triggerGlobalPosition,
        triggerSize: scope.triggerSize,
        screenSize: mediaQuery.size,
        child: Material(
          type: MaterialType.transparency,
          child: child,
        ),
      ),
    );
  }
}
