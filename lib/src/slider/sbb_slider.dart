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
    this.leadingIconData = SBBIcons.walk_slow_small,
    this.trailingIconData = SBBIcons.walk_fast_small,
    this.onChangeStart,
    this.onChangeEnd,
    this.style,
  });

  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double value;
  final double min;
  final double max;
  final IconData? leadingIconData;
  final IconData? trailingIconData;

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

    if (widget.leadingIconData == null && widget.trailingIconData == null) {
      return slider;
    } else {
      final leadingForegroundColor = effectiveStyle.leadingForegroundColor?.resolve(_statesController.value);
      final trailingForegroundColor = effectiveStyle.trailingForegroundColor?.resolve(_statesController.value);

      return Row(
        children: [
          if (widget.leadingIconData != null) _leadingIcon(leadingForegroundColor),
          Expanded(child: slider),
          if (widget.trailingIconData != null) _trailingIcon(trailingForegroundColor),
        ],
      );
    }
  }

  Widget _trailingIcon(Color? color) {
    return Icon(widget.trailingIconData, color: color);
  }

  Widget _leadingIcon(Color? color) {
    return Icon(widget.leadingIconData, color: color);
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
        padding: EdgeInsets.symmetric(horizontal: SBBSpacing.small),
      ),
      child: Slider(
        value: widget.value,
        min: widget.min,
        max: widget.max,
        onChanged: widget.onChanged,
        onChangeStart: _handleChangeStart,
        onChangeEnd: _handleChangeEnd,
      ),
    );
  }
}
