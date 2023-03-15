import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'native_app.dart';
import 'web_app.dart';

void main() {
  runApp(kIsWeb
    ? WebApp()
    : ChangeNotifierProvider<AppState>(
        create: (BuildContext context) => AppState(), child: MyApp()));
}
