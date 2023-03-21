/* External dependencies */
import 'package:flutter_test/flutter_test.dart';

/* Local dependencies */
import 'package:test_project/internal/helpers/components/all_shimmers/manufacturers_shimmer.dart';
import 'package:test_project/internal/helpers/components/all_shimmers/shimmer_widget.dart';
import '../../wrapper.dart';

void main() {
  group('ManufacturersShimmer', () {
    testWidgets('should find the ShimmerWidget widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapApp(
          const ManufacturersShimmer(),
        ),
      );

      await tester.pump();

      expect(find.byType(ShimmerWidget), findsOneWidget);
    });
  });
}
