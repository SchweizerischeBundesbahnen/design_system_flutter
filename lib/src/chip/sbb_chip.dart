import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

const _kChipMargin = 4.0;

/// The SBB Chip. Use according to documentation.
///
/// Use [SBBChipStyle] to customize the chip theme.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system/mobile/components/chip>
class SBBChip extends StatelessWidget {
  const SBBChip({
    super.key,
    required this.label,
    required this.onSelection,
    this.badgeLabel,
    this.selected = false,
  });

  /// The label used for the chip
  final String label;

  /// The label which is displayed in the badge of the chip.
  final String? badgeLabel;

  /// Callback when the selection changes on the chip.
  /// if [onSelection] is set to null, the chip is disabled.
  final Function(bool selected)? onSelection;

  /// if [selected] is false, the badge is shown.
  /// if [selected] is true, the unselect button is shown.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).chip!;
    return GestureDetector(
      onTap: _disabled ? null : () => _changeSelection(true),
      child: Container(
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(
              color: _disabled ? style.disabledBorderColor! : style.borderColor!,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: _label(style),
            ),
            if (_showUnselectButton) _unselectButton(style),
            if (_showBadgeLabel) _badge(style),
          ],
        ),
      ),
    );
  }

  Padding _label(SBBChipStyle style) {
    final labelTextStyle = _disabled ? style.labelTextStyle!.textStyleDisabled : style.labelTextStyle!.textStyle;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12.0,
      ).subtract(
        EdgeInsets.only(right: _showBadgeLabel || _showUnselectButton ? _kChipMargin : 0),
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: labelTextStyle,
      ),
    );
  }

  Widget _badge(SBBChipStyle style) {
    final badgeTextStyle = _disabled ? style.badgeTextStyle!.textStyleDisabled : style.badgeTextStyle!.textStyle;
    return _roundedContainer(
      child: Text(
        badgeLabel ?? '',
        style: badgeTextStyle,
      ),
      color: _disabled ? style.disabledBadgeColor! : style.badgeColor!,
      padding: EdgeInsets.symmetric(horizontal: 4.0),
    );
  }

  Widget _unselectButton(SBBChipStyle style) {
    return InkWell(
      onTap: _disabled ? null : () => _changeSelection(false),
      customBorder: CircleBorder(),
      child: _roundedContainer(
        child: Icon(
          SBBIcons.cross_small,
          color: _disabled ? style.disabledUnselectButtonIconColor! : style.unselectButtonIconColor!,
        ),
        color: _disabled ? style.disabledUnselectButtonColor! : style.unselectButtonColor!,
        width: 24.0,
      ),
    );
  }

  Container _roundedContainer({
    required Widget child,
    required Color color,
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      margin: EdgeInsets.all(_kChipMargin),
      padding: padding,
      constraints: BoxConstraints(minWidth: 24.0),
      height: 24.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: color,
      ),
      child: Center(
        child: child,
      ),
    );
  }

  bool get _disabled => onSelection == null;

  bool get _showBadgeLabel => badgeLabel != null && !selected;

  bool get _showUnselectButton => selected;

  _changeSelection(bool selected) {
    if (onSelection != null) {
      onSelection!(selected);
    }
  }
}
