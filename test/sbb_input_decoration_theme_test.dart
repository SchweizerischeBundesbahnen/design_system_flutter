import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

/// Golden tests for theme-wide customisation of input decorations.
///
/// The themed values are deliberately exaggerated so that a regression of the
/// theme resolution is visible in the golden.
void main() {
  const themedPadding = EdgeInsets.symmetric(horizontal: SBBSpacing.xLarge);
  const overridePadding = EdgeInsets.symmetric(horizontal: SBBSpacing.xxSmall);

  testWidgets('input_decoration_theme_boxed', (WidgetTester tester) async {
    const inputDecorationTheme = SBBInputDecorationThemeData(contentPadding: themedPadding);
    const overrideDecoration = SBBInputDecoration(labelText: 'Component padding', contentPadding: overridePadding);
    const themedDecoration = SBBInputDecoration(labelText: 'Themed padding');

    final widget = Padding(
      padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.xSmall,
        mainAxisSize: .min,
        children: [
          SBBTextInputBoxed(
            decoration: themedDecoration,
            controller: TextEditingController(text: 'Text input'),
          ),
          SBBTextInputBoxed(
            decoration: overrideDecoration,
            controller: TextEditingController(text: 'Text input'),
          ),
          const SBBDecoratedBoxed(decoration: themedDecoration, child: Text('Decorated')),
          const SBBDecoratedBoxed(decoration: overrideDecoration, child: Text('Decorated')),
          const SBBDecoratedTextBoxed(decoration: themedDecoration, value: 'Decorated text'),
          const SBBDecoratedTextBoxed(decoration: overrideDecoration, value: 'Decorated text'),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'input_decoration_theme_boxed',
      find.byType(Column).first,
      wrap: (w) => _ThemedTestApp(inputDecorationTheme: inputDecorationTheme, child: w),
    );
  });

  testWidgets('picker_theme_inputs', (WidgetTester tester) async {
    const pickerTheme = SBBPickerThemeData(
      triggerDecorationTheme: SBBInputDecorationThemeData(contentPadding: themedPadding),
      triggerStyle: SBBDecoratedTextStyle(
        valueTextStyle: TextStyle(fontSize: 24.0, height: 1.0, fontStyle: .italic),
        valueForegroundColor: WidgetStatePropertyAll(SBBColors.violet),
      ),
      sheetStyle: SBBBottomSheetStyle(backgroundColor: SBBColors.peach),
    );
    final date = DateTime(2024, 1, 1, 12, 30);
    const time = TimeOfDay(hour: 12, minute: 30);
    const overrideDecoration = SBBInputDecoration(labelText: 'Component padding', contentPadding: overridePadding);
    const themedDecoration = SBBInputDecoration(labelText: 'Themed padding');

    final widget = Padding(
      padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.xSmall,
        mainAxisSize: .min,
        children: [
          SBBDateInput(value: date, triggerDecoration: themedDecoration, onDateChanged: (_) {}),
          SBBDateInput(value: date, triggerDecoration: overrideDecoration, onDateChanged: (_) {}),
          SBBTimeInput(value: time, triggerDecoration: themedDecoration, onTimeChanged: (_) {}),
          SBBDateTimeInput(value: date, triggerDecoration: themedDecoration, onDateTimeChanged: (_) {}),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'picker_theme_inputs',
      find.byType(Column).first,
      wrap: (w) => _ThemedTestApp(pickerTheme: pickerTheme, child: w),
    );

    await tester.tap(find.byType(SBBTimeInput));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'picker_theme_sheet',
      find.byType(MaterialApp),
      wrap: (w) => _ThemedTestApp(pickerTheme: pickerTheme, child: w),
    );
  });
}

/// Like [TestApp], but with custom SBB theme data applied to both brightnesses.
class _ThemedTestApp extends StatelessWidget {
  const _ThemedTestApp({required this.child, this.inputDecorationTheme, this.pickerTheme});

  final Widget child;
  final SBBInputDecorationThemeData? inputDecorationTheme;
  final SBBPickerThemeData? pickerTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SBBTheme.light(inputDecorationTheme: inputDecorationTheme, pickerTheme: pickerTheme),
      darkTheme: SBBTheme.dark(inputDecorationTheme: inputDecorationTheme, pickerTheme: pickerTheme),
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      builder: (_, navigator) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: navigator!,
      ),
      home: Scaffold(body: child),
    );
  }
}
