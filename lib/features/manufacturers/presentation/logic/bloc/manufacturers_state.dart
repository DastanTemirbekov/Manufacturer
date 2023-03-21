part of 'manufacturers_bloc.dart';

@immutable
abstract class ManufacturersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ManufacturersInitial extends ManufacturersState {}

class ManufacturersLoadingState extends ManufacturersState {}

class ManufacturersLoadedState extends ManufacturersState {
  final List<ManufacturersModel> manufacturersList;

  ManufacturersLoadedState({required this.manufacturersList});

  @override
  List<Object?> get props => [manufacturersList];
}

class ManufacturersErrorState extends ManufacturersState {
  final CatchException error;

  ManufacturersErrorState({required this.error});
}

class ManufacturerInfoLoadedState extends ManufacturersState {
  final List<ManufacturerInfoModel> manufacturerInfoModel;

  ManufacturerInfoLoadedState({required this.manufacturerInfoModel});

  @override
  List<Object?> get props => [manufacturerInfoModel];
}
