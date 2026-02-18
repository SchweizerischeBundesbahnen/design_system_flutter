import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/paginator/paginator_circle.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB paginator to display page navigation information
///
/// The paginator shows circular indicators for each page.
/// The indicator for the current page is highlighted with the [WidgetState.selected] state.
///
/// The paginator is not displayed if [numberPages] is 1 or less.
///
/// See also:
///
///  * [SBBPaginatorFloating], for a floating variant positioned on top of content.
///  * [SBBPaginatorThemeData], for customizing the paginator style across the current theme.
///  * [SBBPaginatorStyle], for adjusting the appearance of a paginator.
///  * Guidelines on [digital.sbb.ch](https://digital.sbb.ch/de/design-system/mobile/components/paginator/)
class SBBPaginator extends StatelessWidget {
  const SBBPaginator({
    super.key,
    required this.numberPages,
    required this.currentPage,
    this.semanticsLabel,
    this.style,
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

  /// The semantics label of the paginator.
  ///
  /// The semantics value will be the [currentPage] + 1.
  final String? semanticsLabel;

  /// Customizes this paginator's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBPaginatorThemeData.style] of the theme found in [context].
  final SBBPaginatorStyle? style;

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
      child: Row(
        spacing: SBBSpacing.xSmall,
        mainAxisSize: MainAxisSize.min,
        children: _circles(style?.circleFillColor, style?.circleBorderColor),
      ),
    );
  }

  List<Widget> _circles(
    WidgetStateProperty<Color?>? widgetFillColor,
    WidgetStateProperty<Color?>? widgetBorderColor,
  ) {
    return List<Widget>.generate(
      numberPages,
      (idx) => PaginatorCircle(
        isSelected: idx == currentPage,
        fillColor: widgetFillColor,
        borderColor: widgetBorderColor,
      ),
      growable: false,
    );
  }
}

/// The floating variant of the SBB Paginator.
///
/// Adds a padded container with shadow and background color according to the applied style
/// to the underlying paginator. This variant is designed to be positioned on top of content,
/// typically within a [Stack].
///
/// Example:
///
/// ```dart
/// Stack(
///   alignment: Alignment.bottomCenter,
///   children: [
///     // Your page content here
///     PageView(
///       children: [/* pages */],
///     ),
///     // Floating paginator positioned at the bottom
///     Padding(
///       padding: const EdgeInsets.all(SBBSpacing.medium),
///       child: SBBPaginatorFloating(
///         numberPages: 5,
///         currentPage: currentPage,
///       ),
///     ),
///   ],
/// )
/// ```
///
/// See also:
///
///  * [SBBPaginator], for a standard paginator without floating behavior.
///  * [SBBPaginatorThemeData], for customizing the paginator style across the current theme.
///  * [SBBPaginatorStyle], for adjusting the appearance of individual paginators.
class SBBPaginatorFloating extends SBBPaginator {
  const SBBPaginatorFloating({
    super.key,
    required super.numberPages,
    required super.currentPage,
    super.semanticsLabel,
    super.style,
  }) : assert(numberPages > 0, 'numberPages: $numberPages must be greater than 0'),
       assert(
         currentPage >= 0 && currentPage < numberPages,
         'currentPage: $currentPage must be between 0 and numberPages - 1',
       );

  @override
  Widget build(BuildContext context) {
    if (numberPages <= 1) {
      return const SizedBox.shrink();
    }

    final themeStyle = Theme.of(context).sbbPaginatorTheme?.style;
    final effectiveStyle = themeStyle?.merge(style);

    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: effectiveStyle?.floatingBackgroundColor,
        shadows: effectiveStyle?.floatingBoxShadow,
      ),
      padding: SBBPaginatorStyle.floatingPadding,
      child: super.build(context),
    );
  }
}
