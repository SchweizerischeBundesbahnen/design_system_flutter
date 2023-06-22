import '../../design_system_flutter.dart';
import 'package:flutter/material.dart';

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
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system/mobile/components/slider>
class SBBSlider extends StatelessWidget {
  const SBBSlider({
    super.key,
    required this.onChanged,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.startIcon = SBBIcons.walk_slow_small,
    this.endIcon = SBBIcons.walk_fast_small,
  });

  static const _trackHeight = 4.0;
  static const _thumbRadius = 14.0;
  static const _thumbBorderWidth = 2.0;

  final ValueChanged<double>? onChanged;
  final double value;
  final double min;
  final double max;
  final IconData? startIcon;
  final IconData? endIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (startIcon != null) Icon(startIcon),
        _slider(context),
        if (endIcon != null) Icon(endIcon),
      ],
    );
  }

  SliderTheme _slider(BuildContext context) {
    final style = SBBControlStyles.of(context).slider!;
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: _trackHeight,
        thumbColor: style.thumbColor,
        activeTrackColor: style.activeTrackColor,
        disabledActiveTrackColor: style.disabledActiveTrackColor,
        inactiveTrackColor: style.inactiveTrackColor,
        disabledInactiveTrackColor: style.disabledInactiveTrackColor,
        trackShape: EvenRoundedRectSliderTrackShape(),
        thumbShape: CircleBorderThumbShape(
          radius: _thumbRadius,
          borderWidth: _thumbBorderWidth,
          color: _isDisabled ? style.disabledThumbColor : style.thumbColor,
          borderColor: _isDisabled ? style.disabledThumbBorderColor : style.thumbBorderColor,
        ),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Expanded(
        child: Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ),
    );
  }

  get _isDisabled => onChanged == null;
}
