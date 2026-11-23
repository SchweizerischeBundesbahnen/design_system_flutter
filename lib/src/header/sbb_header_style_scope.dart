import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class const SBBHeaderStyleScope({
  super.key,
  required final SBBHeaderStyle style,
  required super.child,
}) extends InheritedWidget {
  static SBBHeaderStyle of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SBBHeaderStyleScope>();
    assert(scope != null, 'No SBBHeaderStyleScope found in context');
    return scope!.style;
  }

  @override
  bool updateShouldNotify(SBBHeaderStyleScope oldWidget) => oldWidget.style != style;
}
