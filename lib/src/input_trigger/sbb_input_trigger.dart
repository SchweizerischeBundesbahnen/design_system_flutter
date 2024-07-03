import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// Widget that mimics the visuals of an [SBBTextField] but has an [onPressed]
/// callback instead of the text field functionality.
///
/// Used by [SBBDateTimeInput], [SBBDateInput], [SBBTimeInput].
///
/// See also:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/text-input/>
class SBBInputTrigger extends StatelessWidget {
  /// Constructs an [SBBInputTrigger].
  ///
  /// [onPressed] is the callback called when the input trigger is pressed.
  ///
  /// [prefixIcon] is the icon to be displayed as the prefix widget.
  ///
  /// [suffixIcon] is the icon to be displayed as the suffix widget.
  ///
  /// [onSuffixPressed] is the callback called when [suffixIcon] is pressed.
  ///
  /// See also:
  ///
  /// * [SBBInputTrigger.custom], constructor for SBB Input Trigger with custom
  ///   prefix and suffix widgets.
  SBBInputTrigger({
    Key? key,
    String? value,
    String? labelText,
    String? hintText,
    String? errorText,
    VoidCallback? onPressed,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixPressed,
    int? maxLines,
    bool enabled = true,
    bool isLastElement = false,
  }) : this.custom(
          key: key,
          value: value,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          onPressed: onPressed,
          prefixWidget: SBBInputTriggerIconWidget(
            icon: prefixIcon,
            enabled: enabled,
            error: errorText?.isNotEmpty ?? false,
          ),
          suffixWidget: SBBInputTriggerIconWidget(
            icon: suffixIcon,
            enabled: enabled,
            onPressed: onSuffixPressed,
          ),
          maxLines: maxLines,
          enabled: enabled,
          isLastElement: isLastElement,
        );

  /// Constructs an [SBBInputTrigger] with custom prefix and suffix widgets.
  ///
  /// See also:
  ///
  /// * [SBBPicker.new], default constructor for SBB Input Trigger with optional
  /// icons as prefix and suffix widgets.
  const SBBInputTrigger.custom({
    super.key,
    this.value,
    this.labelText,
    this.hintText,
    this.errorText,
    this.onPressed,
    this.prefixWidget = const SBBInputTriggerIconWidget(),
    this.suffixWidget = const SBBInputTriggerIconWidget(),
    this.maxLines,
    this.enabled = true,
    this.isLastElement = true,
  });

  final String? value;
  final String? labelText;
  final String? hintText;
  final String? errorText;

  final VoidCallback? onPressed;

  final Widget prefixWidget;
  final Widget suffixWidget;

  final int? maxLines;

  final bool enabled;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).textField!;
    final dividerColor =
        _hasError ? style.dividerColorError : style.dividerColor;
    final valueTextStyle = !enabled
        ? style.textStyleDisabled!
        : (!_hasValue
            ? style.placeholderTextStyle
            : (_hasError ? style.textStyleError : style.textStyle));
    return InkWell(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixWidget,
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: _verticalPadding),
                          if (_hasLabel)
                            Text(_labelText, style: style.labelTextStyle!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              _valueText,
                              style: valueTextStyle,
                              maxLines: maxLines,
                              overflow: maxLines != null
                                  ? TextOverflow.ellipsis
                                  : null,
                            ),
                          ),
                          if (_hasError)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                _errorText,
                                style: style.errorTextStyle,
                              ),
                            )
                          else
                            SizedBox(height: _verticalPadding),
                        ],
                      ),
                    ),
                    suffixWidget,
                  ],
                ),
                if (!isLastElement)
                  Divider(
                    color: dividerColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool get _hasValue => value?.isNotEmpty ?? false;

  bool get _hasLabel => labelText?.isNotEmpty ?? false;

  bool get _hasError => enabled && (errorText?.isNotEmpty ?? false);

  String get _valueText => _hasValue ? (value ?? _hintText) : _hintText;

  String get _labelText => labelText ?? '';

  String get _hintText => hintText ?? '';

  String get _errorText => errorText ?? '';

  double get _verticalPadding => _hasLabel ? 6.0 : 12.0;
}

/// Icon widget used by [SBBInputTrigger].
class SBBInputTriggerIconWidget extends StatelessWidget {
  const SBBInputTriggerIconWidget({
    this.icon,
    this.enabled = true,
    this.error = false,
    this.onPressed,
  });

  final IconData? icon;
  final bool enabled;
  final bool error;
  final VoidCallback? onPressed;

  static const verticalPadding = sbbDefaultSpacing * 0.75;
  static const leftPadding = sbbDefaultSpacing;
  static const rightPadding = sbbDefaultSpacing * 0.5;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return const SizedBox(
        width: sbbDefaultSpacing,
      );
    }

    final style = SBBControlStyles.of(context).textField!;
    final iconColor = enabled
        ? (error ? style.prefixIconColorError : style.iconColor)
        : style.iconColorDisabled;

    if (onPressed == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          leftPadding,
          verticalPadding,
          leftPadding - rightPadding,
          verticalPadding,
        ),
        child: Icon(icon, color: iconColor),
      );
    }

    // also use left padding on right sight and then transform to the right for
    // symmetric splash effect
    return Container(
      transform: Transform.translate(
        offset: Offset(rightPadding, 0.0),
      ).transform,
      child: InkResponse(
        // splashRadius: 28.0,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: leftPadding,
          ),
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
