import 'package:animations/animations.dart';
import 'package:design_system_flutter/design_system_flutter.dart';

import 'package:flutter/material.dart';

import '../native_app.dart';
import 'accordion_page.dart';
import 'autocompletion_page.dart';
import 'button_page.dart';
import 'checkbox_page.dart';
import 'group_page.dart';
import 'header_page.dart';
import 'icon_page.dart';
import 'link_page.dart';
import 'list_header_page.dart';
import 'list_item_page.dart';
import 'loading_indicator_page.dart';
import 'modal_page.dart';
import 'notification_box_page.dart';
import 'onboarding_page.dart';
import 'promotion_box_page.dart';
import 'radio_button_page.dart';
import 'segmented_button_page.dart';
import 'select_page.dart';
import 'tab_bar_page.dart';
import 'text_field_page.dart';
import 'toast_page.dart';
import 'typography_page.dart';
import 'typography_red_page.dart';

class LaunchpadPage extends StatelessWidget {
  const LaunchpadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SBBHeader(
          title: 'Design System Mobile', automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: sbbDefaultSpacing,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: sbbDefaultSpacing,
                ),
                child: ThemeModeSegmentedButton(),
              ),
              const SBBListHeader('Basics'),
              SBBGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _DemoEntry('Icon', IconPage()),
                    _DemoEntry('Typography', TypographyPage()),
                    _DemoEntry('Typography Red', TypographyRedPage(),
                        isLastElement: true),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Elements'),
              SBBGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _DemoEntry('Button', ButtonPage()),
                    _DemoEntry('Checkbox', CheckboxPage()),
                    _DemoEntry('Link', LinkPage()),
                    _DemoEntry('List Header', ListHeaderPage()),
                    _DemoEntry('List Item', ListItemPage()),
                    _DemoEntry('Loading Indicator', LoadingIndicatorPage()),
                    _DemoEntry('Radio Button', RadiobuttonPage()),
                    _DemoEntry('Segmented Button', SegmentedButtonPage()),
                    _DemoEntry('Select', SelectPage()),
                    _DemoEntry('Textfield / Textarea', TextFieldPage()),
                    _DemoEntry('Promotion Box', PromotionBoxPage()),
                    _DemoEntry('Notification Box', NotificationBoxPage(), isLastElement: true),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Modules'),
              SBBGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _DemoEntry('Accordion', AccordionPage()),
                    _DemoEntry('Autocompletion', AutocompletionPage()),
                    _DemoEntry('Group', GroupPage()),
                    _DemoEntry('Header', HeaderPage()),
                    _DemoEntry('Modal', ModalPage()),
                    _DemoEntry('Toast', ToastPage()),
                    _DemoEntry('Onboarding', OnboardingPage()),
                    _DemoEntry('Tab Bar', TabBarPage(), isLastElement: true),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoEntry extends StatelessWidget {
  const _DemoEntry(this.title, this.page, {this.isLastElement = false});

  final String title;
  final Widget page;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      openColor: SBBColors.transparent,
      closedColor: SBBColors.transparent,
      closedShape: const RoundedRectangleBorder(),
      openShape: const RoundedRectangleBorder(),
      closedBuilder: (context, action) {
        return Container(
          color: style.groupBackgroundColor,
          child: SBBListItem(
            title: title,
            trailingIcon: SBBIcons.chevron_small_right_small,
            onPressed: action,
            isLastElement: isLastElement,
          ),
        );
      },
      openBuilder: (context, action) {
        return _DemoPage(title, page);
      },
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage(this.title, this.child);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SBBHeader(
        title: title,
        onPressedLogo: () => Navigator.maybePop(context),
        logoTooltip: 'Back to home',
      ),
      body: child,
    );
  }
}
