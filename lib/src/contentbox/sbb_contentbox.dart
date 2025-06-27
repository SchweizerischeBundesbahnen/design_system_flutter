import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../theme/styles/src/sbb_contentbox_style.dart';

/// SBBContentBox. Use to structure content.
///
/// May be placed anywhere in the screen to structure other components.
///
/// See: <https://digital.sbb.ch/de/design-system/mobile/components/container/>
///
/// See also:
/// - [SBBHeaderbox]: A variant of this component fixed below the [SBBHeader].
class SBBContentbox extends StatelessWidget {
  const SBBContentbox({
    super.key,
    this.margin,
    this.padding,
    this.color,
    this.isSemanticContainer = true,
    this.clipBehavior,
    required this.child,
  });

  /// The empty space that surrounds the [SBBContentbox].
  ///
  /// If this property is null then [SBBContentboxStyle.margin] is used, which defaults to
  /// [EdgeInsets.all(sbbDefaultSpacing)].
  final EdgeInsets? margin;

  /// The empty space that separates the [child] and the edge of [SBBContentbox].
  ///
  /// If this property is null then [SBBContentboxStyle.padding] is used, which defaults to
  /// [EdgeInsets.zero].
  final EdgeInsets? padding;

  /// The box's background color.
  ///
  /// If this property is null then the ambient [SBBContentboxStyle.color] is used, which is
  /// by default:
  /// * [SBBColors.white] in light mode
  /// * [SBBColors.charcoal] in dark mode
  final Color? color;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// If this property is null then [SBBContentboxStyle.clipBehavior] is used, which is by
  /// default [Clip.hardEdge].
  final Clip? clipBehavior;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// Defaults to true.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  ///
  /// This flag should be false if the card contains multiple different types
  /// of content.
  final bool isSemanticContainer;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final SBBContentboxStyle style = SBBContentboxStyle.of(context);

    return Semantics(
      container: isSemanticContainer,
      child: Padding(
        padding: margin ?? style.margin!,
        child: Material(
          key: key,
          type: MaterialType.card,
          color: color ?? style.color,
          shadowColor: style.shadowColor!,
          shape: style.shape!,
          clipBehavior: clipBehavior ?? style.clipBehavior!,
          child: Padding(
            padding: padding ?? style.padding!,
            child: Semantics(
              explicitChildNodes: !isSemanticContainer,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
