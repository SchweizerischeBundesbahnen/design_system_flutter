import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/toast/default_toast_body.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_scope.dart';

import '../../sbb_design_system_mobile.dart';

/// A dismissible message overlay that appears at the bottom of the screen, typically for transient notifications.
///
/// [SBBToast] automatically dismisses after a specified duration and
/// by default must contain a title and an optional action.
///
/// Access the toast through [SBBToast.of] within a [BuildContext] and use the [SBBToast.show] method for
/// default SBB toast appearance:
///
/// ```dart
/// SBBPrimaryButton(
///   label: 'Show Toast',
///   onPressed: () {
///     SBBToast.of(context).show(titleText: 'Hello from SBBToast!');
///   },
/// )
/// ```
///
/// Use the [SBBToastStyle] to customize colors, text styles, gaps, and more:
///
/// For full control over the toast content while maintaining default positioning and lifecycle,
/// use the [builder] method.
///
/// The toast automatically hides and removes itself after the specified [duration].
/// Use [hide] to fade out gracefully, or [remove] to dismiss immediately.
///
/// See also:
///
/// * [SBBToastStyle], for customizing the toast's appearance.
/// * [SBBToastThemeData] for customizing the toast's appearance across the entire application
/// * [SBBToastAction], for action buttons with automatic toast dismissal.
/// * <https://digital.sbb.ch/de/design-system/mobile/components/toast/>
class SBBToast {
  SBBToast._(this._overlayState);

  static const durationShort = Duration(milliseconds: 2000);
  static const durationLong = Duration(milliseconds: 3500);

  final OverlayState _overlayState;

  OverlayEntry? _overlayEntry;
  StreamController<bool>? _streamController;
  Timer? _fadeOutTimer;
  Timer? _removeTimer;

  static SBBToast of(BuildContext context) {
    return SBBToast._(Overlay.of(context, rootOverlay: true));
  }

  /// Shows a [SBBToast] with a default body layout.
  ///
  /// Either [titleText] or [title] must be provided (mutually exclusive).
  ///
  /// **Layout behavior:**
  /// The title and optional action are laid out intelligently:
  /// - In most scenarios, the action and the title appear on the same line with the title being wrapped to make
  ///   space for the action.
  /// - If however, the action width exceeds the threshold (default 25% of total AVAILABLE width), the action is
  ///   wrapped to the next line, separated from the title by [SBBToastStyle.titleActionVerticalGap].
  ///   Also, the title is then constrained to 60% of the total available width.
  /// - Therefore, if the [SBBToastStyle.actionOverflowThreshold] is set to zero, it will always wrap to the next line.
  ///   If the threshold is set to one on the other hand, it will always stay on the same line.
  ///
  ///
  /// **Parameters:**
  /// - [title]: A custom widget for the main content. Prefer [titleText] for simple text.
  /// - [titleText]: Text string displayed as the main content using standard design.
  /// - [duration]: How long the toast remains visible (default: [durationShort]).
  /// - [bottom]: Distance from the screen bottom (default: [SBBSpacing.xLarge]).
  /// - [action]: Optional action button, typically a [SBBToastAction]. Wrapped in a gesture detector
  ///   and hides the toast on tap by default.
  /// - [style]: Customizes colors, text styles, gaps, and other visual properties.
  ///   See [SBBToastStyle] for all available options.
  ///
  /// **Example:**
  /// ```dart
  /// SBBToast.of(context).show(
  ///   titleText: 'File saved',
  ///   action: SBBToastAction(
  ///     title: 'Undo',
  ///     onTap: () => undoSave(),
  ///   ),
  ///   duration: SBBToast.durationLong,
  /// );
  /// ```
  void show({
    Widget? title,
    String? titleText,
    Widget? action,
    SBBToastStyle? style,
    Duration duration = durationShort,
    double bottom = SBBSpacing.xLarge,
  }) {
    assert(titleText == null || title == null, 'Cannot provide both titleText and title!');
    assert(titleText != null || title != null, 'One of titleText or title must be set!');
    _builder(
      duration: duration,
      bottom: bottom,
      style: style,
      builder: (_, _) => DefaultToastBody(
        title: title,
        titleText: titleText,
        action: action,
      ),
    );
  }

  /// Shows a toast with a completely custom body.
  ///
  /// This method provides full control over toast content while maintaining default positioning,
  /// visibility state management, and lifecycle handling.
  ///
  /// The [builder] function receives:
  /// - [BuildContext]: The build context for accessing theme and other dependencies.
  /// - [Stream<bool>]: A stream indicating visibility state (true = visible, false = fading out).
  ///   Use this to animate your content during the fade transition.
  ///
  /// **Parameters:**
  /// - [builder]: Function returning the custom widget to display.
  /// - [bottom]: Distance from the screen bottom (default: [SBBSpacing.xLarge]).
  /// - [duration]: How long the toast remains visible (default: [durationShort]).
  ///
  /// **Example:**
  /// ```dart
  /// SBBToast.of(context).builder(
  ///   duration: SBBToast.durationLong,
  ///   builder: (context, visibilityStream) => StreamBuilder<bool>(
  ///     stream: visibilityStream,
  ///     builder: (context, snapshot) {
  ///       final isVisible = snapshot.data ?? false;
  ///       return AnimatedOpacity(
  ///         opacity: isVisible ? 1.0 : 0.0,
  ///         duration: kThemeAnimationDuration,
  ///         child: MyCustomToastContent(),
  ///       );
  ///     },
  ///   ),
  /// );
  /// ```
  void builder({
    required Widget Function(BuildContext context, Stream<bool> stream) builder,
    double bottom = SBBSpacing.xLarge,
    Duration duration = durationShort,
  }) => _builder(builder: builder, bottom: bottom, duration: duration);

  void _builder({
    required Widget Function(BuildContext context, Stream<bool> stream) builder,
    double bottom = SBBSpacing.xLarge,
    SBBToastStyle? style,
    Duration duration = durationShort,
  }) {
    showToastMessage() {
      remove();
      _streamController = StreamController<bool>();
      _streamController!.add(true);
      _overlayEntry = _buildToastOverlayEntry(bottom, builder, _streamController!.stream, style);
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

  /// Fades out this toast gracefully.
  ///
  /// The toast will animate to transparent over [kThemeAnimationDuration] before being removed.
  ///
  /// See [remove] for immediate dismissal.
  void hide() {
    _streamController?.add(false);
    _removeTimer = Timer(kThemeAnimationDuration, () => remove());
  }

  /// Immediately removes this toast from the screen.
  ///
  /// See [hide] for graceful fade-out.
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
    double bottom,
    Widget Function(BuildContext context, Stream<bool> stream) builder,
    Stream<bool> stream,
    SBBToastStyle? style,
  ) => OverlayEntry(
    builder: (context) {
      final resolvedStyle = (Theme.of(context).sbbToastTheme?.style ?? SBBToastStyle()).merge(style);
      return ToastScope(
        stream: stream,
        style: resolvedStyle,
        toast: this,
        child: Positioned(
          left: 0.0,
          right: 0.0,
          bottom: bottom,
          child: Align(
            alignment: .center,
            child: Semantics(container: true, liveRegion: true, child: builder(context, stream)),
          ),
        ),
      );
    },
  );
}
