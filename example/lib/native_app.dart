import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/form_page.dart';
import 'package:flutter_design_system_mobile_example/pages/illustration_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'pages/autocompletion_page.dart';
import 'pages/bottom_sheet_page.dart';
import 'pages/button_page.dart';
import 'pages/checkbox_page.dart';
import 'pages/chip_page.dart';
import 'pages/color_page.dart';
import 'pages/container_page.dart';
import 'pages/decorated_text_page.dart';
import 'pages/dropdown_page.dart';
import 'pages/header_box_page.dart';
import 'pages/header_page.dart';
import 'pages/icon_page.dart';
import 'pages/list_item_page.dart';
import 'pages/loading_indicator_page.dart';
import 'pages/message_page.dart';
import 'pages/notification_box_page.dart';
import 'pages/paginator_page.dart';
import 'pages/picker_page.dart';
import 'pages/popup_page.dart';
import 'pages/promotion_box_page.dart';
import 'pages/radio_page.dart';
import 'pages/segmented_button_page.dart';
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
        builder: (context, appState, _) {
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
              appBar: const SBBHeaderSmall(titleText: 'Design System Mobile'),
              body: _content(),
            ),
          );
        },
      ),
    );
  }

  Widget _content() {
    return Builder(
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const .symmetric(horizontal: SBBSpacing.medium),
            child: Column(
              children: [
                const Padding(
                  padding: .symmetric(vertical: SBBSpacing.medium),
                  child: ThemeModeSegmentedButton(),
                ),
                const SBBListHeader('Basics'),
                _basics(context),
                const SizedBox(height: SBBSpacing.medium),
                const SBBListHeader('Elements'),
                _elements(context),
                const SizedBox(height: SBBSpacing.medium),
                const SBBListHeader('Modules'),
                _modules(context),
                const SizedBox(height: SBBSpacing.xLarge),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _basics(BuildContext context) {
    return SBBContentBox(
      child: Column(
        mainAxisAlignment: .center,
        children: SBBListItem.divideListItems(
          context: context,
          items: [
            _DemoEntry('Icon', IconPage()),
            _DemoEntry('Typography', TypographyPage()),
            _DemoEntry('Color', ColorPage()),
          ],
        ),
      ),
    );
  }

  Widget _elements(BuildContext context) {
    return SBBContentBox(
      child: Column(
        mainAxisAlignment: .center,
        children: SBBListItem.divideListItems(
          context: context,
          items: [
            _DemoEntry('Bottom Sheet', BottomSheetPage()),
            _DemoEntry('Button', ButtonPage()),
            _DemoEntry('Checkbox', CheckboxPage()),
            _DemoEntry('Chip', ChipPage()),
            _DemoEntry('Decorated Text', DecoratedTextPage()),
            _DemoEntry('List Item', ListItemPage()),
            _DemoEntry('Loading Indicator', LoadingIndicatorPage()),
            _DemoEntry('Picker', PickerPage()),
            _DemoEntry('Popup', PopupPage()),
            _DemoEntry('Radio', RadioPage()),
            _DemoEntry('Segmented Button', SegmentedButtonPage()),
            _DemoEntry('Switch', SwitchPage()),
            _DemoEntry('Text Input', TextInputPage()),
            _DemoEntry('Text Area', TextAreaPage()),
            _DemoEntry('Toast', ToastPage()),
            _DemoEntry('Paginator', PaginatorPage()),
            _DemoEntry('Slider', SliderPage()),
            _DemoEntry('Promotion Box', PromotionBoxPage()),
            _DemoEntry('Notification Box', NotificationBoxPage()),
            _DemoEntry('Status', StatusPage()),
          ],
        ),
      ),
    );
  }

  Widget _modules(BuildContext context) {
    return SBBContentBox(
      child: Column(
        mainAxisAlignment: .center,
        children: SBBListItem.divideListItems(
          context: context,
          items: [
            _DemoEntry('Autocompletion', AutocompletionPage()),
            _DemoEntry('Container', ContainerPage()),
            _DemoEntry('Dropdown', DropdownPage()),
            _DemoEntry('Forms', FormPage()),
            _DemoEntry('Header', HeaderPage()),
            _DemoEntry('Headerbox', HeaderBoxPage()),
            _DemoEntry('Illustrations', IllustrationPage()),
            _DemoEntry('Message', MessagePage()),
            _DemoEntry('Stepper', StepperPage()),
            _DemoEntry('Tab Bar', TabBarPage()),
          ],
        ),
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
      closedBuilder: (_, action) => SBBListItem(
        titleText: title,
        trailingIconData: SBBIcons.chevron_small_right_small,
        onTap: action,
      ),
      openBuilder: (context, action) => _DemoPage(title, page),
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
      appBar: SBBHeaderSmall(titleText: title),
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
