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
        _modalSheetExpandButton(context),
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
          body: _modalContent(context, fullHeight: true),
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
          title: Container(height: 20, width: double.infinity, color: SBBColors.green),
          leading: Container(height: 100, width: 10, color: SBBColors.red),
          trailing: Container(height: 10, width: 10, color: SBBColors.red),
          showCloseButton: _showCloseButton,
          style: SBBBottomSheetStyle(
            backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
            constraints: BoxConstraints.tightFor(width: double.infinity),
          ),
          body: _modalContent(context, fullHeight: false),
        );
        debugPrint('Modal Sheet Result: $result');
      },
    );
  }

  Widget _modalSheetExpandButton(BuildContext context) {
    return SBBTertiaryButton(
      labelText: 'Modal Sheet Expand',
      onPressed: () async {
        final result = await showSBBBottomSheet<String>(
          context: context,
          titleText: 'Title',
          showCloseButton: _showCloseButton,
          style: SBBBottomSheetStyle(
            backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
            constraints: BoxConstraints.tightFor(width: double.infinity),
          ),
          body: _modalContent(context, fullHeight: true),
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

  Widget _modalContent(BuildContext context, {bool fullHeight = false}) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: fullHeight ? .max : .min,
      mainAxisAlignment: .spaceBetween,
      children: [
        Container(width: double.infinity, height: 20, color: SBBColors.turquoise),
        Text(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
          'sed diam nonumy eirmod tempor invidunt ut labore et dolore '
          'magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. '
          'Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          style: sbbTextStyle.small.lightStyle,
        ),
        SizedBox(height: SBBSpacing.medium),
        SBBPrimaryButton(labelText: 'Begone!', onPressed: () => Navigator.of(context).pop('OK')),
      ],
    );
  }
}
