import '../../design_system_flutter.dart';
import 'package:flutter/material.dart';

const _kBorderRadius = 2.0;

@Deprecated('will soon be moved to the web package')
class SBBStatus extends StatelessWidget {
  const SBBStatus.valid({
    Key? key,
    this.text,
    this.icon = SBBIcons.tick_medium,
    this.showIcon = true,
    this.backgroundColor = SBBColors.green,
    this.textColor = SBBColors.white,
  });

  const SBBStatus.warning({
    Key? key,
    this.text,
    this.showIcon = true,
    this.icon = SBBIcons.exclamation_point_medium,
    this.backgroundColor = SBBColors.orange,
    this.textColor = SBBColors.white,
  });

  const SBBStatus.invalid({
    Key? key,
    this.text,
    this.icon = SBBIcons.cross_medium,
    this.showIcon = true,
    this.backgroundColor = SBBColors.red,
    this.textColor = SBBColors.white,
  });

  const SBBStatus.inProgress({
    Key? key,
    this.text,
    this.icon = SBBIcons.arrows_circle_medium,
    this.showIcon = true,
    this.backgroundColor = SBBColors.granite,
    this.textColor = SBBColors.white,
  });

  const SBBStatus.inactive({
    Key? key,
    this.text,
    this.icon = SBBIcons.wifi_disabled_medium,
    this.showIcon = true,
    this.backgroundColor = SBBColors.milk,
    this.textColor = SBBColors.black,
  });

  final bool showIcon;
  final String? text;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (SBBBaseStyle.of(context).hostPlatform == HostPlatform.native)
      debugPrint(
          'WARNING: Status component should only be used for web platform.');
    if (showIcon && text == null) {
      return _buildIconBox();
    }
    if (showIcon && text != null && text!.isNotEmpty) {
      return _buildExtendedStatus();
    }
    return _buildTextBox(backgroundColor, textColor);
  }

  Container _buildExtendedStatus() {
    return Container(
      child: Row(
        children: [
          _buildIconBox(),
          Container(
            width: 10,
          ),
          _buildTextBox(SBBColors.milk, SBBColors.granite),
        ],
      ),
    );
  }

  Container _buildTextBox(Color bgColor, Color txtColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DefaultTextStyle(
            style: SBBWebTextStyles.medium.copyWith(color: txtColor),
            child: Text(text == null ? '' : text!)),
      ),
    );
  }

  Container _buildIconBox() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Icon(
          icon,
          color: textColor,
        ),
      ),
    );
  }
}
