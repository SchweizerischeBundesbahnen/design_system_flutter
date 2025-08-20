
import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class DefaultHeaderBoxContent extends StatelessWidget {
  const DefaultHeaderBoxContent({
    required this.title,
    this.leadingIcon,
    this.secondaryLabel,
    this.trailingWidget,
  });

  final String title;
  final IconData? leadingIcon;
  final String? secondaryLabel;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final style = SBBHeaderBoxStyle.of(context);
    final secondaryTextStyle = SBBTextStyles.smallLight.copyWith(color: style.secondaryLabelColor);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (leadingIcon != null) ...[
                    Icon(leadingIcon, size: sbbIconSizeSmall),
                    SizedBox(width: sbbDefaultSpacing * .5)
                  ],
                  Expanded(child: Text(title, style: style.titleTextStyle)),
                ],
              ),
              if (secondaryLabel != null) Text(secondaryLabel!, style: secondaryTextStyle)
            ],
          ),
        ),
        SizedBox(width: sbbDefaultSpacing * .5),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }
}

class LargeHeaderBoxContent extends StatelessWidget {
  const LargeHeaderBoxContent({
    required this.title,
    this.leadingIcon,
    this.secondaryLabel,
    this.trailingWidget,
  });

  final String title;
  final IconData? leadingIcon;
  final String? secondaryLabel;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final style = SBBHeaderBoxStyle.of(context);
    final secondaryTextStyle = SBBTextStyles.mediumLight.copyWith(color: style.largeSecondaryLabelColor);

    return Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: sbbIconSizeMedium),
          SizedBox(width: sbbDefaultSpacing * .5)
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: style.titleTextStyle),
              SizedBox(height: sbbDefaultSpacing * .25),
              if (secondaryLabel != null) Text(secondaryLabel!, style: secondaryTextStyle)
            ],
          ),
        ),
        SizedBox(width: sbbDefaultSpacing * .5),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }
}
