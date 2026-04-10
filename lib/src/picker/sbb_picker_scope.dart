import 'dart:math';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'sbb_picker_constants.dart';

/// An [InheritedWidget] that propagates the computed picker item height and
/// text-measurement helpers to all descendant picker widgets.
///
/// Placed at the root of every [SBBPicker] build, so [SBBPickerScrollView]
/// and the time-based picker states can read the shared item height without
/// inheriting from a common abstract state class.
///
/// Rebuilds its subtree whenever [itemHeight], [visibleItemCount],
/// [pickerStyle], or the ambient [MediaQuery.textScaler] changes.
class SBBPickerScope extends InheritedWidget {
  const SBBPickerScope({
    super.key,
    required this.itemHeight,
    required this.visibleItemCount,
    required this.pickerStyle,
    required super.child,
  });

  /// The computed height of a single picker item in logical pixels.
  final double itemHeight;

  /// The number of visible items shared by all picker columns in this scope.
  final int visibleItemCount;

  /// The effective resolved [SBBPickerStyle] for this picker subtree.
  final SBBPickerStyle? pickerStyle;

  /// Returns the nearest [SBBPickerScope] ancestor or throws if none is found.
  static SBBPickerScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SBBPickerScope>();
    assert(scope != null, 'No SBBPickerScope found in context. Make sure SBBPicker wraps the widget tree.');
    return scope!;
  }

  /// Returns the nearest [SBBPickerScope] ancestor or null if none is found.
  static SBBPickerScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SBBPickerScope>();
  }

  @override
  bool updateShouldNotify(SBBPickerScope oldWidget) {
    return itemHeight != oldWidget.itemHeight ||
        visibleItemCount != oldWidget.visibleItemCount ||
        pickerStyle != oldWidget.pickerStyle;
  }
}

/// A stateful widget that owns the item-height computation and hosts an
/// [SBBPickerScope] around its [child].
///
/// Insert this widget immediately inside the [SBBPicker] build so that the
/// scope is available to all descendant [SBBPickerScrollView]s.
class SBBPickerScopeHost extends StatefulWidget {
  const SBBPickerScopeHost({
    super.key,
    required this.visibleItemCount,
    required this.pickerStyle,
    required this.child,
  });

  final int visibleItemCount;
  final SBBPickerStyle? pickerStyle;
  final Widget child;

  @override
  State<SBBPickerScopeHost> createState() => _SBBPickerScopeHostState();
}

class _SBBPickerScopeHostState extends State<SBBPickerScopeHost> {
  late double _itemHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemHeight = _calculateItemHeight();
  }

  @override
  void didUpdateWidget(SBBPickerScopeHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pickerStyle != widget.pickerStyle) {
      _itemHeight = _calculateItemHeight();
    }
  }

  double _calculateItemHeight() {
    final singleCharHeight = _textSize('0').height;
    return max(singleCharHeight, pickerItemDefaultHeight);
  }

  Size _textSize(String text) {
    final textStyle = widget.pickerStyle?.textStyle;
    final textSpan = TextSpan(text: text, style: textStyle);
    final textDirection = Directionality.of(context);
    final painter = TextPainter(
      text: textSpan,
      maxLines: 1,
      textScaler: MediaQuery.of(context).textScaler,
      textDirection: textDirection,
    );
    painter.layout();
    return painter.size;
  }

  /// Measures text using the current picker style and text scaler.
  ///
  /// Exposed so that picker states hosted inside the scope can reuse the same
  /// measurement logic without duplicating the painter setup.
  Size measureText(String text) => _textSize(text);

  @override
  Widget build(BuildContext context) {
    return SBBPickerScope(
      itemHeight: _itemHeight,
      visibleItemCount: widget.visibleItemCount,
      pickerStyle: widget.pickerStyle,
      child: widget.child,
    );
  }
}
