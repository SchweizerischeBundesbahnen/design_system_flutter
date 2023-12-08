import '../../design_system_flutter.dart';
import 'package:flutter/material.dart';

import 'sbb_slider_thumb_shape.dart';
import 'sbb_slider_track_shape.dart';

const _trackHeight = 4.0;
const _thumbRadius = 14.0;
const _thumbBorderWidth = 2.0;
const _iconPadding = 4.0;

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

  final ValueChanged<double>? onChanged;
  final double value;
  final double min;
  final double max;
  final IconData? startIcon;
  final IconData? endIcon;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).slider!;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (startIcon != null) _startIcon(style),
        Expanded(
          child: _slider(style),
        ),
        if (endIcon != null) _endIcon(style),
      ],
    );
  }

  Widget _endIcon(SBBSliderStyle style) {
    return Padding(
      padding: const EdgeInsets.only(left: _iconPadding),
      child: Icon(
        endIcon,
        color: _isDisabled ? style.disabledIconColor : style.iconColor,
      ),
    );
  }

  Widget _startIcon(SBBSliderStyle style) {
    return Padding(
      padding: const EdgeInsets.only(right: _iconPadding),
      child: Icon(
        startIcon,
        color: _isDisabled ? style.disabledIconColor : style.iconColor,
      ),
    );
  }

  Widget _slider(SBBSliderStyle style) {
    return Opacity(
      opacity: _isDisabled ? 0.5 : 1.0,
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: _trackHeight,
          thumbColor: style.thumbColor,
          activeTrackColor: style.activeTrackColor,
          inactiveTrackColor: style.inactiveTrackColor,
          trackShape: EvenRoundedRectSliderTrackShape(),
          thumbShape: CircleBorderThumbShape(
            radius: _thumbRadius,
            borderWidth: _thumbBorderWidth,
            color: style.thumbColor,
            borderColor: style.thumbBorderColor,
          ),
          overlayShape: SliderComponentShape.noOverlay,
        ),
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
