// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../web_pages/breadcrumb_page.dart' as _i4;
import '../web_pages/button_page.dart' as _i2;
import '../web_pages/home_page.dart' as _i1;
import '../web_pages/icon_page.dart' as _i3;
import '../web_pages/loading_page.dart' as _i5;
import '../web_pages/logo_page.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          transitionsBuilder: _i7.TransitionsBuilders.noTransition,
          opaque: true,
          barrierDismissible: false);
    },
    ButtonRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.ButtonPage(),
          transitionsBuilder: _i7.TransitionsBuilders.noTransition,
          opaque: true,
          barrierDismissible: false);
    },
    IconRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.IconPage(),
          transitionsBuilder: _i7.TransitionsBuilders.noTransition,
          opaque: true,
          barrierDismissible: false);
    },
    BreadcrumbRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.BreadcrumbPage(),
          transitionsBuilder: _i7.TransitionsBuilders.noTransition,
          opaque: true,
          barrierDismissible: false);
    },
    LoadingRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.LoadingPage(),
          transitionsBuilder: _i7.TransitionsBuilders.noTransition,
          opaque: true,
          barrierDismissible: false);
    },
    LogoRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.LogoPage(),
          transitionsBuilder: _i7.TransitionsBuilders.noTransition,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i7.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i7.RouteConfig('#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'logo',
              fullMatch: true),
          _i7.RouteConfig(ButtonRoute.name,
              path: 'buttons', parent: HomeRoute.name),
          _i7.RouteConfig(IconRoute.name,
              path: 'icons', parent: HomeRoute.name),
          _i7.RouteConfig(BreadcrumbRoute.name,
              path: 'breadcrumb', parent: HomeRoute.name),
          _i7.RouteConfig(LoadingRoute.name,
              path: 'loadingInd', parent: HomeRoute.name),
          _i7.RouteConfig(LogoRoute.name, path: 'logo', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.ButtonPage]
class ButtonRoute extends _i7.PageRouteInfo<void> {
  const ButtonRoute() : super(ButtonRoute.name, path: 'buttons');

  static const String name = 'ButtonRoute';
}

/// generated route for
/// [_i3.IconPage]
class IconRoute extends _i7.PageRouteInfo<void> {
  const IconRoute() : super(IconRoute.name, path: 'icons');

  static const String name = 'IconRoute';
}

/// generated route for
/// [_i4.BreadcrumbPage]
class BreadcrumbRoute extends _i7.PageRouteInfo<void> {
  const BreadcrumbRoute() : super(BreadcrumbRoute.name, path: 'breadcrumb');

  static const String name = 'BreadcrumbRoute';
}

/// generated route for
/// [_i5.LoadingPage]
class LoadingRoute extends _i7.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: 'loadingInd');

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i6.LogoPage]
class LogoRoute extends _i7.PageRouteInfo<void> {
  const LogoRoute() : super(LogoRoute.name, path: 'logo');

  static const String name = 'LogoRoute';
}
