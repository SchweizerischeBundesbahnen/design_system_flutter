import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

part 'sbb_status.type.dart';

class SBBStatus extends StatelessWidget {
  const SBBStatus({required this.type, super.key, this.text});

  factory SBBStatus.alert({Key? key, String? text}) =>
      SBBStatus(type: SBBStatusType.alert, key: key, text: text);

  factory SBBStatus.warning({Key? key, String? text}) =>
      SBBStatus(type: SBBStatusType.warning, key: key, text: text);

  factory SBBStatus.success({Key? key, String? text}) =>
      SBBStatus(type: SBBStatusType.success, key: key, text: text);

  factory SBBStatus.information({Key? key, String? text}) =>
      SBBStatus(type: SBBStatusType.information, key: key, text: text);

  final SBBStatusType type;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              color: type.backgroundColor,
              child: Icon(type.icon, color: type.iconColor),
            ),
            if (text != null)
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: type.backgroundColor),
                    color: type.backgroundColor.withOpacity(.05),
                  ),
                  child: Text(text!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
