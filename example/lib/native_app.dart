import 'package:animations/animations.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/accordion_page.dart';
import 'pages/autocompletion_page.dart';
import 'pages/button_page.dart';
import 'pages/checkbox_page.dart';
import 'pages/chip_page.dart';
import 'pages/color_page.dart';
import 'pages/group_page.dart';
import 'pages/header_box_page.dart';
import 'pages/header_page.dart';
import 'pages/icon_page.dart';
import 'pages/input_trigger_page.dart';
import 'pages/link_page.dart';
import 'pages/list_header_page.dart';
import 'pages/list_item_page.dart';
import 'pages/loading_indicator_page.dart';
import 'pages/message_page.dart';
import 'pages/modal_page.dart';
import 'pages/notification_box_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/pagination_page.dart';
import 'pages/picker_page.dart';
import 'pages/promotion_box_page.dart';
import 'pages/radio_button_page.dart';
import 'pages/segmented_button_page.dart';
import 'pages/select_page.dart';
import 'pages/slider_page.dart';
import 'pages/status_page.dart';
import 'pages/stepper_page.dart';
import 'pages/switch_page.dart';
import 'pages/tab_bar_page.dart';
import 'pages/text_field_page.dart';
import 'pages/toast_page.dart';
import 'pages/typography_page.dart';
import 'pages/typography_red_page.dart';

class AppState extends ChangeNotifier {
  bool isDarkModeOn = false;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Consumer<AppState>(
        builder: (BuildContext context, AppState appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: SBBTheme.light(),
            darkTheme: SBBTheme.dark(),
            themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('de'),
              Locale('fr'),
              Locale('it'),
            ],
            locale: const Locale('de'),
            home: Scaffold(
              appBar: const SBBHeader(title: 'Design System Mobile'),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: sbbDefaultSpacing,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: sbbDefaultSpacing,
                        ),
                        child: ThemeModeSegmentedButton(),
                      ),
                      const SBBListHeader('Basics'),
                      SBBGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _DemoEntry(
                              'Icon',
                              IconPage(),
                            ),
                            _DemoEntry(
                              'Typography',
                              TypographyPage(),
                            ),
                            _DemoEntry(
                              'Typography Red',
                              TypographyRedPage(),
                            ),
                            _DemoEntry(
                              'Color',
                              ColorPage(),
                              isLastElement: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: sbbDefaultSpacing),
                      const SBBListHeader('Elements'),
                      SBBGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _DemoEntry(
                              'Button',
                              ButtonPage(),
                            ),
                            _DemoEntry(
                              'Checkbox',
                              CheckboxPage(),
                            ),
                            _DemoEntry(
                              'Link',
                              LinkPage(),
                            ),
                            _DemoEntry(
                              'List Header',
                              ListHeaderPage(),
                            ),
                            _DemoEntry(
                              'List Item',
                              ListItemPage(),
                            ),
                            _DemoEntry(
                              'Loading Indicator',
                              LoadingIndicatorPage(),
                            ),
                            _DemoEntry(
                              'Picker',
                              PickerPage(),
                            ),
                            _DemoEntry(
                              'Radio Button',
                              RadiobuttonPage(),
                            ),
                            _DemoEntry(
                              'Segmented Button',
                              SegmentedButtonPage(),
                            ),
                            _DemoEntry(
                              'Select',
                              SelectPage(),
                            ),
                            const _DemoEntry(
                              'Switch',
                              SwitchPage(),
                            ),
                            _DemoEntry(
                              'Textfield / Textarea',
                              TextFieldPage(),
                            ),
                            _DemoEntry(
                              'Chip',
                              ChipPage(),
                            ),
                            const _DemoEntry(
                              'Pagination',
                              PaginationPage(),
                            ),
                            _DemoEntry(
                              'Slider',
                              SliderPage(),
                            ),
                            _DemoEntry(
                              'Promotion Box',
                              PromotionBoxPage(),
                            ),
                            _DemoEntry(
                              'Notification Box',
                              NotificationBoxPage(),
                            ),
                            _DemoEntry(
                              'Status',
                              StatusPage(),
                            ),
                            _DemoEntry(
                              'Input Trigger',
                              InputTriggerPage(),
                              isLastElement: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: sbbDefaultSpacing),
                      const SBBListHeader('Modules'),
                      SBBGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _DemoEntry(
                              'Accordion',
                              AccordionPage(),
                            ),
                            _DemoEntry(
                              'Autocompletion',
                              AutocompletionPage(),
                            ),
                            _DemoEntry(
                              'Group',
                              GroupPage(),
                            ),
                            _DemoEntry(
                              'Header',
                              HeaderPage(),
                            ),
                            _DemoEntry(
                              'Headerbox',
                              HeaderBoxPage(),
                            ),
                            _DemoEntry(
                              'Modal',
                              ModalPage(),
                            ),
                            _DemoEntry(
                              'Toast',
                              ToastPage(),
                            ),
                            _DemoEntry(
                              'Onboarding',
                              OnboardingPage(),
                            ),
                            _DemoEntry(
                              'Message',
                              MessagePage(),
                            ),
                            _DemoEntry(
                              'Stepper',
                              StepperPage(),
                            ),
                            _DemoEntry(
                              'Tab Bar',
                              TabBarPage(),
                              isLastElement: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: sbbDefaultSpacing),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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

class ThemeModeSegmentedButton extends StatelessWidget {
  const ThemeModeSegmentedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SBBSegmentedButton.icon(
      icons: {
        SBBIcons.sunshine_small: 'Light theme',
        SBBIcons.moon_small: 'Dark theme',
      },
      selectedIndexChanged: (value) {
        Provider.of<AppState>(
          context,
          listen: false,
        ).updateTheme(value == 1);
      },
      selectedStateIndex: Provider.of<AppState>(context).isDarkModeOn ? 1 : 0,
    );
  }
}
