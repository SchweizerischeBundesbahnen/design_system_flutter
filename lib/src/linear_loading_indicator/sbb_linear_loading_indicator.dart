import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';

/// The SBB Linear Loading Indicator.
///
/// A thin bar that slides back and forth to indicate an ongoing, indeterminate
/// operation. It fills the width of its parent, so place it inside a widget
/// that gives it a bounded width, such as a [SizedBox], a [Positioned] inside
/// a [Stack], or a full-width container.
///
/// If the parent has rounded corners, wrap this widget in a [ClipRRect] with
/// a matching border radius to keep the indicator clipped to those corners.
///
/// ## Sample code
///
/// ```dart
/// SizedBox(
///   width: .infinity,
///   child: SBBLinearLoadingIndicator(),
/// )
/// ```
///
/// ## Customization
///
/// Use [style] to customize the appearance of a single indicator, or
/// [SBBLinearLoadingIndicatorThemeData] to apply consistent styling across
/// your app:
///
/// ```dart
/// SBBLinearLoadingIndicator(
///   style: SBBLinearLoadingIndicatorStyle(
///     color: Colors.white,
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBLinearLoadingIndicatorStyle], for customizing the appearance.
///  * [SBBLinearLoadingIndicatorThemeData], for setting the theme across your app.
class SBBLinearLoadingIndicator extends StatefulWidget {
  const SBBLinearLoadingIndicator({super.key, this.style});

  /// {@template sbb_design_system.linear_loading_indicator.style}
  /// Customizes this indicator's appearance.
  ///
  /// Non-null properties of this style override the corresponding properties
  /// in [SBBLinearLoadingIndicatorThemeData.style] from the current theme.
  /// {@endtemplate}
  final SBBLinearLoadingIndicatorStyle? style;

  @override
  State<SBBLinearLoadingIndicator> createState() => _SBBLinearLoadingIndicatorState();
}

class _SBBLinearLoadingIndicatorState extends State<SBBLinearLoadingIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: SBBLinearLoadingIndicatorStyle.duration,
    vsync: this,
  )..repeat();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0.0),
    end: const Offset(1, 0.0),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasSBBBaseStyle(context));

    final style = Theme.of(context).sbbLinearLoadingIndicatorTheme.style!.merge(widget.style);
    final color = style.color!;

    return SlideTransition(
      transformHitTests: false,
      position: _offsetAnimation,
      child: SizedBox(
        width: .infinity,
        height: SBBLinearLoadingIndicatorStyle.height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.0), color],
              stops: [1.0 - SBBLinearLoadingIndicatorStyle.widthRatio, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
