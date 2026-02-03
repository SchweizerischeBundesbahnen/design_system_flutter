import 'package:flutter/material.dart';

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
    this.foregroundColor,
    this.floatingBackgroundColor,
    this.floatingBoxShadow,
  });

  /// The foreground color of the paginator circles.
  ///
  /// This affects the color of the circle indicators and their borders.
  /// The selected state is used for the currently active page.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The background color of the floating paginator container.
  final Color? floatingBackgroundColor;

  /// The box shadow of the floating paginator container.
  ///
  /// This creates the elevation effect for the floating variant.
  final List<BoxShadow>? floatingBoxShadow;

  SBBPaginatorStyle copyWith({
    WidgetStateProperty<Color?>? foregroundColor,
    Color? floatingBackgroundColor,
    List<BoxShadow>? floatingBoxShadow,
  }) {
    return SBBPaginatorStyle(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      floatingBackgroundColor: floatingBackgroundColor ?? this.floatingBackgroundColor,
      floatingBoxShadow: floatingBoxShadow ?? this.floatingBoxShadow,
    );
  }

  SBBPaginatorStyle merge(SBBPaginatorStyle? other) {
    if (other == null) return this;

    return copyWith(
      foregroundColor: other.foregroundColor,
      floatingBackgroundColor: other.floatingBackgroundColor,
      floatingBoxShadow: other.floatingBoxShadow,
    );
  }

  static SBBPaginatorStyle? lerp(SBBPaginatorStyle? a, SBBPaginatorStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBPaginatorStyle(
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      floatingBackgroundColor: Color.lerp(a?.floatingBackgroundColor, b?.floatingBackgroundColor, t),
      floatingBoxShadow: BoxShadow.lerpList(a?.floatingBoxShadow, b?.floatingBoxShadow, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBPaginatorStyle &&
        other.foregroundColor == foregroundColor &&
        other.floatingBackgroundColor == floatingBackgroundColor &&
        other.floatingBoxShadow == floatingBoxShadow;
  }

  @override
  int get hashCode => Object.hash(
    foregroundColor,
    floatingBackgroundColor,
    floatingBoxShadow,
  );
}
