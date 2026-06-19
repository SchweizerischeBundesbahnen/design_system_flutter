import 'package:flutter/widgets.dart';

/// Configuration for the layout and focus related fields of [SBBDecoratedText].
///
/// Pass an instance of this class to the `triggerConfig` parameter of
/// [SBBDropdown] or [SBBMultiDropdown].
///
/// See also:
///
/// * [SBBDropdown], which accepts this config via `triggerConfig`.
/// * [SBBMultiDropdown], which accepts this config via `triggerConfig`.
/// * [SBBDecoratedText], the widget that these properties are forwarded to.
class SBBDecoratedTextConfig {
  const SBBDecoratedTextConfig({
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.focusNode,
    this.autofocus = false,
  }) : assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         "minLines can't be greater than maxLines",
       ),
       assert(
         !expands || (maxLines == null && minLines == null),
         'minLines and maxLines must be null when expands is true.',
       );

  /// {@macro sbb_design_system.sbb_decorated_text.maxLines}
  final int? maxLines;

  /// {@macro sbb_design_system.sbb_decorated_text.minLines}
  final int? minLines;

  /// {@macro sbb_design_system.sbb_decorated_text.expands}
  final bool expands;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBDecoratedTextConfig &&
        other.maxLines == maxLines &&
        other.minLines == minLines &&
        other.expands == expands &&
        other.focusNode == focusNode &&
        other.autofocus == autofocus;
  }

  @override
  int get hashCode => Object.hash(maxLines, minLines, expands, focusNode, autofocus);

  @override
  String toString() {
    return 'SBBDecoratedTextConfig('
        'maxLines: $maxLines, '
        'minLines: $minLines, '
        'expands: $expands, '
        'focusNode: $focusNode, '
        'autofocus: $autofocus'
        ')';
  }
}
