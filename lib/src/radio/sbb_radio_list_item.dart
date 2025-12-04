import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../shared/bottom_loading_indicator.dart';

const double _iconTopPadding = 10.0;
const double _minListTileHeight = 44.0;

/// SBB Radio Button List Item. Use according to documentation.
///
/// Use [SBBControlStyle].listItem to manipulate the style of this Widget.
///
/// This widget must be used within a [SBBRadioGroup] that manages the selection
/// state for the group. The list item will automatically participate in the group's
/// selection logic.
///
/// ## Example
///
/// ```dart
/// SBBRadioGroup<SingingCharacter>(
///   groupValue: _character,
///   onChanged: (SingingCharacter? newValue) {
///     setState(() {
///       _character = newValue;
///     });
///   },
///   child: Column(
///     children: [
///       SBBRadioListItem(
///         value: SingingCharacter.lafayette,
///         label: 'Lafayette',
///       ),
///       SBBRadioListItem(
///         value: SingingCharacter.jefferson,
///         label: 'Jefferson',
///       ),
///       SBBRadioListItem(
///         value: SingingCharacter.washington,
///         label: 'Washington',
///       ),
///     ],
///   ),
/// )
/// ```
///
/// See also:
///
/// * [SBBRadio], which is a part of this widget.
/// * [SBBRadioGroup], which manages the selection state for a group of radio items.
/// * [SBBSegmentedButton], a widget with semantics similar to [SBBRadio].
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckboxListItem], [SBBCheckbox] and [SBBSwitch], for toggling a
/// particular value on or off.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/radiobutton>
class SBBRadioListItem<T> extends StatelessWidget {
  /// Creates a combination of a tile and a [SBBRadio].
  ///
  /// The [SBBRadioListItem] itself does not maintain any state. Instead, when the
  /// state of the checkbox changes, the widget calls the [onChanged] callback.
  /// Most widgets that use a checkbox will listen for the [onChanged] callback
  /// and rebuild the checkbox tile with a new [value] to update the visual
  /// appearance of the checkbox.
  ///
  /// The following arguments are required:
  ///
  /// * [value], the value represented by the radio of this list item
  /// * [label], the primary text written on [SBBRadioListItem].
  ///
  /// Set the [isLastElement] true for the last item in a list to not show any Divider.
  ///
  /// The trailing widget of this widget is determined in the following way:
  ///
  /// * if no [trailingIcon] is given, no trailing Widget will be shown.
  /// * if [onCallToAction] is not given, the trailingIcon will be shown as 24px sized [Icon].
  /// * if [onCallToAction] is given, the trailingIcon will be wrapped in a [SBBIconButtonSmall].
  ///
  /// If [isLoading] is true, a bottom loading indicator will be displayed.
  ///
  /// Check the [SBBRadioListItem.custom] constructor for a complete customization.
  SBBRadioListItem({
    Key? key,
    required T value,
    required String label,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    bool isLastElement = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
    bool isLoading = false,
    String? radioSemanticLabel,
  }) : this.custom(
         key: key,
         value: value,
         label: label,
         allowMultilineLabel: allowMultilineLabel,
         secondaryLabel: secondaryLabel,
         isLastElement: isLastElement,
         leadingIcon: leadingIcon,
         trailingWidget: _optionallyButtonedTrailingIcon(trailingIcon, onCallToAction),
         isLoading: isLoading,
         radioSemanticLabel: radioSemanticLabel,
       );

  /// Use this in combination with a [SBBGroup] to create a boxed variant of the [SBBRadioListItem].
  ///
  /// ```dart
  /// SBBGroup(
  ///   child: SBBRadioGroup<SingingCharacter>(
  ///     groupValue: _character,
  ///     onChanged: (SingingCharacter? newValue) {
  ///       setState(() {
  ///         _character = newValue;
  ///       });
  ///     },
  ///     child: Column(
  ///       children: [
  ///         SBBRadioListItem.boxed(
  ///           value: SingingCharacter.lafayette,
  ///           label: 'Lafayette',
  ///         ),
  ///         SBBRadioListItem.boxed(
  ///           value: SingingCharacter.jefferson,
  ///           label: 'Jefferson',
  ///         ),
  ///       ],
  ///     ),
  ///   ),
  /// )
  /// ```
  SBBRadioListItem.boxed({
    Key? key,
    required T value,
    required String label,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
    bool isLoading = false,
    String? radioSemanticLabel,
  }) : this.custom(
         key: key,
         value: value,
         label: label,
         allowMultilineLabel: allowMultilineLabel,
         secondaryLabel: secondaryLabel,
         isLastElement: true,
         leadingIcon: leadingIcon,
         trailingWidget: _optionallyButtonedTrailingIcon(trailingIcon, onCallToAction),
         isLoading: isLoading,
         radioSemanticLabel: radioSemanticLabel,
       );

