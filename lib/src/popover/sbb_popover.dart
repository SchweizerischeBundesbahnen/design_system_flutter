import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/popover_clipper.dart';

const _defaultPopoverConstraints = BoxConstraints(minWidth: 360.0);
const _defaultPopoverBorder = SBBPopoverBorder.only(notchTop: true, notchBottom: true);

/// The SBBPopover. Used to display more content on tablet sized screens.
///
/// This Widget is not part of the components of the [SBB design specifications](https://digital.sbb.ch/);
/// rather it displays other components on tablet sized screens in an [Overlay] like fashion.
///
/// This is closely mimicked from the Apple designed Popover. In Material, this corresponds to a Dialog with custom
/// borders and custom location.
///
/// Typically, this Widget is used as the floating Widget with either:
/// * [SBBModalAnchoredBuilder] allowing to anchor a base and floating widget using [OverlayPortal]
/// * [SBBModalAnchoredBuilder] which layers a [ModalBarrier] between the base and floating widget
class SBBPopover extends StatelessWidget {
  const SBBPopover({
    super.key,
    this.constraints = _defaultPopoverConstraints,
    this.border = _defaultPopoverBorder,
    this.color,
    this.child,
    this.semanticLabel,
  });

  /// The constraints of this popover.
  ///
  /// Defaults to having a minWidth of 360px.
  final BoxConstraints constraints;

  /// The border of this popover. This allows to define the sides that should have a notched look.
  ///
  /// See [SBBPopoverBorder] for details.
  ///
  /// Defaults to drawing notches at the top and bottom.
  final SBBPopoverBorder border;

  /// The background color of this popover.
  ///
  /// Defaults to the inherited [SBBPopoverStyle.popoverColor], which defaults to
  /// [SBBBaseStyle.backgroundColor].
  final Color? color;

  /// The Widget below this SBBPopover.
  ///
  /// If this is null, the Popover is not drawn.
  final Widget? child;

  /// The semantic label of this popover.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (child == null) return SizedBox.shrink();

    final style = SBBPopoverStyle.of(context);
    return Semantics(
      label: semanticLabel,
      child: ClipPath(
        clipper: PopoverClipper(borderRadius: sbbDefaultSpacing, border: border),
        child: Material(
          clipBehavior: style.popoverClipBehavior ?? Clip.hardEdge,
          color: color ?? style.popoverColor,
          child: ConstrainedBox(constraints: constraints, child: child),
        ),
      ),
    );
  }
}
