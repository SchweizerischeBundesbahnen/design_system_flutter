Start by including the SBBTheme in your app root.

```Dart
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SBB DSM',
      theme: SBBTheme.light(),
      darkTheme: SBBTheme.dark(),
      home: const MyHomePage(),
    );
  }
}
```

You may then use any widgets, colors and fonts available.

```Dart
import 'package:design_system_flutter/design_system_flutter.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SBBHeader('My Home Page'),
      body: Center(
        child: Container(
          color: SBBColors.blue
          width: 100,
          height: 100
        )
      )
    );
  }
}



```