import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import 'webnav/nav.dart';

class WebApp extends StatelessWidget {
  WebApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return SBBTheme(
      builder: (context, theme, darkTheme) {
        return MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          theme: theme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
