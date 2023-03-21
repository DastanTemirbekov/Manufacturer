/* External dependencies */
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/presentation/logic/bloc/manufacturers_bloc.dart';
import 'package:test_project/features/manufacturers/presentation/screens/manufacturers_info_screen.dart';
import 'package:test_project/features/manufacturers/presentation/widgets/manufacturer_info_card.dart';
import 'package:test_project/internal/helpers/catch_exceptions_helper.dart';
import 'package:test_project/internal/helpers/components/all_shimmers/manufacturer_info_shimmer.dart';
import 'package:test_project/internal/helpers/components/custom_error_widget.dart';
import 'models/manufacturer_info_model.dart';
import '../../helpers/wrapper.dart';

void main() {
  ManufacturersBloc blockForTest = MockManufacturersBloc();

  group(
    'ManufacturerInfoScreen',
    () {
      testWidgets(
        'should find the ManufacturerInfoShimmer when state is ManufacturersLoadingState',
        (WidgetTester tester) async {
          when(() => blockForTest.state).thenAnswer(
            (_) => ManufacturersLoadingState(),
          );

          await tester.pumpWidget(
            wrapApp(
              ManufacturerInfoScreen(
                blocForTest: blockForTest,
                name: 'honda',
              ),
            ),
          );

          await tester.pump();

          expect(find.byType(ManufacturerInfoShimmer), findsOneWidget);
        },
      );

      testWidgets(
        'should find the ManufacturerInfoCard when state is data successfully fetched',
        (WidgetTester tester) async {
          when(() => blockForTest.state).thenAnswer(
            (_) => ManufacturerInfoLoadedState(
                manufacturerInfoModel: manufacturerInfoModel),
          );

          await tester.pumpWidget(
            wrapApp(
              ManufacturerInfoScreen(
                name: 'honda',
                blocForTest: blockForTest,
                manufacturersListForTest: manufacturerInfoModel,
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(ManufacturerInfoCard), findsNWidgets(7));
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
              ManufacturerInfoScreen(
                name: 'honda',
                blocForTest: blockForTest,
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(CustomErrorWidget), findsOneWidget);
        },
      );
    },
  );
}
