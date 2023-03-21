/* External dependencies */
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/data/repositories/manufacturers_repository_impl.dart';
import 'package:test_project/features/manufacturers/domain/use_cases/manufacturers_use_case.dart';
import 'package:test_project/features/manufacturers/presentation/logic/bloc/manufacturers_bloc.dart';
import 'package:test_project/internal/helpers/catch_exceptions_helper.dart';
import '../models/manufacturers_model.dart';
import '../models/manufacturer_info_model.dart';
import '../../../helpers/wrapper.dart';

void main() {
  ManufacturersRepositoryImpl manufacturerRepository =
      MockManufacturersRepositoryImpl();
  group(
    'ManufactureBloc on GetAllManufacturersEvent',
    () {
      blocTest<ManufacturersBloc, ManufacturersState>(
        'emits ManufacturersLoadedState when data successfully fetched with shimmer when it is first call',
        build: () =>
            ManufacturersBloc(ManufacturersUseCase(manufacturerRepository)),
        act: (bloc) {
          when(() => manufacturerRepository.getAllManufacturers(1))
              .thenAnswer((_) => Future.value(manufacturersList));
          bloc.add(GetAllManufacturersEvent(
            page: 1,
            isFirstCall: true,
          ));
        },
        expect: () => [
          ManufacturersLoadingState(),
          ManufacturersLoadedState(manufacturersList: manufacturersList)
        ],
      );

      blocTest<ManufacturersBloc, ManufacturersState>(
        'emits ManufacturesFetchedState when data successfully fetched without shimmer when it is not first call (check for pagination)',
        build: () =>
            ManufacturersBloc(ManufacturersUseCase(manufacturerRepository)),
        act: (bloc) {
          when(() => manufacturerRepository.getAllManufacturers(2))
              .thenAnswer((_) => Future.value(manufacturersList));
          bloc.add(GetAllManufacturersEvent(page: 2));
        },
        expect: () => [
          ManufacturersLoadedState(manufacturersList: manufacturersList),
        ],
      );

      blocTest<ManufacturersBloc, ManufacturersState>(
        'emits ManufacturersErrorState when an error was occured with shimmer when it is first call',
        build: () =>
            ManufacturersBloc(ManufacturersUseCase(manufacturerRepository)),
        act: (bloc) {
          when(() => manufacturerRepository.getAllManufacturers(1))
              .thenThrow((_) => Error());
          bloc.add(
            GetAllManufacturersEvent(
              page: 1,
              isFirstCall: true,
            ),
          );
        },
        expect: () => [
          ManufacturersLoadingState(),
          ManufacturersErrorState(
            error: CatchException.convertException(Error()),
          ),
        ],
      );

      blocTest<ManufacturersBloc, ManufacturersState>(
        'emits ManufacturersErrorState when an error was occured without shimmer when it is not first call (check for pagination)',
        build: () =>
            ManufacturersBloc(ManufacturersUseCase(manufacturerRepository)),
        act: (bloc) {
          when(() => manufacturerRepository.getAllManufacturers(1))
              .thenThrow((_) => Error());
          bloc.add(
            GetAllManufacturersEvent(page: 1),
          );
        },
        expect: () => [
          ManufacturersErrorState(
            error: CatchException.convertException(Error()),
          ),
        ],
      );
    },
  );

  group(
    'ManufactureBloc on GetManufacturerInfoEvent',
    () {
      blocTest<ManufacturersBloc, ManufacturersState>(
        'emits ManufacturerInfoLoadedState when when data successfully fetched ',
        build: () =>
            ManufacturersBloc(ManufacturersUseCase(manufacturerRepository)),
        act: (bloc) {
          when(() => manufacturerRepository.getManufacturerInfo('honda'))
              .thenAnswer((_) => Future.value(manufacturerInfoModel));
          bloc.add(GetManufacturerInfoEvent(name: 'honda'));
        },
        expect: () => [
          ManufacturersLoadingState(),
          ManufacturerInfoLoadedState(
              manufacturerInfoModel: manufacturerInfoModel)
        ],
      );

      blocTest<ManufacturersBloc, ManufacturersState>(
        'emits ManufacturersErrorState when an error was occured',
        build: () =>
            ManufacturersBloc(ManufacturersUseCase(manufacturerRepository)),
        act: (bloc) {
          when(() => manufacturerRepository.getManufacturerInfo('honda'))
              .thenThrow((_) => Error());
          bloc.add(GetManufacturerInfoEvent(name: 'honda'));
        },
        expect: () => [
          ManufacturersLoadingState(),
          ManufacturersErrorState(
            error: CatchException.convertException(Error()),
          ),
        ],
      );
    },
  );
}
