import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import 'pagination_circles.dart';

const double _kFloatingPaddingHeight = 4.0;
const double _kFloatingPaddingWidth = 36.0;
const double _kFloatingShadowBlurRadius = 8.0;

/// The SBB Pagination.
///
/// Use according to documentation at https://digital.sbb.ch/de/design-system/mobile/components/pagination/
/// The semantics value will be the current page + 1 and are marked as readonly.
class SBBPagination extends StatelessWidget {
  const SBBPagination({
    super.key,
    required this.numberPages,
    required this.currentPage,
    this.isFloating = false,
    this.semanticsLabel = 'Pagination',
  })  : assert(numberPages > 0,
            'numberPages: $numberPages must be greater than 0'),
        assert(currentPage >= 0 && currentPage < numberPages,
            'currentPage: $currentPage must be between 0 and numberPages - 1');

  /// The total number of pages.
  ///
  /// Must be greater than 0. If it is 1, no pagination is shown.
  final int numberPages;

  /// The index of the current page, starting at 0.
  ///
  /// Must be between 0 and [numberPages] - 1.
  final int currentPage;

  /// Whether the pagination is floating or not.
  ///
  /// Defaults to false.
  final bool isFloating;

  /// The semantics label of the pagination.
  ///
  /// Defaults to 'Pagination'.
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    if (numberPages <= 1) {
      return SizedBox.shrink();
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
      ? _FloatingSBBPagination(
          currentPage: currentPage,
          numberPages: numberPages,
        )
      : _DefaultSBBPagination(
          numberPages: numberPages,
          currentPage: currentPage,
        );
}

/// The default pagination.
class _DefaultSBBPagination extends StatelessWidget {
  const _DefaultSBBPagination({
    required this.numberPages,
    required this.currentPage,
  });

  final int numberPages;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return PaginationCircles(
      numberCircles: numberPages,
      selectedCircle: currentPage,
    );
  }
}

/// The Floating SBB Pagination.
///
/// Padded container with shadow and background color.
class _FloatingSBBPagination extends StatelessWidget {
  const _FloatingSBBPagination({
    required this.numberPages,
    required this.currentPage,
  });

  final int numberPages;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).pagination!;
    return Container(
      decoration: _createBoxDecorationWith(style),
      padding: _floatingPadding,
      child: PaginationCircles(
        numberCircles: numberPages,
        selectedCircle: currentPage,
      ),
    );
  }

  BoxDecoration _createBoxDecorationWith(SBBPaginationStyle style) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(_kFloatingPaddingHeight * 2),
        color: style.floatingBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: SBBColors.black.withOpacity(0.2),
            blurRadius: _kFloatingShadowBlurRadius,
          )
        ],
      );

  EdgeInsets get _floatingPadding => const EdgeInsets.symmetric(
        horizontal: _kFloatingPaddingWidth,
        vertical: _kFloatingPaddingHeight,
      );
}
