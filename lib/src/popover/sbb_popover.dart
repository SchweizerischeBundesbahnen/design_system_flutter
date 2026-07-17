import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_layout_delegate.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_layout_result.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_scope.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_shape.dart';

class SBBPopover extends StatefulWidget {
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
  State<SBBPopover> createState() => _SBBPopoverState();
}

class _SBBPopoverState extends State<SBBPopover> {
  ValueNotifier<SBBLayoutResult>? _layoutState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the layout state using the scope's preferred direction.
    // We use didChangeDependencies because context.dependOnInheritedWidget
    // cannot be called in initState.
    if (_layoutState == null) {
      final scope = SBBPopoverScope.of(context);
      _layoutState = ValueNotifier<SBBLayoutResult>(
        SBBLayoutResult(direction: scope.preferredDirection),
      );
    }
  }

  @override
  void dispose() {
    _layoutState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final scope = SBBPopoverScope.of(context);
    final triggerSize = scope.triggerSize;
    final triggerGlobalPosition = scope.triggerGlobalPosition;

    return Semantics(
      label: widget.semanticsLabel,
      container: widget.isSemanticContainer,
      explicitChildNodes: true,
      child: CustomSingleChildLayout(
        delegate: SBBPopoverLayoutDelegate(
          preferredDirection: scope.preferredDirection,
          safeAreaInsets: scope.safeAreaInsets,
          triggerSize: triggerSize,
          triggerGlobalPosition: triggerGlobalPosition,
          screenSize: mediaQuery.size,
          layoutState: _layoutState!,
        ),
        child: ValueListenableBuilder<SBBLayoutResult>(
          valueListenable: _layoutState!,
          builder: (context, result, child) {
            return Material(
              color: SBBColors.milk,
              shape: SBBPopoverShapeBorder(
                direction: result.direction,
              ),
              child: Padding(
                padding: SBBPopoverShapeBorder(
                  direction: result.direction,
                ).dimensions,
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}
