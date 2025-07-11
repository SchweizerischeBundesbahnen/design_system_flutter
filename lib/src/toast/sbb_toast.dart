import 'dart:async';

import 'package:flutter/material.dart';

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

  void confirmation({
    required String message,
    Duration duration = durationShort,
    double bottom = defaultBottom,
  }) {
    buildToast(message, duration, bottom,
        (stream) => Toast.confirmation(message: message, duration: duration, stream: stream));
  }

  void warning({
    required String message,
    Duration duration = durationShort,
    double bottom = defaultBottom,
  }) {
    buildToast(
        message, duration, bottom, (stream) => Toast.warning(message: message, duration: duration, stream: stream));
  }

  void error({
    required String message,
    Duration duration = durationShort,
    double bottom = defaultBottom,
  }) {
    buildToast(
        message, duration, bottom, (stream) => Toast.error(message: message, duration: duration, stream: stream));
  }

  void show({
    required String message,
    Duration duration = durationShort,
    double bottom = defaultBottom,
  }) {
    buildToast(message, duration, bottom, (stream) => Toast(title: message, duration: duration, stream: stream));
  }

  void buildToast(
    String message,
    Duration duration,
    double bottom,
    Widget Function(Stream<bool> stream) toastBuilder,
  ) {
    showToastMessage() {
      remove();
      _streamController = StreamController<bool>();
      _streamController!.add(true);
      _overlayEntry = _buildToastOverlayEntry(
          message, duration, _streamController!.stream, bottom, toastBuilder(_streamController!.stream));
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

  OverlayEntry _buildToastOverlayEntry(
      String message, Duration duration, Stream<bool> stream, double bottom, Widget toast) {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: 0.0,
        right: 0.0,
        bottom: bottom,
        child: Align(
          alignment: Alignment.center,
          child: IgnorePointer(
            child: toast,
          ),
        ),
      );
    });
  }
}

class Toast extends StatelessWidget {
  const Toast.confirmation({
    Key? key,
    required String message,
    required Duration duration,
    required Stream<bool> stream,
  }) : this(
          key: key,
          duration: duration,
          title: message,
          stream: stream,
          backgroundColor: SBBColors.white,
          textColor: SBBColors.green,
          icon: SBBIcons.tick_small,
        );

  const Toast.warning({
    Key? key,
    required String message,
    required Duration duration,
    required Stream<bool> stream,
  }) : this(
          key: key,
          duration: duration,
          title: message,
          stream: stream,
          backgroundColor: SBBColors.orange,
          textColor: SBBColors.white,
          icon: SBBIcons.sign_x_small,
        );

  const Toast.error({
    Key? key,
    required String message,
    required Duration duration,
    required Stream<bool> stream,
  }) : this(
          key: key,
          duration: duration,
          title: message,
          stream: stream,
          backgroundColor: SBBColors.red,
          textColor: SBBColors.white,
          icon: SBBIcons.sign_x_small,
        );

  const Toast({
    super.key,
    required this.title,
    required this.duration,
    required this.stream,
    this.backgroundColor = SBBColors.metal,
    this.textColor = SBBColors.white,
    this.icon = SBBIcons.circle_information_small,
  });

  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final String title;
  final Duration duration;
  final Stream<bool> stream;

  @override
  Widget build(BuildContext context) {
    final toastStyle = SBBToastStyle.of(context);

    return StreamBuilder<bool>(
        stream: stream,
        builder: (context, snapshot) {
          final isVisible = snapshot.data ?? false;
          return AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: kThemeAnimationDuration,
            child: Container(
              decoration: toastStyle.decoration,
              margin: toastStyle.margin,
              padding: toastStyle.padding,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(title, style: toastStyle.titleTextStyle),
                ],
              ),
            ),
          );
        });
  }
}
