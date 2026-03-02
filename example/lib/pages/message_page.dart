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
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ThemeModeSegmentedButton(),
              const SizedBox(height: SBBSpacing.medium),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: SBBListItem.divideListItems(
                  context: context,
                  items: [
                    SBBSwitchListItem(
                      value: _isLoading,
                      titleText: 'Is Loading',
                      onChanged: (value) => setState(() => _isLoading = value ?? false),
                    ),
                    SBBSwitchListItem(
                      value: _showIllustrations,
                      titleText: 'Show Illustrations',
                      onChanged: (value) => setState(() => _showIllustrations = value ?? false),
                    ),
                  ],
                ).toList(growable: false),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall).copyWith(bottom: SBBSpacing.xLarge),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: SBBSpacing.medium),
              const SBBListHeader('Default'),
              SBBContentBox(
                child: SBBMessage(
                  titleText: 'Title, single line if possible',
                  subtitleText: _description,
                  isLoading: _isLoading,
                  illustration: _showIllustrations ? SBBIllustration.staffMale() : null,
                ),
              ),
              const SizedBox(height: SBBSpacing.medium),
              SBBContentBox(
                child: SBBMessage(
                  titleText: 'Telescope',
                  isLoading: _isLoading,
                  illustration: _showIllustrations ? SBBIllustration.telescope() : null,
                ),
              ),
              const SBBListHeader('Error'),
              SBBContentBox(
                child: SBBMessage(
                  titleText: 'Title, single line if possible',
                  subtitleText: _description,
                  errorText: 'Error Code: XYZ-999',
                  isLoading: _isLoading,
                  illustration: _showIllustrations ? SBBIllustration.display() : null,
                  action: SBBTertiaryButton(
                    onPressed: () {
                      _toast.show(titleText: 'Error');
                    },
                    iconData: SBBIcons.arrows_circle_small,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
