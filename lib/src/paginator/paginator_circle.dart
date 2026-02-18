import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class PaginatorCircle extends StatelessWidget {
  const PaginatorCircle({
    super.key,
    required this.isSelected,
    this.borderColor,
    this.fillColor,
  });

  final bool isSelected;

  final WidgetStateProperty<Color?>? borderColor;

  final WidgetStateProperty<Color?>? fillColor;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).sbbPaginatorTheme?.style;
    final effectiveBorderColor = borderColor ?? style?.circleBorderColor;
    final effectiveFillColor = fillColor ?? style?.circleFillColor;

    final resolvedBorderColor = effectiveBorderColor?.resolve({if (isSelected) WidgetState.selected});
    final resolvedFillColor = effectiveFillColor?.resolve({if (isSelected) WidgetState.selected});

    return AnimatedContainer(
      duration: Durations.medium1,
      width: SBBPaginatorStyle.circleSize.width,
      height: SBBPaginatorStyle.circleSize.height,
      decoration: BoxDecoration(
        color: resolvedFillColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: resolvedBorderColor ?? SBBColors.transparent,
          strokeAlign: isSelected ? BorderSide.strokeAlignOutside : BorderSide.strokeAlignInside,
        ),
      ),
    );
  }
}
