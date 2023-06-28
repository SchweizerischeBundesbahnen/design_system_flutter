import 'package:flutter/material.dart';

import '../theme/sbb_icons.dart';
import '../theme/styles/sbb_styles.dart';

/// The SBB Chip. Use according to documentation.
///
/// Use [SBBChipStyle] to customize the chip theme.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system/mobile/components/slider>
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: _disabled ? style.disabledBorderColor! : style.borderColor!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: _label(),
            ),
            if (selected) _unselectButton(style),
            if (badgeLabel != null && !selected) _badge(style),
          ],
        ),
      ),
    );
  }

  Padding _label() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _badge(SBBChipStyle style) {
    return _roundedContainer(
      child: Text(
        badgeLabel ?? '',
        style: SBBTextStyles.smallBold.copyWith(color: style.badgeTextColor),
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
        child: Icon(SBBIcons.cross_small),
        color: style.unselectButtonColor!,
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
      margin: EdgeInsets.all(4.0).copyWith(left: 0),
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

  _changeSelection(bool selected) {
    if (onSelection != null) {
      onSelection!(selected);
    }
  }
}
