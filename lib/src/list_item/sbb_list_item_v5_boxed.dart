import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class SBBListItemV5Boxed extends SBBListItemV5 {
  const SBBListItemV5Boxed({
    super.key,
    super.leading,
    super.title,
    super.subtitle,
    super.trailing,
    super.leadingIconData,
    super.titleText,
    super.subtitleText,
    super.trailingIconData,
    super.onTap,
    super.onLongPress,
    super.enabled,
    super.isLoading,
    super.links,
    super.padding,
    super.statesController,
    super.trailingHorizontalGapWidth,
    super.leadingHorizontalGapWidth,
    super.subtitleVerticalGapHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
  }
}
