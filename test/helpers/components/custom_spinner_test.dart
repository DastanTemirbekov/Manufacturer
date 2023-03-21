/* External dependencies */
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

/* Local dependencies */
import 'package:test_project/internal/helpers/components/custom_spinner.dart';
import '../wrapper.dart';

void main() {
  group('CustomSpinner', () {
    testWidgets('should find the CupertinoActivityIndicator widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapApp(
          const CustomSpinner(),
        ),
      );

      await tester.pump();

      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    });
  });
}
