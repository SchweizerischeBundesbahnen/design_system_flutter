import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ModalPage extends StatefulWidget {
  const ModalPage({super.key});

  @override
  State<ModalPage> createState() => _ModalPageState();
}

class _ModalPageState extends State<ModalPage> {
  bool _showCloseButton = false;
  bool _customBackgroundColor = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Settings'),
        SBBCheckboxListItem(
          value: _showCloseButton,
          label: 'Show close button',
          onChanged: (value) {
            setState(() {
              if (value != null) {
                _showCloseButton = value;
              }
            });
          },
        ),
        SBBCheckboxListItem(
          value: _customBackgroundColor,
          label: 'Custom background color',
          isLastElement: true,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                _customBackgroundColor = value;
              }
            });
          },
        ),
        const SizedBox(height: sbbDefaultSpacing),
        _modalPopupButton(context),
        const SizedBox(height: sbbDefaultSpacing),
        _modalSheetButton(context),
        const SizedBox(height: sbbDefaultSpacing),
        _modalSheetFullButton(context),
        const SizedBox(height: sbbDefaultSpacing),
        _customModalSheetButton(context),
      ],
    );
  }

  Widget _modalSheetFullButton(BuildContext context) {
    return SBBTertiaryButtonLarge(
      label: 'Modal Sheet Full',
      onPressed: () async {
        final result = await showSBBModalSheet<String>(
          context: context,
          title: 'Titel',
          showCloseButton: _showCloseButton,
          backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
          child: _modalContent(context, fullHeight: true),
        );
        debugPrint('Modal Sheet Full Result: $result');
      },
    );
  }

  Widget _modalSheetButton(BuildContext context) {
    return SBBTertiaryButtonLarge(
      label: 'Modal Sheet',
      onPressed: () async {
        final result = await showSBBModalSheet<String>(
          context: context,
          title: 'Titel',
          showCloseButton: _showCloseButton,
          backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
          child: _modalContent(context),
        );
        debugPrint('Modal Sheet Result: $result');
      },
    );
  }

  Widget _customModalSheetButton(BuildContext context) {
    return SBBTertiaryButtonLarge(
      label: 'Custom Modal Sheet',
      onPressed: () async {
        final result = await showCustomSBBModalSheet<String>(
          context: context,
          header: const Padding(
            padding: EdgeInsets.all(sbbDefaultSpacing),
            child: Row(
              children: [
                Icon(SBBIcons.app_icon_small),
                SizedBox(width: sbbDefaultSpacing),
                Text('Custom'),
              ],
            ),
          ),
          showCloseButton: _showCloseButton,
          backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
          child: _modalContent(context),
        );
        debugPrint('Custom Modal Sheet Result: $result');
      },
    );
  }

  Widget _modalPopupButton(BuildContext context) {
    return SBBTertiaryButtonLarge(
      label: 'Modal Popup',
      onPressed: () async {
        final result = await showSBBModalPopup(
          context: context,
          title: 'Titel',
          showCloseButton: _showCloseButton,
          backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
          child: _modalContent(context),
        );
        debugPrint('Modal Popup Result: $result');
      },
    );
  }

  Widget _modalContent(BuildContext context, {bool fullHeight = false}) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        sbbDefaultSpacing,
        0.0,
        sbbDefaultSpacing,
        sbbDefaultSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: fullHeight ? MainAxisSize.max : MainAxisSize.min,
        children: [
          const Text(
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBPrimaryButton(label: 'Begone!', onPressed: () => Navigator.of(context).pop('OK')),
        ],
      ),
    );
  }
}
