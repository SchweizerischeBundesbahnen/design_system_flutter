import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

part 'sbb_status_mobile.type.dart';

@Deprecated(
    'Will be renamed to SBBStatus as soon as web and mobile plugins are separated')
class SBBStatusMobile extends StatelessWidget {
  const SBBStatusMobile({required this.type, super.key, this.text});

  factory SBBStatusMobile.alert({Key? key, String? text}) => SBBStatusMobile(
        type: SBBStatusMobileType.alert,
        key: key,
        text: text,
      );

  factory SBBStatusMobile.warning({Key? key, String? text}) => SBBStatusMobile(
        type: SBBStatusMobileType.warning,
        key: key,
        text: text,
      );

  factory SBBStatusMobile.success({Key? key, String? text}) => SBBStatusMobile(
        type: SBBStatusMobileType.success,
        key: key,
        text: text,
      );

  factory SBBStatusMobile.information({Key? key, String? text}) =>
      SBBStatusMobile(
        type: SBBStatusMobileType.information,
        key: key,
        text: text,
      );

  final SBBStatusMobileType type;
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
              child: Icon(
                type.icon,
                color: type.iconColor,
              ),
            ),
            if (text != null)
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
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
