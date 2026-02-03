import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const double _selectedWidth = 8.0;
const double _unselectedWidth = 6.0;
const EdgeInsets _unselectedPadding = EdgeInsets.all(1.0);

class PaginatorCircle extends StatelessWidget {
  const PaginatorCircle({
    super.key,
    required this.isSelected,
    this.circleBorderColor,
    this.circleFillColor,
  });

  final bool isSelected;

  final WidgetStateProperty<Color?>? circleBorderColor;

  final WidgetStateProperty<Color?>? circleFillColor;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).sbbPaginatorTheme?.style;
    final effectiveBorderColor = circleBorderColor ?? style?.circleBorderColor;
    final effectiveFillColor = circleFillColor ?? style?.circleFillColor;

    final resolvedBorderColor = effectiveBorderColor?.resolve({if (isSelected) WidgetState.selected});
    final resolvedFillColor = effectiveFillColor?.resolve({if (isSelected) WidgetState.selected});

    return AnimatedContainer(
      margin: isSelected ? EdgeInsets.zero : _unselectedPadding,
      duration: Durations.medium1,
      width: isSelected ? _selectedWidth : _unselectedWidth,
      height: isSelected ? _selectedWidth : _unselectedWidth,
      decoration: BoxDecoration(
        color: resolvedFillColor,
        shape: BoxShape.circle,
        border: Border.all(color: resolvedBorderColor ?? SBBColors.transparent),
      ),
    );
  }
}
