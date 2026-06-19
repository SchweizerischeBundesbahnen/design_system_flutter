import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/theme/sbb_base_style.dart';

/// Asserts that the given context has a [SBBBaseStyle] theme extension registered
/// in the nearest [Theme].
///
/// Used by SBB Design System widgets to make sure they are only used in contexts
/// where the SBB theme has been properly set up.
///
/// To call this function, use the following pattern, typically in the
/// relevant Widget's build method:
///
/// ```dart
/// assert(debugCheckHasSBBBaseStyle(context));
/// ```
///
/// Always place this before any early returns, so that the invariant is checked
/// in all cases. This prevents bugs from hiding until a particular codepath is
/// hit.
///
/// Does nothing if asserts are disabled. Always returns true.
bool debugCheckHasSBBBaseStyle(BuildContext context) {
  assert(() {
    if (Theme.of(context).extension<SBBBaseStyle>() == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No SBBBaseStyle found in the widget tree.'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a SBBBaseStyle theme extension '
          'to be present in the nearest Theme.',
        ),
        ErrorHint(
          'To fix this, ensure that your widget is placed inside a MaterialApp '
          'that uses SBBTheme to set up the theme, for example:\n'
          '  MaterialApp(\n'
          '    theme: SBBTheme.light(),\n'
          '    darkTheme: SBBTheme.dark(),\n'
          '    ...\n'
          '  )',
        ),
      ]);
    }
    return true;
  }());
  return true;
}
