import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// SBBGroup. Use to structure content.
///
/// May be placed anywhere in the screen to structure other components.
///
/// Referred to as `Container` component in the [SBB Design System](https://digital.sbb.ch/de/design-system/mobile/components/container/)
///
/// See also:
/// - [SBBHeaderbox]: A variant of this component fixed below the [SBBHeader].
class SBBGroup extends StatelessWidget {
  const SBBGroup({
    super.key,
    this.margin,
    this.padding,
    this.color,
    this.isSemanticContainer,
    this.clipBehavior,
    required this.child,
  });

  /// The empty space that surrounds the [SBBContentbox].
  ///
  /// If this property is null then [SBBGroupStyle.margin] is used, which defaults to
  /// [EdgeInsets.zero].
  final EdgeInsetsGeometry? margin;

  /// The empty space that separates the [child] and the edge of [SBBContentbox].
  ///
  /// If this property is null then [SBBGroupStyle.padding] is used, which defaults to
  /// [EdgeInsets.zero].
  final EdgeInsetsGeometry? padding;

  /// The box's background color.
  ///
  /// If this property is null then the ambient [SBBGroupStyle.color] is used, which is
  /// by default:
  /// * [SBBColors.white] in light mode
  /// * [SBBColors.charcoal] in dark mode
  final Color? color;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// If this property is null then [SBBGroupStyle.clipBehavior] is used, which is by
  /// default [Clip.hardEdge].
  final Clip? clipBehavior;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// If null, will use the value of [SBBGroupStyle.isSemanticContainer], which is by default
  /// true.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  ///
  /// This flag should be false if the card contains multiple different types
  /// of content.
  final bool? isSemanticContainer;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final SBBGroupStyle style = SBBGroupStyle.of(context);

    return Semantics(
      container: isSemanticContainer ?? style.isSemanticContainer!,
      child: Padding(
        padding: margin ?? style.margin!,
        child: Material(
          key: key,
          type: MaterialType.card,
          color: color ?? style.color,
          shape: style.shape!,
          clipBehavior: Clip.none,
          child: Padding(
            padding: padding ?? style.padding!,
            child: Semantics(
              explicitChildNodes: !(isSemanticContainer ?? style.isSemanticContainer!),
              child: Container(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
