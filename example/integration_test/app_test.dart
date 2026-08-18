import 'package:flutter_design_system_mobile_example/native_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'bottom_sheet_test.dart' as bottom_sheet_test;
import 'dropdown_test.dart' as dropdown_test;
import 'notification_box_test.dart' as notification_box_test;
import 'popover_test.dart' as popover_test;
import 'popup_test.dart' as popup_test;
import 'promotion_box_test.dart' as promotion_box_test;
import 'segmented_button_test.dart' as segmented_button_test;
import 'slide_to_toggle_test.dart' as slide_to_toggle_test;
import 'tab_bar_test.dart' as tab_bar_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('exampleApp_whenLaunched_thenRendersAndShowsTitle', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Design System Mobile'), findsOneWidget);
  });

  bottom_sheet_test.main();
  dropdown_test.main();
  notification_box_test.main();
  popup_test.main();
  popover_test.main();
  promotion_box_test.main();
  tab_bar_test.main();
  segmented_button_test.main();
  slide_to_toggle_test.main();
}
