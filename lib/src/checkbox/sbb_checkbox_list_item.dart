import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// SBB Checkbox Item. Use according to documentation.
///
/// See also:
///
/// * [SBBCheckbox], which is a part of this widget.
/// * [SBBSwitch], a widget with semantics similar to [SBBCheckbox].
/// * [SBBRadioButtonListItem] and [SBBRadioButton], for selecting among a set
/// of explicit values.
/// * [SBBSlider], for selecting a value in a range.
/// * <https://digital.sbb.ch/de/design-system/mobile/components/checkbox/>
class SBBCheckboxListItem extends StatelessWidget {
  SBBCheckboxListItem({
    Key? key,
    required bool? value,
    required String label,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    bool tristate = false,
    required ValueChanged<bool?>? onChanged,
    bool isLastElement = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
  }) : this.custom(
          key: key,
          value: value,
          label: label,
          allowMultilineLabel: allowMultilineLabel,
          secondaryLabel: secondaryLabel,
          tristate: tristate,
          onChanged: onChanged,
          isLastElement: isLastElement,
          leadingIcon: leadingIcon,
          trailingWidget: trailingIcon != null && onChanged != null
              ? SBBIconButtonSmall(
                  icon: trailingIcon,
                  onPressed: onCallToAction ?? () => onChanged(value),
                )
              : null,
        );

  SBBCheckboxListItem.boxed({
    Key? key,
    required bool? value,
    required String label,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    bool tristate = false,
    required ValueChanged<bool?>? onChanged,
    bool isLastElement = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
  }) : this.custom(
          key: key,
          value: value,
          label: label,
          allowMultilineLabel: allowMultilineLabel,
          secondaryLabel: secondaryLabel,
          tristate: tristate,
          onChanged: onChanged,
          isLastElement: isLastElement,
          leadingIcon: leadingIcon,
          trailingWidget: trailingIcon != null && onChanged != null
              ? SBBIconButtonSmall(
                  icon: trailingIcon,
                  onPressed: onCallToAction ?? () => onChanged(value),
                )
              : null,
          isBoxed: true,
        );

  const SBBCheckboxListItem.custom({
    super.key,
    required this.value,
    required this.label,
    this.allowMultilineLabel = false,
    this.secondaryLabel,
    this.tristate = false,
    required this.onChanged,
    this.isLastElement = false,
    this.leadingIcon,
    this.trailingWidget,
    this.isBoxed = false,
  }) : assert(tristate || value != null);

  /// Whether this checkbox is checked.
  ///
  /// If [tristate] is false (the default), [value] must not be null.
  /// If [tristate] is true, SBBCheckbox displays a dash when [value] is null.
  final bool? value;

  /// Called when the value of the checkbox should change.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox with the new
  /// value.
  ///
  /// If this callback is null, the checkbox will be displayed as disabled
  /// and will not respond to input gestures.
  ///
  /// When the checkbox is tapped, if [tristate] is false (the default) then
  /// the [onChanged] callback will be applied to `!value`. If [tristate] is
  /// true this callback cycle from false to true to null.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// SBBCheckboxListItem(
  ///   value: _throwShotAway,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _throwShotAway = newValue;
  ///     });
  ///   },
  ///   label: 'Example',
  /// )
  /// ```
  final ValueChanged<bool?>? onChanged;

  /// If true the checkbox's [value] can be true, false, or null.
  ///
  /// SBBCheckbox displays a dash when its value is null.
  ///
  /// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
  /// callback will be applied to true if the current value is false, to null if
  /// value is true, and to false if value is null (i.e. it cycles through false
  /// => true => null => false when tapped).
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

  final String label;
  final bool allowMultilineLabel;
  final String? secondaryLabel;
  final bool isLastElement;
  final IconData? leadingIcon;
  final Widget? trailingWidget;

  final bool isBoxed;

