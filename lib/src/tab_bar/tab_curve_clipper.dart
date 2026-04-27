import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_curves.dart';

class TabCurveClipper extends CustomClipper<Path> {
  TabCurveClipper({
    required this.curves,
  });

  final List<TabCurves> curves;

  @override
  Path getClip(Size size) {
    return TabCurves.toPath(curves, size);
  }

  @override
  bool shouldReclip(TabCurveClipper oldClipper) {
    return oldClipper.curves.length != curves.length ||
        oldClipper.curves.mapIndexed((i, c) => c != curves[i]).any((c) => c);
  }
}
