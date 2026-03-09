import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  bool _showCloseButton = true;
  bool _customBackgroundColor = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            spacing: SBBSpacing.medium,
            children: [
              ThemeModeSegmentedButton(),
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
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall).copyWith(bottom: SBBSpacing.xLarge),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: SBBSpacing.medium),
              const SBBListHeader('Modal Examples'),
              _ExampleCard(
                title: 'Simple (Content Size)',
                description: 'Does not fill height, only the size of the bottom sheet itself',
                onPressed: () => _showSimpleExample(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'Half Height',
                description: 'Expand to fill half of the screen height',
                onPressed: () => _showHalfHeightExample(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'With Text Input',
                description: 'Expand to 9/16 with SBBTextInput to test keyboard interaction',
                onPressed: () => _showTextInputExample(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'Custom Sliver (Scroll Controlled)',
                description: 'Expand with CustomScrollView and isScrollControlled: true',
                onPressed: () => _showCustomSliverExample(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'Modal Popup',
                description: 'Dialog-style modal popup',
                onPressed: () => _showModalPopup(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSimpleExample(BuildContext context) {
    showSBBBottomSheet(
      context: context,
      // leadingIconData: SBBIcons.three_adults_small,
      trailingIconData: SBBIcons.chevron_small_up_circle_small,
      // titleText: 'Simple Bottom Sheet',
      showCloseButton: _showCloseButton,
      style: SBBBottomSheetStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: SBBSpacing.small),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: SBBSpacing.medium,
          children: [
            Text(
              'This sheet only takes up the space it needs.',
              style: sbbTextStyle.small.lightStyle,
            ),
            SBBPrimaryButton(
              labelText: 'Close',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showHalfHeightExample(BuildContext context) {
    showSBBBottomSheet(
      context: context,
      titleText: 'Half Height Sheet',
      showCloseButton: _showCloseButton,
      isScrollControlled: false,
      scrollControlDisabledMaxHeightRatio: .5,
      style: SBBBottomSheetStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: SBBSpacing.small),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: .spaceBetween,
          spacing: SBBSpacing.medium,
          children: [
            Text(
              'This sheet fills 50% of the screen height.',
              style: sbbTextStyle.small.lightStyle,
            ),
            SBBPrimaryButton(
              labelText: 'Close',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showTextInputExample(BuildContext context) {
    showSBBBottomSheet(
      context: context,
      titleText: 'Text Input Sheet',
      showCloseButton: _showCloseButton,
      isScrollControlled: true,
      style: SBBBottomSheetStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: _KeyboardAwareBody(),
    );
  }

  void _showCustomSliverExample(BuildContext context) {
    showSBBBottomSheet(
      context: context,
      titleText: 'Custom Sliver Example',
      showCloseButton: _showCloseButton,
      isScrollControlled: true,
      style: SBBBottomSheetStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: SBBSpacing.medium),
              child: Text(
                'This sheet uses CustomScrollView with isScrollControlled: true. '
                'It expands to fill available space and becomes draggable.',
                style: sbbTextStyle.small.lightStyle,
              ),
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: SBBSpacing.medium,
            crossAxisSpacing: SBBSpacing.medium,
            children: List.generate(
              20,
              (index) => Container(
                decoration: BoxDecoration(
                  color: [
                    SBBColors.red,
                    SBBColors.green,
                    SBBColors.blue,
                    SBBColors.lemon,
                  ][index % 4],
                  borderRadius: BorderRadius.circular(SBBSpacing.medium),
                ),
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: SBBSpacing.medium, bottom: SBBSpacing.small),
              child: SBBPrimaryButton(
                labelText: 'Close',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModalPopup(BuildContext context) {
    showSBBModalPopup(
      context: context,
      title: 'Modal Popup',
      showCloseButton: _showCloseButton,
      backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      child: SingleChildScrollView(
        child: Column(
          spacing: SBBSpacing.medium,
          crossAxisAlignment: .start,
          children: [
            Text(
              'This is a modal popup, displayed as a dialog.',
              style: sbbTextStyle.small.lightStyle,
            ),
            SBBPrimaryButton(
              labelText: 'Got it',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.title,
    required this.description,
    required this.onPressed,
  });

  final String title;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(
      padding: EdgeInsets.all(SBBSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SBBSpacing.small,
        children: [
          Text(
            title,
            style: sbbTextStyle.large.boldStyle,
          ),
          Text(
            description,
            style: sbbTextStyle.small.lightStyle,
          ),
          SizedBox(height: SBBSpacing.xSmall),
          SizedBox(
            width: double.infinity,
            child: SBBTertiaryButton(
              labelText: 'Show Example',
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyboardAwareBody extends StatelessWidget {
  _KeyboardAwareBody({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom + SBBSpacing.small),
      child: Column(
        mainAxisSize: .min,
        spacing: SBBSpacing.medium,
        children: [
          Text(
            'Test keyboard interaction with text input. Sheet respects keyboard height.',
            style: sbbTextStyle.small.lightStyle,
          ),
          SBBTextInput(
            controller: controller,
            decoration: SBBInputDecoration(labelText: 'Enter Text'),
          ),
          SBBPrimaryButton(
            labelText: 'Submit',
            onPressed: () => Navigator.of(context).pop(controller.text),
          ),
        ],
      ),
    );
  }
}