  /// Whether [value] of this control can be changed by user interaction.
  ///
  /// The control is considered interactive if the [onChanged] callback is
  /// non-null. If the callback is null, then the control is disabled, and
  /// non-interactive. A disabled checkbox, for example, is displayed using a
  /// grey color and its value cannot be changed.
  bool get _isInteractive => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).checkbox;
    final Color? resolvedBackgroundColor = _resolveBackgroundColor(style);
    return Material(
      color: resolvedBackgroundColor,
      shape: isBoxed ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)) : null,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44.0),
            child: InkWell(
              onTap: _isInteractive ? _handleTap : null,
              splashColor: style?.listItem?.backgroundColorHighlighted,
              focusColor: style?.listItem?.backgroundColorHighlighted,
              highlightColor: SBBColors.transparent,
              hoverColor: SBBColors.transparent,
              borderRadius: isBoxed ? BorderRadius.circular(16.0) : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: sbbDefaultSpacing),
                  _NonHittableCheckbox(value: value, tristate: tristate, onChanged: onChanged),
                  const SizedBox(width: sbbDefaultSpacing * 0.5),
                  if (leadingIcon != null)
                    _LeadingIcon(leadingIcon: leadingIcon, isInteractive: _isInteractive, style: style),
                  Expanded(
                    child: _TextBody(
                      label: label,
                      isInteractive: _isInteractive,
                      style: style,
                      allowMultilineLabel: allowMultilineLabel,
                      secondaryLabel: secondaryLabel,
                    ),
                  ),
                  if (trailingWidget != null) trailingWidget!,
                ],
              ),
            ),
          ),
          if (!isLastElement && !isBoxed) const Divider(),
        ],
      ),
    );
  }

  void _handleTap() {
    if (!_isInteractive) {
      return;
    }
    switch (value) {
      case false:
        onChanged!(true);
      case true:
        onChanged!(tristate ? null : false);
      case null:
        onChanged!(false);
    }
  }

  _resolveBackgroundColor(SBBControlStyle? style) {
    if (isBoxed) {
      return _isInteractive ? style?.listItem?.boxedBackgroundColor : style?.listItem?.boxedBackgroundColorDisabled;
    } else {
      return _isInteractive ? style?.listItem?.backgroundColor : style?.listItem?.backgroundColorDisabled;
    }
  }
}

class _TextBody extends StatelessWidget {
  const _TextBody({
    required this.label,
    required bool isInteractive,
    required this.style,
    required this.allowMultilineLabel,
    required this.secondaryLabel,
  }) : _isInteractive = isInteractive;

  final String label;
  final bool _isInteractive;
  final SBBControlStyle? style;
  final bool allowMultilineLabel;
  final String? secondaryLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: sbbDefaultSpacing * 0.75,
        bottom: sbbDefaultSpacing * 0.75,
        end: sbbDefaultSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: _isInteractive ? style?.listItem?.textStyle : style?.listItem?.textStyleDisabled,
            maxLines: allowMultilineLabel ? null : 1,
            overflow: allowMultilineLabel ? null : TextOverflow.ellipsis,
          ),
          if (secondaryLabel != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: sbbDefaultSpacing * 0.25,
              ),
              child: Text(
                secondaryLabel!,
                style:
                    _isInteractive ? style?.listItem?.secondaryTextStyle : style?.listItem?.secondaryTextStyleDisabled,
              ),
            ),
        ],
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({
    required this.leadingIcon,
    required bool isInteractive,
    required this.style,
  }) : _isInteractive = isInteractive;

  final IconData? leadingIcon;
  final bool _isInteractive;
  final SBBControlStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10.0,
        end: sbbDefaultSpacing * 0.5,
      ),
      child: Icon(
        leadingIcon,
        color: _isInteractive ? style?.listItem?.iconColor : style?.listItem?.iconColorDisabled,
      ),
    );
  }
}

class _NonHittableCheckbox extends StatelessWidget {
  const _NonHittableCheckbox({
    required this.value,
    required this.tristate,
    required this.onChanged,
  });

  final bool? value;
  final bool tristate;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FocusScope(
        canRequestFocus: false,
        skipTraversal: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: sbbDefaultSpacing * 0.75,
          ),
          child: SBBCheckbox(
            value: value,
            tristate: tristate,
            onChanged: onChanged,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
