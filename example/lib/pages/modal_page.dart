import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ModalPage extends StatelessWidget {
  const ModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(sbbDefaultSpacing),
          child: ThemeModeSegmentedButton(),
        ),
        SBBTertiaryButtonLarge(
          label: 'Modal Popup',
          onPressed: () {
            showSBBModalPopup(
              context: context,
              title: 'Titel',
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  sbbDefaultSpacing,
                  0.0,
                  sbbDefaultSpacing,
                  sbbDefaultSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'),
                    const SizedBox(height: sbbDefaultSpacing),
                    SBBPrimaryButton(
                      label: 'Begone!',
                      onPressed: () {
                        Navigator.of(context).pop('OK');
                      },
                    ),
                  ],
                ),
              ),
            ).then((result) {
              debugPrint('Modal Popup Result: $result');
            });
          },
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBTertiaryButtonLarge(
          label: 'Modal Sheet',
          onPressed: () async {
            showSBBModalSheet<String>(
              context: context,
              title: 'Titel',
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  sbbDefaultSpacing,
                  0.0,
                  sbbDefaultSpacing,
                  sbbDefaultSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'),
                    const SizedBox(height: sbbDefaultSpacing),
                    SBBPrimaryButton(
                      label: 'Begone!',
                      onPressed: () {
                        Navigator.of(context).pop('OK');
                      },
                    ),
                  ],
                ),
              ),
            ).then((result) {
              debugPrint('Modal Sheet Result: $result');
            });
          },
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBTertiaryButtonLarge(
          label: 'Modal Sheet Full',
          onPressed: () async {
            showSBBModalSheet<String>(
              context: context,
              title: 'Titel',
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  sbbDefaultSpacing,
                  0.0,
                  sbbDefaultSpacing,
                  sbbDefaultSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'),
                    const SizedBox(height: sbbDefaultSpacing),
                    SBBPrimaryButton(
                      label: 'Begone!',
                      onPressed: () {
                        Navigator.of(context).pop('OK');
                      },
                    ),
                  ],
                ),
              ),
            ).then((result) {
              debugPrint('Modal Sheet Full Result: $result');
            });
          },
        ),
      ],
    );
  }
}
