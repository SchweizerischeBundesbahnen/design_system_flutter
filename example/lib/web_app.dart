import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import 'web_pages/web_pages.dart';

final _pages = {
  'Logo': LogoPage(),
  'Buttons': ButtonPage(),
  'Icons': IconPage(),
  'Breadcrumb': BreadcrumbPage(),
  'Loading Indicator': LoadingPage(),
  'Select (Dropdown)': SelectPage(),
  'Typographie': TypographyPage(),
  'Checkbox': CheckboxPage(),
  'Link': LinkPage(),
  'Notification': NotificationPage()
};

String _nameToRoute(String name) =>
    '/${name.toLowerCase().replaceAll(' ', '-')}';

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SBBTheme(
      hostType: HostPlatform.web,
      builder: (context, theme, darkTheme) {
        return MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          initialRoute: _nameToRoute(_pages.keys.first),
          onGenerateRoute: (settings) => PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) {
              for (final pageName in _pages.keys) {
                if (_nameToRoute(pageName) == settings.name) {
                  return _sidePanelPageByName(pageName);
                }
              }
              return _sidePanelPageByName(_pages.keys.first);
            },
          ),
        );
      },
    );
  }
}

Widget _sidePanelPageByName(String name) {
  return _SidePanelPage(
    name: name,
    page: _pages[name]!,
  );
}

class _SidePanelPage extends StatelessWidget {
  const _SidePanelPage({
    Key? key,
    required this.name,
    required this.page,
  }) : super(key: key);

  final String name;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SBBWebHeader(
        title: 'Example Web App',
        subtitle: 'Version 0.1',
        userMenu: _exampleUserMenu,
        navItems: [
          SBBWebHeaderNavItem(
              title: 'Example Widgets', onTap: () {}, selected: true),
          SBBWebHeaderNavItem(title: 'Navigation 2', onTap: () {}),
          SBBWebHeaderNavItem(title: 'Navigation 3', onTap: () {}),
          SBBWebHeaderNavItem(title: 'Navigation 4', onTap: () {}),
        ],
      ),
      body: SBBSidebar(
        body: page,
        items: _pages.keys
            .map((name) => _buildSidebarItem(context, name))
            .toList(),
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context, String name) {
    final route = _nameToRoute(name);
    return SBBSidebarItem(
      title: name,
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      isSelected: ModalRoute.of(context)?.settings.name == route,
    );
  }
}

final SBBUserMenu _exampleUserMenu = SBBUserMenu(
  displayName: "Eisen Bahner",
  itemBuilder: (BuildContext context) => <SBBMenuEntry>[
    SBBMenuItem.tile(
      icon: SBBIcons.user_medium,
      title: 'Benutzer',
    ),
    SBBMenuItem.tile(
      icon: SBBIcons.app_icon_medium,
      title: 'Über',
    ),
    SBBMenuItem.tile(
      icon: SBBIcons.gears_medium,
      title: 'Einstellungen',
    ),
    SBBMenuDivider(),
    SBBMenuItem.tile(
      icon: SBBIcons.exit_medium,
      title: 'Logout',
    ),
  ],
  onLoginRequest: () {
    print('Login!');
  },
);
