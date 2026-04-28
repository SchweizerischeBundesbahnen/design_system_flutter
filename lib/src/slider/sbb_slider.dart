import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/slider/sbb_slider_thumb_shape.dart';
import 'package:sbb_design_system_mobile/src/slider/sbb_slider_track_shape.dart';

/// A slider component following the SBB design system.
///
/// This widget is a wrapper around the Material [Slider] widget with custom
/// SBB-specific styling applied through [SBBSliderStyle] and [SBBSliderThemeData].
/// It does not add new functionality to the underlying [Slider] but rather
/// provides a consistent visual appearance aligned with the SBB design guidelines.
///
/// The slider allows users to select a single value from a continuous or discrete
/// range. The value is represented by the position of the thumb on the track.
///
/// ## Basic usage
///
/// ```dart
/// SBBSlider(
///   value: _currentValue,
///   min: 0.0,
///   max: 100.0,
///   onChanged: (double newValue) {
///     setState(() {
///       _currentValue = newValue;
///     });
///   },
/// )
/// ```
///
/// ## With leading and trailing icons
///
/// ```dart
/// SBBSlider(
///   value: _currentValue,
///   leadingIconData: Icons.remove,
///   trailingIconData: Icons.add,
///   onChanged: (double newValue) {
///     setState(() {
///       _currentValue = newValue;
///     });
///   },
/// )
/// ```
///
/// If [onChanged] is null, the slider will be displayed as disabled and cannot
/// be interacted with.
///
/// See also:
///
/// * [SBBSliderStyle], for customizing the slider appearance.
/// * [SBBSliderThemeData], for setting slider theme properties across your app.
/// * [Slider], the underlying Material Design slider widget.
/// * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/slider)
class SBBSlider extends StatefulWidget {
  const SBBSlider({
    super.key,
    required this.onChanged,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.onChangeStart,
    this.onChangeEnd,
    this.divisions,
    this.allowedInteraction,
    this.style,
  }) : assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set'),
       assert(trailing == null || trailingIconData == null, 'Only one of trailing or trailingIconData can be set'),
       assert(min <= max, 'Min must be smaller or equal to max!');

  /// Called when the user is selecting a new value for the slider by dragging or tapping.
  ///
  /// The slider passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the slider with the new value.
  ///
  /// If null, the slider will be displayed as disabled and cannot be interacted with.
  final ValueChanged<double>? onChanged;

  /// Called when the user starts to select a new value for the slider.
  ///
  /// This callback is invoked when the user begins a drag or tap interaction.
  /// It receives the current value before any changes are made.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value for the slider.
  ///
  /// This callback is invoked when the user completes a drag or tap interaction.
  /// It receives the final selected value.
  final ValueChanged<double>? onChangeEnd;

  /// The currently selected value for this slider.
  ///
  /// The slider's thumb is drawn at a position that corresponds to this value.
  /// Must be between [min] and [max].
  final double value;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0. Must be less than or equal to [max].
  ///
  /// If [max] equals [min], the slider is disabled.
  final double min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0. Must be greater than or equal to [min].
  ///
  /// If [max] equals [min], the slider is disabled.
  final double max;

  /// A custom widget displayed as the slider's leading content.
  ///
  /// For simple icons, use [leadingIconData] instead.
  ///
  /// The widget is positioned to the left of the slider track and is
  /// themed using the [SBBSliderStyle.leadingForegroundColor].
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon data for the leading icon.
  ///
  /// The icon is positioned to the left of the slider track and is
  /// themed using the [SBBSliderStyle.leadingForegroundColor].
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// A custom widget displayed as the slider's trailing content.
  ///
  /// For simple icons, use [trailingIconData] instead.
  ///
  /// The widget is positioned to the right of the slider track and is
  /// themed using the [SBBSliderStyle.trailingForegroundColor].
  ///
  /// Cannot be used together with [trailingIconData].
  final Widget? trailing;

  /// Icon data for the trailing icon.
  ///
  /// The icon is positioned to the right of the slider track and is
  /// themed using the [SBBSliderStyle.trailingForegroundColor].
  ///
  /// Cannot be used together with [trailing].
  final IconData? trailingIconData;

  /// The number of discrete divisions.
  ///
  /// If null, the slider will be continuous and allow any value between [min] and [max].
  ///
  /// If set to a positive integer, the slider will snap to discrete values.
  final int? divisions;

  /// Which gestures should be recognized on the slider.
  ///
  /// Defaults to [SliderInteraction.tapAndSlide], allowing the user to tap anywhere
  /// on the track or drag the thumb.
  final SliderInteraction? allowedInteraction;

  /// Customizes this slider appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSliderThemeData.style] of the theme found in [context].
  ///
  /// If both [style] and the theme style are null, default SBB styling is applied.
  final SBBSliderStyle? style;

  @override
  State<SBBSlider> createState() => _SBBSliderState();
}