  const SBBRadioListItem.custom({
    super.key,
    required this.value,
    required this.label,
    this.allowMultilineLabel = false,
    this.secondaryLabel,
    this.isLastElement = false,
    this.leadingIcon,
    this.trailingWidget,
    this.isLoading = false,
    this.radioSemanticLabel,
  });

  /// The value represented by this radio button.
  final T value;

  /// The primary label on the tile.
  final String label;

  /// Whether the [label] can wrap to a second line.
  final bool allowMultilineLabel;

  /// The subtext displayed below the [label] over multiple lines.
  final String? secondaryLabel;

  /// Whether to draw a [Divider] below the [SBBRadioListItem].
  final bool isLastElement;

  /// The icon displayed in between the [SBBRadio] and the [label].
  final IconData? leadingIcon;

  /// The widget displayed at the end of the tile.
  final Widget? trailingWidget;

  /// Whether to display a BottomLoadingIndicator on the [SBBRadioListItem].
  final bool isLoading;

  /// The semantic label for the RadioButton that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  final String? radioSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).radioButton;
    final radioGroup = RadioGroup.maybeOf<T>(context);
    final isInteractive = radioGroup != null;

    return MergeSemantics(
      child: Material(
        color: _resolveBackgroundColor(style, isInteractive),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _minListTileHeight),
              child: InkWell(
                onTap: isInteractive ? () => radioGroup.onChanged(value) : null,
                splashColor: style?.listItem?.backgroundColorHighlighted,
                focusColor: style?.listItem?.backgroundColorHighlighted,
                highlightColor: SBBColors.transparent,
                hoverColor: SBBColors.transparent,
                child: Semantics(enabled: isInteractive, child: _radioTileBody(style, isInteractive)),
              ),
            ),
            if (!isLastElement) const Divider(),
            if (isLoading) BottomLoadingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _radioTileBody(SBBControlStyle? style, bool isInteractive) {
    final Color? resolvedIconColor = _resolveIconColor(style, isInteractive);

    return IconTheme.merge(
      data: IconThemeData(color: resolvedIconColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: sbbDefaultSpacing),
          _NonHittableRadio<T>(
            value: value,
            isInteractive: isInteractive,
            radioSemanticLabel: radioSemanticLabel,
          ),
          const SizedBox(width: sbbDefaultSpacing * 0.5),
          if (leadingIcon != null) _LeadingIcon(leadingIcon: leadingIcon),
          Expanded(
            child: _TextBody(
              label: label,
              isInteractive: isInteractive,
              style: style,
              allowMultilineLabel: allowMultilineLabel,
              secondaryLabel: secondaryLabel,
            ),
          ),
          if (trailingWidget != null) trailingWidget!,
        ],
      ),
    );
  }

  Color? _resolveBackgroundColor(SBBControlStyle? style, bool isInteractive) {
    return isInteractive ? style?.listItem?.backgroundColor : style?.listItem?.backgroundColorDisabled;
  }

  Color? _resolveIconColor(SBBControlStyle? style, bool isInteractive) {
    return isInteractive ? style?.listItem?.iconColor : style?.listItem?.iconColorDisabled;
  }

  static Widget? _optionallyButtonedTrailingIcon(
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
  ) {
    if (trailingIcon == null) return null;

    if (onCallToAction == null) {
      return Padding(
        padding: const EdgeInsets.only(top: _iconTopPadding, right: sbbDefaultSpacing),
        child: Icon(trailingIcon, size: 24.0),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: sbbDefaultSpacing * .5),
        child: SBBTertiaryButtonSmall(iconData: trailingIcon, onPressed: onCallToAction),
      );
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
              padding: const EdgeInsetsDirectional.only(top: sbbDefaultSpacing * 0.25),
              child: Text(
                secondaryLabel!,
                style: _isInteractive
                    ? style?.listItem?.secondaryTextStyle
                    : style?.listItem?.secondaryTextStyleDisabled,
              ),
            ),
        ],
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.leadingIcon});

  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: _iconTopPadding, end: sbbDefaultSpacing * .5),
      child: Icon(leadingIcon),
    );
  }
}

class _NonHittableRadio<T> extends StatelessWidget {
  const _NonHittableRadio({
    required this.value,
    required this.isInteractive,
    this.radioSemanticLabel,
  });

  final T value;
  final bool isInteractive;
  final String? radioSemanticLabel;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeFocus(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: sbbDefaultSpacing * 0.75),
          child: SBBRadio(
            value: value,
            style: SBBRadioStyle(padding: EdgeInsets.zero),
            enabled: isInteractive,
            semanticLabel: radioSemanticLabel,
          ),
        ),
      ),
    );
  }
}
