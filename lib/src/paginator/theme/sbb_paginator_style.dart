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
    this.floatingBorderColor,
    this.floatingBoxShadow,
  });

  /// The foreground color of the paginator.dart circles.
  ///
  /// This affects the color of the circle indicators and their borders.
  /// The selected state is used for the currently active page.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The background color of the floating paginator.dart container.
  final WidgetStateProperty<Color?>? floatingBackgroundColor;

  /// The border color of the floating paginator.dart container.
  ///
  /// This affects the outline of the floating container.
  final WidgetStateProperty<Color?>? floatingBorderColor;

  /// The box shadow of the floating paginator.dart container.
  ///
  /// This creates the elevation effect for the floating variant.
  final WidgetStateProperty<List<BoxShadow>?>? floatingBoxShadow;

  SBBPaginatorStyle copyWith({
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? floatingBackgroundColor,
    WidgetStateProperty<Color?>? floatingBorderColor,
    WidgetStateProperty<List<BoxShadow>?>? floatingBoxShadow,
  }) {
    return SBBPaginatorStyle(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      floatingBackgroundColor: floatingBackgroundColor ?? this.floatingBackgroundColor,
      floatingBorderColor: floatingBorderColor ?? this.floatingBorderColor,
      floatingBoxShadow: floatingBoxShadow ?? this.floatingBoxShadow,
    );
  }

  SBBPaginatorStyle merge(SBBPaginatorStyle? other) {
    if (other == null) return this;

    return copyWith(
      foregroundColor: other.foregroundColor,
      floatingBackgroundColor: other.floatingBackgroundColor,
      floatingBorderColor: other.floatingBorderColor,
      floatingBoxShadow: other.floatingBoxShadow,
    );
  }

  static SBBPaginatorStyle? lerp(SBBPaginatorStyle? a, SBBPaginatorStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBPaginatorStyle(
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      floatingBackgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.floatingBackgroundColor,
        b?.floatingBackgroundColor,
        t,
        Color.lerp,
      ),
      floatingBorderColor: WidgetStateProperty.lerp<Color?>(
        a?.floatingBorderColor,
        b?.floatingBorderColor,
        t,
        Color.lerp,
      ),
      floatingBoxShadow: WidgetStateProperty.lerp<List<BoxShadow>?>(
        a?.floatingBoxShadow,
        b?.floatingBoxShadow,
        t,
        BoxShadow.lerpList,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBPaginatorStyle &&
        other.foregroundColor == foregroundColor &&
        other.floatingBackgroundColor == floatingBackgroundColor &&
        other.floatingBorderColor == floatingBorderColor &&
        other.floatingBoxShadow == floatingBoxShadow;
  }

  @override
  int get hashCode => Object.hash(
    foregroundColor,
    floatingBackgroundColor,
    floatingBorderColor,
    floatingBoxShadow,
  );
}
