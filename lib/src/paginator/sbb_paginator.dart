import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'paginator_circles.dart';

const double _kFloatingPaddingHeight = 4.0;
const double _kFloatingPaddingWidth = 36.0;
const double _kFloatingShadowBlurRadius = 8.0;

// TODO: change example app page to showcase good floating
// TODO: change theming and style to v5 variant
// TODO: add constants to style as static getter
// TODO: Change isFloating to SBBPaginatorFloating

/// The SBB Paginator.
///
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/paginator/).
///
/// For the floating variant, set [isFloating] to true.
///
/// The semantics value will be the [currentpage] + 1. The semantics is marked as readonly.
class SBBPaginator extends StatelessWidget {
  const SBBPaginator({
    super.key,
    required this.numberPages,
    required this.currentPage,
    this.isFloating = false,
    this.semanticsLabel = 'Paginator',
  }) : assert(numberPages > 0, 'numberPages: $numberPages must be greater than 0'),
       assert(
         currentPage >= 0 && currentPage < numberPages,
         'currentPage: $currentPage must be between 0 and numberPages - 1',
       );

  /// The total number of pages.
  ///
  /// Must be greater than 0. If it is 1, no paginator is shown.
  final int numberPages;

  /// The index of the current page, starting at 0.
  ///
  /// Must be between 0 and [numberPages] - 1.
  final int currentPage;

  /// Whether the paginator is floating or not.
  ///
  /// Defaults to false.
  final bool isFloating;

  /// The semantics label of the paginator.
  ///
  /// Defaults to 'Paginator'.
  final String semanticsLabel;

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
      child: _paginationContent,
    );
  }

  Widget get _paginationContent => isFloating
      ? _FloatingSBBPaginator(currentPage: currentPage, numberPages: numberPages)
      : _DefaultSBBPaginator(numberPages: numberPages, currentPage: currentPage);
}

/// The default (non-floating) paginator.
class _DefaultSBBPaginator extends StatelessWidget {
  const _DefaultSBBPaginator({required this.numberPages, required this.currentPage});

  final int numberPages;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return PaginatorCircles(numberCircles: numberPages, selectedCircle: currentPage);
  }
}

/// The Floating SBB Paginator.
///
/// Padded container with shadow and background color.
class _FloatingSBBPaginator extends StatelessWidget {
  const _FloatingSBBPaginator({required this.numberPages, required this.currentPage});

  final int numberPages;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).pagination!;
    return Container(
      decoration: _createBoxDecorationWith(style),
      padding: _floatingPadding,
      child: PaginatorCircles(numberCircles: numberPages, selectedCircle: currentPage),
    );
  }

  BoxDecoration _createBoxDecorationWith(SBBPaginatorStyle style) => BoxDecoration(
    borderRadius: BorderRadius.circular(_kFloatingPaddingHeight * 2),
    color: style.floatingBackgroundColor,
    boxShadow: [BoxShadow(color: SBBColors.black.withValues(alpha: 0.2), blurRadius: _kFloatingShadowBlurRadius)],
  );

  EdgeInsets get _floatingPadding =>
      const EdgeInsets.symmetric(horizontal: _kFloatingPaddingWidth, vertical: _kFloatingPaddingHeight);
}
