import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/toast/default_toast_body.dart';

import '../../sbb_design_system_mobile.dart';

/// SBB Toast. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/toast>
class SBBToast {
  SBBToast._(this._overlayState);

  static const durationShort = Duration(milliseconds: 2000);
  static const durationLong = Duration(milliseconds: 3500);
  static const defaultBottom = 30.0;

  final OverlayState _overlayState;

  OverlayEntry? _overlayEntry;
  StreamController<bool>? _streamController;
  Timer? _fadeOutTimer;
  Timer? _removeTimer;

  static SBBToast of(BuildContext context) {
    return SBBToast._(Overlay.of(context, rootOverlay: true));
  }

  void show({
    required String title,
    Duration duration = durationShort,
    double bottom = defaultBottom,
    SBBToastStyle? style,
  }) {
    builder(
      duration: duration,
      bottom: bottom,
      builder: (stream) => DefaultToastBody(
        title: title,
        duration: duration,
        style: style,
        stream: stream,
      ),
    );
  }

  /// Use this to show a complete custom toast body.
  void builder({
    required Widget Function(Stream<bool> stream) builder,
    double bottom = defaultBottom,
    Duration duration = durationShort,
  }) {
    showToastMessage() {
      remove();
      _streamController = StreamController<bool>();
      _streamController!.add(true);
      _overlayEntry = _buildToastOverlayEntry(bottom, builder(_streamController!.stream));
      _overlayState.insert(_overlayEntry!);
      _fadeOutTimer = Timer(duration + kThemeAnimationDuration * 2, () {
        _streamController?.add(false);
        _removeTimer = Timer(kThemeAnimationDuration, () => remove());
      });
    }

    if (_overlayEntry != null && _removeTimer == null) {
      _removeTimer?.cancel();
      _removeTimer = null;
      _streamController?.add(false);
      _removeTimer = Timer(kThemeAnimationDuration, () => showToastMessage());
    } else {
      showToastMessage();
    }
  }

  void hide() {
    _streamController?.add(false);
    _removeTimer = Timer(kThemeAnimationDuration, () => remove());
  }

  void remove() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _removeTimer?.cancel();
    _removeTimer = null;
    _fadeOutTimer?.cancel();
    _fadeOutTimer = null;
    _streamController?.close();
    _streamController = null;
  }

  OverlayEntry _buildToastOverlayEntry(double bottom, Widget toast) {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: 0.0,
        right: 0.0,
        bottom: bottom,
        child: Align(
          alignment: Alignment.center,
          child: IgnorePointer(child: toast),
        ),
      );
    });
  }
}
