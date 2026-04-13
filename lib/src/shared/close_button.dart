import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'transparent_tapable_element.dart';

class SBBCloseButton extends StatelessWidget {
  const SBBCloseButton({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final crossColor = Theme.of(context).sbbBaseStyle.colorScheme.iconColor;
    return Semantics(
      label: MaterialLocalizations.of(context).closeButtonTooltip,
      button: true,
      child: TransparentTapableElement.circle(
        onTap: onTap,
        child: Padding(
          padding: const .all(12.0),
          child: Icon(SBBIcons.cross_small, color: crossColor, size: sbbIconSizeSmall),
        ),
      ),
    );
  }
}
