import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
      padding: const .all(SBBSpacing.medium),
      children: [
        ThemeModeSegmentedButton(),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Settings'),
        ...SBBListItem.divideListItems(
          context: context,
          items: [
            SBBCheckboxListItem(
              value: _showCloseButton,
              titleText: 'Show close button',
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
              titleText: 'Custom background color',
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    _customBackgroundColor = value;
                  }
                });
              },
            ),
          ],
        ),
        const SizedBox(height: SBBSpacing.medium),
        _modalPopupButton(context),
        const SizedBox(height: SBBSpacing.medium),
        _modalSheetButton(context),
        const SizedBox(height: SBBSpacing.medium),
        _modalSheetFullButton(context),
        const SizedBox(height: SBBSpacing.medium),
        _customModalSheetButton(context),
      ],
    );
  }

  Widget _modalSheetFullButton(BuildContext context) {
    return SBBTertiaryButton(
      labelText: 'Modal Sheet Full',
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
    return SBBTertiaryButton(
      labelText: 'Modal Sheet',
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
    return SBBTertiaryButton(
      labelText: 'Custom Modal Sheet',
      onPressed: () async {
        final result = await showCustomSBBModalSheet<String>(
          context: context,
          header: const Padding(
            padding: .all(SBBSpacing.medium),
            child: Row(
              children: [
                Icon(SBBIcons.app_icon_small),
                SizedBox(width: SBBSpacing.medium),
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
    return SBBTertiaryButton(
      labelText: 'Modal Popup',
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
      padding: const EdgeInsetsDirectional.fromSTEB(SBBSpacing.medium, 0.0, SBBSpacing.medium, SBBSpacing.medium),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: fullHeight ? .max : .min,
        children: [
          const Text(
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          ),
          const SizedBox(height: SBBSpacing.medium),
          SBBPrimaryButton(labelText: 'Begone!', onPressed: () => Navigator.of(context).pop('OK')),
        ],
      ),
    );
  }
}
