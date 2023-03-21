/* External dependencies */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/presentation/screens/manufacturers_info_screen.dart';
import 'package:test_project/features/manufacturers/presentation/screens/manufacturers_screen.dart';
import 'package:test_project/main.dart' as app;

void main() {
  group('Integration test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Manufacturer test', (WidgetTester tester) async {
      await app.main();

      // should show ManufacturersScreen when user run the app
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 5));
      expect(find.byType(ManufacturersScreen), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));

      // should check if the page is scrollable
      var manufactureListView = find.byKey(const Key('manufactureListView'));
      await tester.drag(manufactureListView, const Offset(0.0, -600));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // should go to the ManufacturerInfoScreen when user clicked on card
      await tester.tap(find.byKey(const Key('10')));
      await tester.pumpAndSettle();

      expect(find.byType(ManufacturerInfoScreen), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));

      // should check if the page is scrollable
      var manufactureInfoListView =
          find.byKey(const Key('manufactureInfoListView'));
      await tester.drag(manufactureInfoListView, const Offset(0.0, -600));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // should go to the previous page when user clicked 'arrowBack' button
      await tester.tap(find.byKey(const Key('arrowBack')));
      await tester.pumpAndSettle();
    });
  });
}
