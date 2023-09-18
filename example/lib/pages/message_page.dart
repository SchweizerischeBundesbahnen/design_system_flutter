import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class MessagePage extends StatefulWidget {
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool? _showInteractionButton = true;
  bool? _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Settings'),
        SBBCheckboxListItem(
          value: _showInteractionButton,
          label: 'Show interaction button',
          onChanged: (value) => setState(() => _showInteractionButton = value),
        ),
        SBBCheckboxListItem(
          value: _isLoading,
          label: 'Is loading',
          onChanged: (value) => setState(() => _isLoading = value),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Default'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBMessage(
            title: 'Title, single line if possible',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
            isLoading: _isLoading ?? false,
            onInteraction: _onInteractionCallback(),
          ),
        ),
        const SBBListHeader('Error'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBMessage.error(
            title: 'Title, single line if possible',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
            messageCode: 'Error Code: XYZ-999',
            isLoading: _isLoading ?? false,
            onInteraction: _onInteractionCallback(),
          ),
        ),
      ],
    );
  }

  VoidCallback? _onInteractionCallback() =>
      (_showInteractionButton ?? false) ? () {} : null;
}
