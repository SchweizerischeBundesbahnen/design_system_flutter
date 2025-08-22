import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

const _description =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool _showInteractionButton = true;
  bool _isLoading = false;
  bool _showIllustrations = true;
  late SBBToast _toast;

  @override
  void initState() {
    _toast = SBBToast.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Settings'),
        SBBGroup(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SBBCheckboxListItem(
                value: _showInteractionButton,
                label: 'Show interaction button',
                onChanged:
                    (value) =>
                        setState(() => _showInteractionButton = value ?? false),
              ),
              SBBCheckboxListItem(
                value: _isLoading,
                label: 'Is loading',
                onChanged:
                    (value) => setState(() => _isLoading = value ?? false),
              ),
              SBBCheckboxListItem(
                value: _showIllustrations,
                label: 'Show Illustrations',
                isLastElement: true,
                onChanged:
                    (value) =>
                        setState(() => _showIllustrations = value ?? false),
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Default'),
        SBBGroup(
          child: SBBMessage(
            title: 'Title, single line if possible',
            description: _description,
            isLoading: _isLoading,
            illustration: _showIllustrations ? MessageIllustration.Woman : null,
            onInteraction: _onInteractionCallback(),
          ),
        ),
        const SBBListHeader('Error'),
        SBBGroup(
          child: SBBMessage.error(
            title: 'Title, single line if possible',
            description: _description,
            messageCode: 'Error Code: XYZ-999',
            isLoading: _isLoading,
            illustration:
                _showIllustrations ? MessageIllustration.Display : null,
            onInteraction: _onInteractionCallback(),
          ),
        ),
        const SBBListHeader('Custom'),
        SBBGroup(
          child: SBBMessage(
            isLoading: _isLoading,
            title: 'Custom',
            description: _description,
            customIllustration: Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              color: SBBColors.red,
            ),
            onInteraction: _onInteractionCallback(),
          ),
        ),
      ],
    );
  }

  VoidCallback? _onInteractionCallback() =>
      _showInteractionButton ? () => _toast.show(title: 'Tapped') : null;
}
