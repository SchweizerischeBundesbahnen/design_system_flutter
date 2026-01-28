import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
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
    this.startIcon = SBBIcons.walk_slow_small,
    this.endIcon = SBBIcons.walk_fast_small,
    this.onChangeStart,
    this.onChangeEnd,
    this.style,
    this.focusNode,
  });

  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double value;
  final double min;
  final double max;
  final IconData? startIcon;
  final IconData? endIcon;

  /// Customizes this slider appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSliderThemeData.style] of the theme found in [context].
  final SBBSliderStyle? style;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  @override
  State<SBBSlider> createState() => _SBBSliderState();
}

class _SBBSliderState extends State<SBBSlider> {
  late WidgetStatesController _statesController;
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _effectiveFocusNode.addListener(_handleFocusChanged);
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
    _statesController.update(WidgetState.focused, _effectiveFocusNode.hasFocus);
  }

  @override
  void dispose() {
    _statesController.dispose();
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbSliderTheme?.style;
    final effectiveStyle = themeStyle?.merge(widget.style) ?? widget.style ?? const SBBSliderStyle();
    final states = _statesController.value;

    final trackColor = effectiveStyle.trackColor?.resolve(states) ?? SBBColors.smoke;
    final activeTrackColor = effectiveStyle.activeTrackColor?.resolve(states) ?? SBBColors.red;
    final thumbBackgroundColor = effectiveStyle.thumbBackgroundColor?.resolve(states) ?? SBBColors.green;
    final thumbBorderColor = effectiveStyle.thumbBorderColor?.resolve(states) ?? SBBColors.red;
    final leadingForegroundColor = effectiveStyle.leadingForegroundColor?.resolve(states) ?? SBBColors.black;
    final trailingForegroundColor = effectiveStyle.trailingForegroundColor?.resolve(states) ?? SBBColors.black;

    print(thumbBackgroundColor);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (widget.startIcon != null) _startIcon(leadingForegroundColor),
        Expanded(child: _slider(trackColor, activeTrackColor, thumbBackgroundColor, thumbBorderColor)),
        if (widget.endIcon != null) _endIcon(trailingForegroundColor),
      ],
    );
  }

  Widget _endIcon(Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: _iconPadding),
      child: Icon(widget.endIcon, color: color),
    );
  }

  Widget _startIcon(Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: _iconPadding),
      child: Icon(widget.startIcon, color: color),
    );
  }

  Widget _slider(Color trackColor, Color activeTrackColor, Color thumbBackgroundColor, Color thumbBorderColor) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: _trackHeight,
        thumbColor: thumbBackgroundColor,
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: trackColor,
        trackShape: EvenRoundedRectSliderTrackShape(),
        thumbShape: CircleBorderThumbShape(
          radius: _thumbRadius,
          borderWidth: _thumbBorderWidth,
          color: thumbBackgroundColor,
          borderColor: thumbBorderColor,
        ),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        value: widget.value,
        min: widget.min,
        max: widget.max,
        onChanged: widget.onChanged,
        onChangeStart: widget.onChangeStart,
        onChangeEnd: widget.onChangeEnd,
        focusNode: _effectiveFocusNode,
      ),
    );
  }

  void _handleFocusChanged() {
    _updateStatesController();
    setState(() {
      // resolve colors
    });
  }
}
