part of 'manufacturers_bloc.dart';

@immutable
abstract class ManufacturersEvent {}

class GetAllManufacturersEvent extends ManufacturersEvent {
  final int page;
  final bool isFirstCall;

  GetAllManufacturersEvent({
    required this.page,
    this.isFirstCall = false,
  });
}

class GetManufacturerInfoEvent extends ManufacturersEvent {
  final String name;

  GetManufacturerInfoEvent({required this.name});
}
