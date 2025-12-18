import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/container/container.dart';

import '../../sbb_design_system_mobile.dart';

@Deprecated('Use SBBContentBox.')
typedef SBBGroup = SBBContentBox;

/// SBBContentBox. Use to structure content.
///
/// May be placed anywhere in the screen to structure other components.
///
/// See also:
/// - [SBBHeaderbox]: A variant of this component fixed below the [SBBHeader].
/// - [Figma Design Specification](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=141-2024)
class SBBContentBox extends StatelessWidget {
  const SBBContentBox({
    super.key,
    this.margin,
    this.padding,
    this.color,
    this.isSemanticContainer,
    this.clipBehavior,
    required this.child,
  });

  /// The empty space that surrounds the [SBBContentBox].
  ///
  /// If this property is null then [SBBContentBoxStyle.margin] is used, which defaults to
  /// [EdgeInsets.zero].
  final EdgeInsetsGeometry? margin;

  /// The empty space that separates the [child] and the edge of [SBBContentBox].
  ///
  /// If this property is null then [SBBContentBoxStyle.padding] is used, which defaults to
  /// [EdgeInsets.zero].
  final EdgeInsetsGeometry? padding;

  /// The box's background color.
  ///
  /// If this property is null then the ambient [SBBContentBoxStyle.color] is used, which is
  /// by default:
  /// * [SBBColors.white] in light mode
  /// * [SBBColors.charcoal] in dark mode
  final Color? color;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// If this property is null then [SBBContentBoxStyle.clipBehavior] is used, which is by
  /// default [Clip.hardEdge].
  final Clip? clipBehavior;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// If null, will use the value of [SBBContentBoxStyle.isSemanticContainer], which is by default
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
    // TODO (@smallTrogdor): remove this with version 5.0.0
    final SBBContentBoxStyle legacyStyle = SBBContentBoxStyle.of(context);
    final SBBContentBoxStyle newStyle = Theme.of(context).sbbContentBoxTheme!.style!;

    final style = legacyStyle.merge(newStyle);

    return Semantics(
      container: isSemanticContainer ?? style.isSemanticContainer!,
      child: Padding(
        padding: margin ?? style.margin!,
        child: Material(
          key: key,
          type: MaterialType.card,
          color: color ?? style.color,
          shape: style.shape!,
          clipBehavior: clipBehavior ?? style.clipBehavior!,
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
