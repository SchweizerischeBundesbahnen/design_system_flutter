import 'package:flutter_design_system_mobile_example/native_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'bottom_sheet_test.dart' as bottom_sheet_test;
import 'date_picker_test.dart' as date_picker_test;
import 'date_time_picker_test.dart' as date_time_picker_test;
import 'popover_test.dart' as popover_test;
import 'popup_test.dart' as popup_test;
import 'slide_to_toggle_test.dart' as slide_to_toggle_test;
import 'slider_test.dart' as slider_test;
import 'time_picker_test.dart' as time_picker_test;
import 'toast_test.dart' as toast_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('exampleApp_whenLaunched_thenRendersAndShowsTitle', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Design System Mobile'), findsOneWidget);
  });

  bottom_sheet_test.main();
  date_picker_test.main();
  date_time_picker_test.main();
  popup_test.main();
  popover_test.main();
  slide_to_toggle_test.main();
  slider_test.main();
  time_picker_test.main();
  toast_test.main();
}
