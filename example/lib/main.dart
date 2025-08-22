import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'native_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (BuildContext context) => AppState(),
      child: MyApp(),
    ),
  );
}
