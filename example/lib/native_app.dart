import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/launchpad_page.dart';
import 'pages/start_page.dart';

class AppState extends ChangeNotifier {
  bool isDarkModeOn = false;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppState(),
        child: Consumer<AppState>(
            builder: (BuildContext context, AppState appState, _) {
          return SBBTheme(
              hostType: HostPlatform.native,
              builder: (context, theme, darkTheme) {
                return MaterialApp(
                  theme: theme,
                  darkTheme: darkTheme,
                  themeMode:
                      appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
                  home: kDebugMode
                      ? LaunchpadPage()
                      : StartPage(), // only go to StartPage when releasing
                );
              });
        }));
  }
}

class ThemeModeSegmentedButton extends StatelessWidget {
  const ThemeModeSegmentedButton();

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
