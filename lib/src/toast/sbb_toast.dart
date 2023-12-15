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
    buildToast(
        message,
        duration,
        bottom,
        (stream) => Toast.confirmation(
            message: message, duration: duration, stream: stream));
  }

  void warning({
    required String message,
    Duration duration = durationShort,
    double bottom = defaultBottom,
  }) {
    buildToast(
        message,
        duration,
        bottom,
        (stream) => Toast.warning(
            message: message, duration: duration, stream: stream));
  }

  void error({
    required String message,
    Duration duration = durationShort,
    double bottom = defaultBottom,
  }) {
    buildToast(
        message,
        duration,
        bottom,
        (stream) =>
            Toast.error(message: message, duration: duration, stream: stream));
  }

  void show({
    required String message,
    Duration duration = durationShort,
    double bottom = defaultBottom,
  }) {
    buildToast(
        message,
        duration,
        bottom,
        (stream) =>
            Toast(message: message, duration: duration, stream: stream));
  }

  void buildToast(
    String message,
    Duration duration,
    double bottom,
    Widget Function(Stream<bool> stream) toastBuilder,
  ) {
    final showToastMessage = () {
      remove();
      _streamController = StreamController<bool>();
      _streamController!.add(true);
      _overlayEntry = _buildToastOverlayEntry(
          message,
          duration,
          _streamController!.stream,
          bottom,
          toastBuilder(_streamController!.stream));
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

  OverlayEntry _buildToastOverlayEntry(String message, Duration duration,
      Stream<bool> stream, double bottom, Widget toast) {
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

@visibleForTesting
class Toast extends StatefulWidget {
  Toast.confirmation({
    required this.message,
    required this.duration,
    required this.stream,
  }) {
    this.backgroundColor = SBBColors.white;
    this.textColor = SBBColors.green;
    this.borderColor = SBBColors.green;
    this.icon = SBBIcons.tick_medium;
  }

  Toast.warning({
    required this.message,
    required this.duration,
    required this.stream,
  }) {
    this.backgroundColor = SBBColors.orange;
    this.textColor = SBBColors.white;
    this.icon = SBBIcons.sign_x_medium;
  }

  Toast.error({
    required this.message,
    required this.duration,
    required this.stream,
  }) {
    this.backgroundColor = SBBColors.red;
    this.textColor = SBBColors.white;
    this.icon = SBBIcons.sign_x_medium;
  }

  Toast({
    required this.message,
    required this.duration,
    required this.stream,
  }) {
    this.backgroundColor = SBBColors.metal;
    this.textColor = SBBColors.white;
    this.icon = SBBIcons.circle_information_small;
  }

  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;
  IconData? icon;
  final String message;
  final Duration duration;
  final Stream<bool> stream;

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<Toast> {
  static const _borderRadiusWeb = 2.0;
  bool _visible = false;

  @override
  void initState() {
    widget.stream.listen((visible) => setState(() => _visible = visible));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb =
        SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;

    final decorationWeb = BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(_borderRadiusWeb)),
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!)
            : null);
    final tooltipTheme = isWeb
        ? Theme.of(context).tooltipTheme.copyWith(decoration: decorationWeb)
        : Theme.of(context).tooltipTheme;

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: kThemeAnimationDuration,
      child: Container(
        decoration: tooltipTheme.decoration,
        margin: tooltipTheme.margin,
        padding: tooltipTheme.padding,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (isWeb)
              ...[
                Icon(
                widget.icon,
                color: widget.textColor,
              ),
                SizedBox(width: sbbDefaultSpacing / 2),
              ],
            Text(
              widget.message,
              style: tooltipTheme.textStyle?.copyWith(
                  decoration: TextDecoration.none, color: widget.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
