import 'dart:async';

import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// SBB Toast. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/toast>
class SBBToast {
  SBBToast._(this._overlayState);

  static const durationShort = const Duration(milliseconds: 2000);
  static const durationLong = const Duration(milliseconds: 3500);

  final OverlayState _overlayState;

  OverlayEntry? _overlayEntry;
  StreamController<bool>? _streamController;
  Timer? _fadeOutTimer;
  Timer? _removeTimer;

  static SBBToast of(BuildContext context) {
    return SBBToast._(Overlay.of(context, rootOverlay: true)!);
  }

  void show({required String message, Duration duration = durationShort}) {
    final showToastMessage = () {
      remove();
      _streamController = StreamController<bool>();
      _streamController!.add(true);
      _overlayEntry = _buildToastOverlayEntry(
        message,
        duration,
        _streamController!.stream,
      );
      _overlayState.insert(_overlayEntry!);
      _fadeOutTimer = Timer(duration + kThemeAnimationDuration * 2, () {
        _streamController?.add(false);
        _removeTimer = Timer(kThemeAnimationDuration, () => remove());
      });
    };

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

  OverlayEntry _buildToastOverlayEntry(
    String message,
    Duration duration,
    Stream<bool> stream,
  ) {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 30.0,
        child: Align(
          alignment: Alignment.center,
          child: IgnorePointer(
            child: _Toast(
              message: message,
              duration: duration,
              stream: stream,
            ),
          ),
        ),
      );
    });
  }
}

class _Toast extends StatefulWidget {
  const _Toast({
    Key? key,
    required this.message,
    required this.duration,
    required this.stream,
  }) : super(key: key);

  final String message;
  final Duration duration;
  final Stream<bool> stream;

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<_Toast> {
  bool _visible = false;

  @override
  void initState() {
    widget.stream.listen((visible) => setState(() => _visible = visible));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tooltipTheme = Theme.of(context).tooltipTheme;
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: kThemeAnimationDuration,
      child: Container(
        decoration: tooltipTheme.decoration,
        margin: tooltipTheme.margin,
        padding: tooltipTheme.padding,
        child: Text(
          widget.message,
          style: tooltipTheme.textStyle?.copyWith(
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
