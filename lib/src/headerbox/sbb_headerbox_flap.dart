import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const _flapBorderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(sbbDefaultSpacing),
  bottomRight: Radius.circular(sbbDefaultSpacing),
);

const _flapIconSize = 24.0;

/// Use in combination with the [SBBHeaderbox] for the [flap] argument.
///
/// See [HeaderBox in documentation](https://digital.sbb.ch/de/design-system/mobile/components/container/).
///
/// For a complete custom variant, use the [custom] constructor.
class SBBHeaderboxFlap extends StatelessWidget {
  SBBHeaderboxFlap({
    Key? key,
    required String title,
    bool allowMultilineLabel = true,
    IconData? leadingIcon,
    IconData? trailingIcon,
  }) : this.custom(
         key: key,
         child: _buildDefaultFlap(
           title,
           allowMultilineLabel,
           leadingIcon,
           trailingIcon,
         ),
       );

  /// Allows complete customization of the content of the [SBBHeaderboxFlap].
  const SBBHeaderboxFlap.custom({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(
      sbbDefaultSpacing,
      0.0, // margin from [SBBHeaderBox] to allow shadow
      sbbDefaultSpacing,
      sbbDefaultSpacing * .5,
    ),
  });

  /// The padding for the content of the [SBBHeaderboxFlap].
  final EdgeInsets padding;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Color? flapColor = SBBHeaderBoxStyle.of(context).flapBackgroundColor;
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: flapColor, borderRadius: _flapBorderRadius),
      child: child,
    );
  }

  static Widget _buildDefaultFlap(
    String title,
    bool allowMultilineLabel,
    IconData? leadingIcon,
    IconData? trailingIcon,
  ) {
    return Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: _flapIconSize),
          SizedBox(width: sbbDefaultSpacing * .5),
        ],
        Expanded(
          child: Text(
            title,
            maxLines: allowMultilineLabel ? null : 1,
            overflow: allowMultilineLabel ? null : TextOverflow.ellipsis,
            style: SBBTextStyles.smallLight,
          ),
        ),
        if (trailingIcon != null) ...[
          SizedBox(width: sbbDefaultSpacing * .5),
          Icon(trailingIcon, size: _flapIconSize),
        ],
      ],
    );
  }
}
