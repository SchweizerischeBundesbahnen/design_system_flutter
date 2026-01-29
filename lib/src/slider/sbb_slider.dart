import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'sbb_slider_thumb_shape.dart';
import 'sbb_slider_track_shape.dart';

/// The SBB Slider. Use according to documentation.
///
/// The [value] parameter must not be null.
///
/// If [onChanged] callback is null, then the slider will be disabled.
///
/// Use [SBBSliderStyle] to customize the slider theme.
///
/// [onChangeStart] is called when the user starts to select a new value for
/// the slider.
///
/// [onChangeEnd] is called when the user is done selecting a new value for
/// the slider.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system/mobile/components/slider>
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
       assert(trailing == null || trailingIconData == null, 'Only one of trailing or trailingIconData can be set');

  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double value;
  final double min;
  final double max;

  /// A custom widget displayed as the slider's leading content.
  ///
  /// For simple icons, use [leadingIconData] instead.
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon data for the leading icon.
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// A custom widget displayed as the slider's trailing content.
  ///
  /// For simple icons, use [trailingIconData] instead.
  ///
  /// Cannot be used together with [trailingIconData].
  final Widget? trailing;

  /// Icon data for the trailing icon.
  ///
  /// Cannot be used together with [trailing].
  final IconData? trailingIconData;

  /// The number of discrete divisions.
  ///
  /// If null, the slider will be continuous.
  final int? divisions;

  /// Which gestures should be recognized on the slider.
  final SliderInteraction? allowedInteraction;

  /// Customizes this slider appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSliderThemeData.style] of the theme found in [context].
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
    _statesController.update(WidgetState.disabled, widget.onChanged == null);
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

    final inactiveTrackColor = effectiveStyle.trackColor?.resolve(enabledStates) ?? SBBColors.smoke;
    final disabledInactiveTrackColor = effectiveStyle.trackColor?.resolve(disabledStates) ?? SBBColors.smoke;
    final activeTrackColor = effectiveStyle.activeTrackColor?.resolve(enabledStates) ?? SBBColors.red;
    final disabledActiveTrackColor = effectiveStyle.activeTrackColor?.resolve(disabledStates) ?? SBBColors.red;
    final thumbBackgroundColor = effectiveStyle.thumbBackgroundColor?.resolve(enabledStates) ?? SBBColors.green;
    final disabledThumbBackgroundColor =
        effectiveStyle.thumbBackgroundColor?.resolve(disabledStates) ?? SBBColors.green;
    final thumbBorderColor = effectiveStyle.thumbBorderColor?.resolve(enabledStates) ?? SBBColors.red;
    final disabledThumbBorderColor = effectiveStyle.thumbBorderColor?.resolve(disabledStates) ?? SBBColors.red;
    final padding = effectiveStyle.padding ?? EdgeInsets.symmetric(horizontal: SBBSpacing.small);

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
