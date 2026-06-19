import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SBBHeaderStyleScope extends InheritedWidget {
  const SBBHeaderStyleScope({
    super.key,
    required this.style,
    required super.child,
  });

  final SBBHeaderStyle style;

  static SBBHeaderStyle of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SBBHeaderStyleScope>();
    assert(scope != null, 'No SBBHeaderStyleScope found in context');
    return scope!.style;
  }

  @override
  bool updateShouldNotify(SBBHeaderStyleScope oldWidget) => oldWidget.style != style;
}
