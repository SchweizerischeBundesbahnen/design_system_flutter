import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'pagination_circle.dart';

class PaginationCircles extends StatelessWidget {
  const PaginationCircles({super.key, required this.numberCircles, required this.selectedCircle});

  final int numberCircles;
  final int selectedCircle;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: _buildCirclesWithSpacing);
  }

  List<Widget> get _buildCirclesWithSpacing {
    var result = <Widget>[];
    for (var i = 0; i < numberCircles; i++) {
      result.add(PaginationCircle(isSelected: i == selectedCircle));
      if (_shouldAddSpacing(i)) {
        result.add(const SizedBox(width: sbbDefaultSpacing * .5));
      }
    }
    return result;
  }

  bool _shouldAddSpacing(int i) => i < numberCircles - 1;
}
