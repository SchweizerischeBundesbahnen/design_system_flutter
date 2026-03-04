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
      ],
    );
  }

  Widget _modalSheetFullButton(BuildContext context) {
    return SBBTertiaryButton(
      labelText: 'Modal Sheet Full',
      onPressed: () async {
        final result = await showSBBBottomSheet<String>(
          context: context,
          titleText: 'Titel',
          showCloseButton: _showCloseButton,
          scrollControlDisabledMaxHeightRatio: 1.0,
          style: SBBBottomSheetStyle(backgroundColor: _customBackgroundColor ? SBBColors.peach : null),
          body: _modalContent(context),
        );
        debugPrint('Modal Sheet Full Result: $result');
      },
    );
  }

  Widget _modalSheetButton(BuildContext context) {
    return SBBTertiaryButton(
      labelText: 'Modal Sheet',
      onPressed: () async {
        final result = await showSBBBottomSheet<String>(
          context: context,
          titleText: 'Titel',
          showCloseButton: _showCloseButton,
          style: SBBBottomSheetStyle(
            backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
            constraints: BoxConstraints.expand(),
          ),
          body: _modalContent(context),
        );
        debugPrint('Modal Sheet Result: $result');
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

  Widget _modalContent(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .max,
      mainAxisAlignment: .spaceBetween,
      children: [
        const Text(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
        ),
        SBBPrimaryButton(labelText: 'Begone!', onPressed: () => Navigator.of(context).pop('OK')),
      ],
    );
  }
}
