import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/paginator/paginator_circle.dart';

import '../../sbb_design_system_mobile.dart';

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
    this.style,
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

  /// Customizes this paginator appearance.
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
        spacing: SBBSpacing.medium,
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
    super.style,
  }) : assert(numberPages > 0, 'numberPages: $numberPages must be greater than 0'),
       assert(
         currentPage >= 0 && currentPage < numberPages,
         'currentPage: $currentPage must be between 0 and numberPages - 1',
       );

  @override
  Widget build(BuildContext context) {
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
