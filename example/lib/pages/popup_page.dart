import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class PopupPage extends StatefulWidget {
  const PopupPage({super.key});

  @override
  State<PopupPage> createState() => _PopupPageState();
}

class _PopupPageState extends State<PopupPage> {
  bool _showCloseButton = true;
  bool _customBackgroundColor = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
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
                        if (value != null) _showCloseButton = value;
                      });
                    },
                  ),
                  SBBCheckboxListItem(
                    value: _customBackgroundColor,
                    titleText: 'Custom background color',
                    onChanged: (value) {
                      setState(() {
                        if (value != null) _customBackgroundColor = value;
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
              const SBBListHeader('Popup Examples'),
              _ExampleCard(
                title: 'Title Only',
                description: 'Popup with just a title and body',
                onPressed: () => _showTitleOnly(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'Title + Leading Icon',
                description: 'Popup with a leading icon in the header',
                onPressed: () => _showWithLeadingIcon(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'Title + Trailing Icon',
                description: 'Popup with a trailing icon in the header',
                onPressed: () => _showWithTrailingIcon(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'All Header Elements',
                description: 'Leading icon, title, trailing icon and close button',
                onPressed: () => _showWithAllHeaderElements(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'No Header',
                description: 'Popup with only a body, no header elements',
                onPressed: () => _showNoHeader(context),
              ),
              const SizedBox(height: SBBSpacing.medium),
              _ExampleCard(
                title: 'Custom Style',
                description: 'Popup with custom background color and padding',
                onPressed: () => _showCustomStyle(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showTitleOnly(BuildContext context) {
    showSBBPopup(
      context: context,
      titleText: 'Title',
      showCloseButton: _showCloseButton,
      style: SBBPopupStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: _popupContent(context),
    );
  }

  void _showWithLeadingIcon(BuildContext context) {
    showSBBPopup(
      context: context,
      titleText: 'Title',
      leadingIconData: SBBIcons.dog_small,
      showCloseButton: _showCloseButton,
      style: SBBPopupStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: _popupContent(context),
    );
  }

  void _showWithTrailingIcon(BuildContext context) {
    showSBBPopup(
      context: context,
      titleText: 'Title',
      trailingIconData: SBBIcons.warning_light_small,
      showCloseButton: _showCloseButton,
      style: SBBPopupStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: _popupContent(context),
    );
  }

  void _showWithAllHeaderElements(BuildContext context) {
    showSBBPopup(
      context: context,
      titleText: 'Title',
      leadingIconData: SBBIcons.three_adults_small,
      trailingIconData: SBBIcons.warning_light_small,
      showCloseButton: _showCloseButton,
      style: SBBPopupStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: _popupContent(context),
    );
  }

  void _showNoHeader(BuildContext context) {
    showSBBPopup(
      context: context,
      showCloseButton: false,
      style: SBBPopupStyle(
        backgroundColor: _customBackgroundColor ? SBBColors.peach : null,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SBBSpacing.medium,
        children: [
          Text(
            'This popup has no header at all – only body content.',
            style: sbbTextStyle.small.lightStyle,
          ),
          SBBPrimaryButton(
            labelText: 'Close',
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
    );
  }

  void _showCustomStyle(BuildContext context) {
    showSBBPopup(
      context: context,
      titleText: 'Custom Style',
      showCloseButton: _showCloseButton,
      style: SBBPopupStyle(
        backgroundColor: SBBColors.peach,
        titleForegroundColor: SBBColors.red,
        padding: const EdgeInsets.all(SBBSpacing.large),
        titleBodyGap: SBBSpacing.medium,
      ),
      body: _popupContent(context),
    );
  }

  Widget _popupContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: SBBSpacing.medium,
      children: [
        Text(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
          'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.',
          style: sbbTextStyle.small.lightStyle,
        ),
        SBBPrimaryButton(
          labelText: 'Got it',
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
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
          Text(title, style: sbbTextStyle.large.boldStyle),
          Text(description, style: sbbTextStyle.small.lightStyle),
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
