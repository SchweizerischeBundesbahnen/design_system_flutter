import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const double _selectedWidth = 8.0;
const double _unselectedWidth = 6.0;
const EdgeInsets _unselectedPadding = EdgeInsets.all(1.0);

class PaginatorCircle extends StatelessWidget {
  const PaginatorCircle({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).pagination!;
    final resolvedDrawingColor = isSelected ? style.selectedColor! : style.borderColor!;

    return AnimatedContainer(
      margin: isSelected ? EdgeInsets.zero : _unselectedPadding,
      duration: Durations.medium1,
      width: isSelected ? _selectedWidth : _unselectedWidth,
      height: isSelected ? _selectedWidth : _unselectedWidth,
      decoration: BoxDecoration(
        color: isSelected ? resolvedDrawingColor : null,
        shape: BoxShape.circle,
        border: Border.all(color: resolvedDrawingColor),
      ),
    );
  }
}
