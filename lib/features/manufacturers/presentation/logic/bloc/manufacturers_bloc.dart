/* External dependencies */
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/data/models/manufacturer_info_model.dart';
import 'package:test_project/features/manufacturers/data/models/manufacturers_model.dart';
import 'package:test_project/features/manufacturers/domain/use_cases/manufacturers_use_case.dart';
import 'package:test_project/internal/helpers/catch_exceptions_helper.dart';

part 'manufacturers_event.dart';
part 'manufacturers_state.dart';

class ManufacturersBloc extends Bloc<ManufacturersEvent, ManufacturersState> {
  final ManufacturersUseCase useCase;

  ManufacturersBloc(this.useCase) : super(ManufacturersInitial()) {
    on<GetAllManufacturersEvent>((event, emit) async {
      if (event.isFirstCall) {
        emit(ManufacturersLoadingState());
      }

      await useCase
          .getAllManufacturers(event.page)
          .then(
            (manufacturersList) => emit(
              ManufacturersLoadedState(manufacturersList: manufacturersList),
            ),
          )
          .onError(
            (error, stackTrace) => emit(
              ManufacturersErrorState(
                error: CatchException.convertException(error),
              ),
            ),
          );
    });

    on<GetManufacturerInfoEvent>((event, emit) async {
      emit(ManufacturersLoadingState());

      await useCase
          .getManufacturerInfo(event.name)
          .then(
            (manufacturerInfoModel) => emit(
              ManufacturerInfoLoadedState(
                  manufacturerInfoModel: manufacturerInfoModel),
            ),
          )
          .onError(
            (error, stackTrace) => emit(
              ManufacturersErrorState(
                error: CatchException.convertException(error),
              ),
            ),
          );
    });
  }
}