class _SBBSliderState extends State<SBBSlider> {
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();
  }

  @override
  void didUpdateWidget(SBBSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onChanged != oldWidget.onChanged) {
      _updateStatesController();
    }
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, widget.onChanged == null || widget.min == widget.max);
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  void _handleChangeStart(double value) {
    _statesController.update(WidgetState.pressed, true);
    widget.onChangeStart?.call(value);
    setState(() {
      // reevaluate colors
    });
  }

  void _handleChangeEnd(double value) {
    _statesController.update(WidgetState.pressed, false);
    widget.onChangeEnd?.call(value);
    setState(() {
      // reevaluate colors
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbSliderTheme?.style;
    final effectiveStyle = themeStyle?.merge(widget.style) ?? widget.style ?? const SBBSliderStyle();

    final slider = _slider(effectiveStyle);

    if (widget.leading == null &&
        widget.leadingIconData == null &&
        widget.trailing == null &&
        widget.trailingIconData == null) {
      return slider;
    } else {
      final leadingForegroundColor = effectiveStyle.leadingForegroundColor?.resolve(_statesController.value);
      final trailingForegroundColor = effectiveStyle.trailingForegroundColor?.resolve(_statesController.value);

      // Build actual widgets from convenience parameters
      Widget? leadingWidget = widget.leading;
      if (leadingWidget == null && widget.leadingIconData != null) {
        leadingWidget = Icon(widget.leadingIconData);
      }

      Widget? trailingWidget = widget.trailing;
      if (trailingWidget == null && widget.trailingIconData != null) {
        trailingWidget = Icon(widget.trailingIconData);
      }

      // Apply theming
      if (leadingWidget != null) {
        leadingWidget = _applyForegroundColor(
          child: leadingWidget,
          foregroundColor: leadingForegroundColor,
        );
      }

      if (trailingWidget != null) {
        trailingWidget = _applyForegroundColor(
          child: trailingWidget,
          foregroundColor: trailingForegroundColor,
        );
      }

      return Row(
        children: [
          if (leadingWidget != null) leadingWidget,
          Expanded(child: slider),
          if (trailingWidget != null) trailingWidget,
        ],
      );
    }
  }

  Widget _applyForegroundColor({
    required Widget child,
    required Color? foregroundColor,
  }) {
    return DefaultTextStyle.merge(
      style: TextStyle(color: foregroundColor),
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
  }

  Widget _slider(SBBSliderStyle effectiveStyle) {
    final Set<WidgetState> enabledStates = {..._statesController.value}..remove(WidgetState.disabled);
    final Set<WidgetState> disabledStates = {..._statesController.value, WidgetState.disabled};

    final sbbColorScheme = Theme.of(context).sbbBaseStyle.colorScheme;
    final inactiveTrackColor = effectiveStyle.trackColor?.resolve(enabledStates) ?? SBBColors.smoke;
    final disabledInactiveTrackColor = effectiveStyle.trackColor?.resolve(disabledStates) ?? SBBColors.smoke;
    final activeTrackColor = effectiveStyle.activeTrackColor?.resolve(enabledStates) ?? sbbColorScheme.primaryColor;
    final disabledActiveTrackColor =
        effectiveStyle.activeTrackColor?.resolve(disabledStates) ?? sbbColorScheme.primaryColor;
    final thumbBackgroundColor =
        effectiveStyle.thumbBackgroundColor?.resolve(enabledStates) ?? sbbColorScheme.backgroundColor;
    final disabledThumbBackgroundColor =
        effectiveStyle.thumbBackgroundColor?.resolve(disabledStates) ?? sbbColorScheme.backgroundColor;
    final thumbBorderColor = effectiveStyle.thumbBorderColor?.resolve(enabledStates) ?? sbbColorScheme.primaryColor;
    final disabledThumbBorderColor =
        effectiveStyle.thumbBorderColor?.resolve(disabledStates) ?? sbbColorScheme.primaryColor;
    final padding = effectiveStyle.padding ?? .symmetric(horizontal: SBBSpacing.small);

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: SBBSliderStyle.trackHeight,
        inactiveTrackColor: inactiveTrackColor,
        disabledInactiveTrackColor: disabledInactiveTrackColor,
        activeTrackColor: activeTrackColor,
        disabledActiveTrackColor: disabledActiveTrackColor,
        thumbColor: thumbBackgroundColor,
        disabledThumbColor: disabledThumbBackgroundColor,
        trackShape: EvenRoundedRectSliderTrackShape(thumbRadius: SBBSliderStyle.thumbRadius),
        thumbShape: CircleBorderThumbShape(
          radius: SBBSliderStyle.thumbRadius,
          borderWidth: SBBSliderStyle.thumbBorderWidth,
          enabledBorderColor: thumbBorderColor,
          disabledBorderColor: disabledThumbBorderColor,
        ),
        overlayShape: SliderComponentShape.noOverlay,
        padding: padding,
      ),
      child: Slider(
        value: widget.value,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        allowedInteraction: widget.allowedInteraction,
        onChanged: widget.onChanged,
        onChangeStart: _handleChangeStart,
        onChangeEnd: _handleChangeEnd,
      ),
    );
  }
}
