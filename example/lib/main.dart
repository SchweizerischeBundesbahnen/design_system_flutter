import 'package:flutter_design_system_mobile_example/native_app.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (BuildContext context) => AppState(),
      child: MyApp(),
    ),
  );
}
