/* External dependencies */
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/* Local dependencies */
import 'package:test_project/internal/helpers/components/custom_error_widget.dart';
import '../wrapper.dart';

void main() {
  group('CustomErrorWidget', () {
    testWidgets('should find the CustomErrorWidget widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapApp(
          const Material(
            child: CustomErrorWidget(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });
  });
}
