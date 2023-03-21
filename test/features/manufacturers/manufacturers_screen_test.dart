/* External dependencies */
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/presentation/logic/bloc/manufacturers_bloc.dart';
import 'package:test_project/features/manufacturers/presentation/screens/manufacturers_screen.dart';
import 'package:test_project/features/manufacturers/presentation/widgets/manufacturer_card.dart';
import 'package:test_project/internal/helpers/catch_exceptions_helper.dart';
import 'package:test_project/internal/helpers/components/all_shimmers/manufacturers_shimmer.dart';
import 'package:test_project/internal/helpers/components/custom_error_widget.dart';
import '../../helpers/wrapper.dart';
import 'models/manufacturers_model.dart';

void main() {
  ManufacturersBloc blockForTest = MockManufacturersBloc();

  group(
    'ManufacturersScreen',
    () {
      testWidgets(
        'should find the ManufacturersShimmer when state is ManufacturersLoadingState',
        (WidgetTester tester) async {
          when(() => blockForTest.state).thenAnswer(
            (_) => ManufacturersLoadingState(),
          );

          await tester.pumpWidget(
            wrapApp(
              ManufacturersScreen(blocForTest: blockForTest),
            ),
          );

          await tester.pump();

          expect(find.byType(ManufacturersShimmer), findsOneWidget);
        },
      );

      testWidgets(
        'should find the ManufacturerCards when state is data successfully fetched',
        (WidgetTester tester) async {
          when(() => blockForTest.state).thenAnswer((_) =>
              ManufacturersLoadedState(manufacturersList: manufacturersList));

          await tester.pumpWidget(
            wrapApp(
              ManufacturersScreen(
                blocForTest: blockForTest,
                manufacturersListForTest: manufacturersList,
              ),
            ),
          );

          await tester.pump();

          expect(find.byType(ManufacturerCard), findsNWidgets(5));
        },
      );

      testWidgets(
        'should find the CustomErrorWidget when  an error was occured',
        (WidgetTester tester) async {
          when(() => blockForTest.state).thenAnswer(
            (_) => ManufacturersErrorState(
                error: CatchException.convertException(Error())),
          );

          await tester.pumpWidget(
            wrapApp(
              ManufacturersScreen(blocForTest: blockForTest),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(CustomErrorWidget), findsOneWidget);
        },
      );
    },
  );
}
