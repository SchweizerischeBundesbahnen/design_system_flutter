import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultHeaderBoxContent extends StatelessWidget {
  const DefaultHeaderBoxContent({
    super.key,
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
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  if (leadingIcon != null) ...[
                    Icon(leadingIcon, size: sbbIconSizeSmall),
                    SizedBox(width: SBBSpacing.xSmall),
                  ],
                  Expanded(child: Text(title, style: style.titleTextStyle)),
                ],
              ),
              if (secondaryLabel != null) Text(secondaryLabel!, style: secondaryTextStyle),
            ],
          ),
        ),
        SizedBox(width: SBBSpacing.xSmall),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }
}

class LargeHeaderBoxContent extends StatelessWidget {
  const LargeHeaderBoxContent({
    super.key,
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
          SizedBox(width: SBBSpacing.xSmall),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: SBBSpacing.xxSmall,
            children: [
              Text(title, style: style.titleTextStyle),
              if (secondaryLabel != null) Text(secondaryLabel!, style: secondaryTextStyle),
            ],
          ),
        ),
        SizedBox(width: SBBSpacing.xSmall),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }
}
