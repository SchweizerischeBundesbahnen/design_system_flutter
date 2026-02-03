import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'paginator_circles.dart';

const double _kFloatingPaddingHeight = 4.0;
const double _kFloatingPaddingWidth = 36.0;
const double _kFloatingShadowBlurRadius = 8.0;

// TODO: change theming and style to v5 variant
// TODO: add constants to style as static getter
// TODO: improve docs
// TODO: add to migration guide / CHANGELOG

/// The SBB Paginator.
///
/// The semantics value will be the [currentpage] + 1. The semantics is marked as readonly.
///
/// See also:
/// * [SBBPaginatorFloating] for a floating variant of this to position on top of any content
/// * [SBBPaginatorThemeData] for customizing the style of the paginator.dart across the current theme
/// * [SBBPaginatorStyle] for adjusting the appearance of the paginator.dart
/// * Guidelines for usage on [digital.sbb.ch](https://digital.sbb.ch/de/design-system/mobile/components/paginator/)
class SBBPaginator extends StatelessWidget {
  const SBBPaginator({
    super.key,
    required this.numberPages,
    required this.currentPage,
    this.semanticsLabel,
  }) : assert(numberPages > 0, 'numberPages: $numberPages must be greater than 0'),
       assert(
         currentPage >= 0 && currentPage < numberPages,
         'currentPage: $currentPage must be between 0 and numberPages - 1',
       );

  /// The total number of pages.
  ///
  /// Must be greater than 0. If it is 1, no paginator.dart is shown.
  final int numberPages;

  /// The index of the current page, starting at 0.
  ///
  /// Must be between 0 and [numberPages] - 1.
  final int currentPage;

  /// The semantics label of the paginator.dart.
  ///
  /// Defaults to 'Paginator'.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    if (numberPages <= 1) {
      return const SizedBox.shrink();
    }
    return Semantics(
      label: semanticsLabel,
      value: '${currentPage + 1}',
      maxValueLength: numberPages,
      readOnly: true,
      child: PaginatorCircles(numberCircles: numberPages, selectedCircle: currentPage),
    );
  }
}

/// The floating variant of the SBB Paginator.
///
/// Adds a padded container with shadow and background color according to the applied style to the underlying
/// paginator.dart.
///
/// This should be used on top of any content within a [Stack].
class SBBPaginatorFloating extends SBBPaginator {
  const SBBPaginatorFloating({
    super.key,
    required super.numberPages,
    required super.currentPage,
    super.semanticsLabel,
  }) : assert(numberPages > 0, 'numberPages: $numberPages must be greater than 0'),
       assert(
         currentPage >= 0 && currentPage < numberPages,
         'currentPage: $currentPage must be between 0 and numberPages - 1',
       );

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).sbbPaginatorTheme;
    final style = themeData?.style;

    final backgroundColor = style?.floatingBackgroundColor;
    final boxShadow = style?.floatingBoxShadow;

    return Container(
      decoration: _createBoxDecorationWith(backgroundColor, boxShadow),
      padding: _floatingPadding,
      child: super.build(context),
    );
  }

  BoxDecoration _createBoxDecorationWith(Color? backgroundColor, List<BoxShadow>? boxShadow) => BoxDecoration(
    borderRadius: BorderRadius.circular(_kFloatingPaddingHeight * 2),
    color: backgroundColor,
    boxShadow: boxShadow,
  );

  EdgeInsets get _floatingPadding =>
      const EdgeInsets.symmetric(horizontal: _kFloatingPaddingWidth, vertical: _kFloatingPaddingHeight);
}
