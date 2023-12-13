import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import 'tapable_element.dart';

class SBBCloseButton extends StatelessWidget {
  const SBBCloseButton({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final crossColor = SBBBaseStyle.of(context).iconColor;
    return Semantics(
      label: MaterialLocalizations.of(context).closeButtonTooltip,
      button: true,
      child: TapableElement.circle(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            SBBIcons.cross_small,
            color: crossColor,
            size: sbbIconSizeSmall,
          ),
        ),
      ),
    );
  }
}
