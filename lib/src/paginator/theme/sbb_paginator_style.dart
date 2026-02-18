import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBPaginator].
///
/// Use this class in combination with [SBBPaginatorThemeData] to customize
/// the appearance of paginators throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBPaginator], the widget that uses this style.
/// * [SBBPaginatorThemeData], which applies this style theme-wide.
class SBBPaginatorStyle {
  const SBBPaginatorStyle({
    this.circleBorderColor,
    this.circleFillColor,
    this.floatingBackgroundColor,
    this.floatingBoxShadow,
  });

  /// The border color of the paginator circles.
  ///
  /// This affects the color of the circle borders.
  /// The selected state is used for the currently active page.
  final WidgetStateProperty<Color?>? circleBorderColor;

  /// The fill color of the paginator circles.
  ///
  /// This affects the color of the circle fill.
  /// The selected state is used for the currently active page.
  final WidgetStateProperty<Color?>? circleFillColor;

  /// The background color of the floating paginator container.
  final Color? floatingBackgroundColor;

  /// The box shadow of the floating paginator container.
  ///
  /// This creates the elevation effect for the floating variant.
  final List<BoxShadow>? floatingBoxShadow;

  /// The padding between the circles and the floating container.
  static EdgeInsets get floatingPadding =>
      EdgeInsets.symmetric(horizontal: SBBSpacing.xLarge, vertical: SBBSpacing.xxSmall);

  /// The size of the circles in the paginator.
  static Size get circleSize => Size.fromRadius(3.0);

  SBBPaginatorStyle copyWith({
    WidgetStateProperty<Color?>? circleBorderColor,
    WidgetStateProperty<Color?>? circleFillColor,
    Color? floatingBackgroundColor,
    List<BoxShadow>? floatingBoxShadow,
  }) {
    return SBBPaginatorStyle(
      circleBorderColor: circleBorderColor ?? this.circleBorderColor,
      circleFillColor: circleFillColor ?? this.circleFillColor,
      floatingBackgroundColor: floatingBackgroundColor ?? this.floatingBackgroundColor,
      floatingBoxShadow: floatingBoxShadow ?? this.floatingBoxShadow,
    );
  }

  SBBPaginatorStyle merge(SBBPaginatorStyle? other) {
    if (other == null) return this;

    return copyWith(
      circleBorderColor: other.circleBorderColor,
      circleFillColor: other.circleFillColor,
      floatingBackgroundColor: other.floatingBackgroundColor,
      floatingBoxShadow: other.floatingBoxShadow,
    );
  }

  static SBBPaginatorStyle? lerp(SBBPaginatorStyle? a, SBBPaginatorStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBPaginatorStyle(
      circleBorderColor: WidgetStateProperty.lerp<Color?>(a?.circleBorderColor, b?.circleBorderColor, t, Color.lerp),
      circleFillColor: WidgetStateProperty.lerp<Color?>(a?.circleFillColor, b?.circleFillColor, t, Color.lerp),
      floatingBackgroundColor: Color.lerp(a?.floatingBackgroundColor, b?.floatingBackgroundColor, t),
      floatingBoxShadow: BoxShadow.lerpList(a?.floatingBoxShadow, b?.floatingBoxShadow, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBPaginatorStyle &&
        other.circleBorderColor == circleBorderColor &&
        other.circleFillColor == circleFillColor &&
        other.floatingBackgroundColor == floatingBackgroundColor &&
        other.floatingBoxShadow == floatingBoxShadow;
  }

  @override
  int get hashCode => Object.hash(
    circleBorderColor,
    circleFillColor,
    floatingBackgroundColor,
    floatingBoxShadow,
  );
}
