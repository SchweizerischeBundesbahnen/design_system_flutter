import 'package:auto_route/auto_route.dart';
import '../web_pages/breadcrumb_page.dart';

import '../web_pages/button_page.dart';
import '../web_pages/icon_page.dart';
import '../web_pages/loading_page.dart';
import '../web_pages/logo_page.dart';
import '../web_pages/home_page.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        page: HomePage,
        initial: true,
        path: '/home',
        children: <AutoRoute>[
          AutoRoute(page: ButtonPage, path: 'buttons'),
          AutoRoute(page: IconPage, path: 'icons'),
          AutoRoute(page: BreadcrumbPage, path: 'breadcrumb'),
          AutoRoute(page: LoadingPage, path: 'loadingInd'),
          AutoRoute(page: LogoPage, path: 'logo', initial: true),
        ])
  ],
  transitionsBuilder: TransitionsBuilders.noTransition,
)
class $AppRouter {}
