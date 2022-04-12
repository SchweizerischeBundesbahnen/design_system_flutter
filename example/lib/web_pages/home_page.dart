import 'package:auto_route/auto_route.dart';
import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:example/web_pages/button_page.dart';
import 'package:flutter/material.dart';

import '../webnav/nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SBBWebHeader(
          title: 'Example Web App',
          subtitle: 'Version 0.1',
          userMenu: _exampleUserMenu,
        ),
        body: SBBSideBar(
          body: AutoRouter(),
          items: [
            SBBSidebarItem(
              title: 'Buttons',
              onTap: () {
                context.router.replace(ButtonRoute());
              },
              isSelected: false,
            ),
            SBBSidebarItem(
              title: 'Icons',
              onTap: () {
                context.router.replace(IconRoute());
              },
              isSelected: false,
            ),
            SBBSidebarItem(
              title: 'Breadcrumb',
              onTap: () {
                context.router.replace(BreadcrumbRoute());
              },
              isSelected: false,
            ),
            SBBSidebarItem(
              title: 'Loading Indicator',
              onTap: () {
                context.router.replace(LoadingRoute());
              },
              isSelected: false,
            ),
          ],
        ));
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
