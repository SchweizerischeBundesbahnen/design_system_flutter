import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'paginator_circle.dart';

class PaginatorCircles extends StatelessWidget {
  const PaginatorCircles({super.key, required this.numberCircles, required this.selectedCircle});

  final int numberCircles;
  final int selectedCircle;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: _buildCirclesWithSpacing);
  }

  List<Widget> get _buildCirclesWithSpacing {
    var result = <Widget>[];
    for (var i = 0; i < numberCircles; i++) {
      result.add(PaginatorCircle(isSelected: i == selectedCircle));
      if (_shouldAddSpacing(i)) {
        result.add(const SizedBox(width: SBBSpacing.xSmall));
      }
    }
    return result;
  }

  bool _shouldAddSpacing(int i) => i < numberCircles - 1;
}
