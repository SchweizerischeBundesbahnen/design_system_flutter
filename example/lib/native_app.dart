import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'pages/autocompletion_page.dart';
import 'pages/button_page.dart';
import 'pages/checkbox_page.dart';
import 'pages/chip_page.dart';
import 'pages/color_page.dart';
import 'pages/container_page.dart';
import 'pages/header_box_page.dart';
import 'pages/header_page.dart';
import 'pages/icon_page.dart';
import 'pages/input_trigger_page.dart';
import 'pages/link_page.dart';
import 'pages/list_item_page.dart';
import 'pages/loading_indicator_page.dart';
import 'pages/message_page.dart';
import 'pages/modal_page.dart';
import 'pages/notification_box_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/paginator_page.dart';
import 'pages/picker_page.dart';
import 'pages/promotion_box_page.dart';
import 'pages/radio_page.dart';
import 'pages/segmented_button_page.dart';
import 'pages/select_page.dart';
import 'pages/slider_page.dart';
import 'pages/status_page.dart';
import 'pages/stepper_page.dart';
import 'pages/switch_page.dart';
import 'pages/tab_bar_page.dart';
import 'pages/text_area_page.dart';
import 'pages/text_input_page.dart';
import 'pages/toast_page.dart';
import 'pages/typography_page.dart';

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
            supportedLocales: const [Locale('en'), Locale('de'), Locale('fr'), Locale('it')],
            locale: const Locale('de'),
            home: Scaffold(
              appBar: const SBBHeader(
                title: 'Design System Mobile',
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              body: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: SBBSpacing.medium),
                            child: ThemeModeSegmentedButton(),
                          ),
                          const SBBListHeader('Basics'),
                          SBBContentBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: SBBListItem.divideListItems(
                                context: context,
                                items: [
                                  _DemoEntry('Icon', IconPage()),
                                  _DemoEntry('Typography', TypographyPage()),
                                  _DemoEntry('Color', ColorPage()),
                                ],
                              ).toList(growable: false),
                            ),
                          ),
                          const SizedBox(height: SBBSpacing.medium),
                          const SBBListHeader('Elements'),
                          SBBContentBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: SBBListItem.divideListItems(
                                context: context,
                                items: [
                                  _DemoEntry('Button', ButtonPage()),
                                  _DemoEntry('Checkbox', CheckboxPage()),
                                  _DemoEntry('Chip', ChipPage()),
                                  _DemoEntry('Link', LinkPage()),
                                  _DemoEntry('List Item', ListItemPage()),
                                  _DemoEntry('Loading Indicator', LoadingIndicatorPage()),
                                  _DemoEntry('Picker', PickerPage()),
                                  _DemoEntry('Radio', RadioPage()),
                                  _DemoEntry('Segmented Button', SegmentedButtonPage()),
                                  _DemoEntry('Select', SelectPage()),
                                  _DemoEntry('Switch', SwitchPage()),
                                  _DemoEntry('Text Input', TextInputPage()),
                                  _DemoEntry('Text Area', TextAreaPage()),
                                  _DemoEntry('Paginator', PaginatorPage()),
                                  _DemoEntry('Slider', SliderPage()),
                                  _DemoEntry('Promotion Box', PromotionBoxPage()),
                                  _DemoEntry('Notification Box', NotificationBoxPage()),
                                  _DemoEntry('Status', StatusPage()),
                                  _DemoEntry('Input Trigger', InputTriggerPage()),
                                ],
                              ).toList(growable: false),
                            ),
                          ),
                          const SizedBox(height: SBBSpacing.medium),
                          const SBBListHeader('Modules'),
                          SBBContentBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: SBBListItem.divideListItems(
                                context: context,
                                items: [
                                  _DemoEntry('Autocompletion', AutocompletionPage()),
                                  _DemoEntry('Container', ContainerPage()),
                                  _DemoEntry('Header', HeaderPage()),
                                  _DemoEntry('Headerbox', HeaderBoxPage()),
                                  _DemoEntry('Modal', ModalPage()),
                                  _DemoEntry('Toast', ToastPage()),
                                  _DemoEntry('Onboarding', OnboardingPage()),
                                  _DemoEntry('Message', MessagePage()),
                                  _DemoEntry('Stepper', StepperPage()),
                                  _DemoEntry('Tab Bar', TabBarPage()),
                                ],
                              ).toList(growable: false),
                            ),
                          ),
                          const SizedBox(height: SBBSpacing.medium),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DemoEntry extends StatelessWidget {
  const _DemoEntry(this.title, this.page);

  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      openColor: SBBColors.transparent,
      closedColor: SBBColors.transparent,
      closedShape: const RoundedRectangleBorder(),
      openShape: const RoundedRectangleBorder(),
      closedBuilder: (context, action) {
        return SBBListItem(
          titleText: title,
          trailingIconData: SBBIcons.chevron_small_right_small,
          onTap: action,
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
      appBar: SBBHeader(title: title, onPressedLogo: () => Navigator.maybePop(context), logoTooltip: 'Back to home'),
      body: child,
    );
  }
}

class ThemeModeSegmentedButton extends StatelessWidget {
  const ThemeModeSegmentedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SBBSegmentedButton<bool>(
      segments: [
        SBBButtonSegment(value: false, leadingIconData: SBBIcons.sunshine_small),
        SBBButtonSegment(value: true, leadingIconData: SBBIcons.moon_small),
      ],
      onSelectionChanged: (value) {
        Provider.of<AppState>(context, listen: false).updateTheme(value);
      },
      selected: Provider.of<AppState>(context).isDarkModeOn,
    );
  }
}
