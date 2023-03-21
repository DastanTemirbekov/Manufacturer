/* Local dependencies */
import 'package:test_project/features/manufacturers/data/models/manufacturer_info_model.dart';
import 'package:test_project/features/manufacturers/data/models/manufacturers_model.dart';
import 'package:test_project/features/manufacturers/data/repositories/manufacturers_repository_impl.dart';

class ManufacturersUseCase {
  final ManufacturersRepositoryImpl manufacturersRepository;

  ManufacturersUseCase(this.manufacturersRepository);

  Future<List<ManufacturersModel>> getAllManufacturers(int page) async =>
      await manufacturersRepository.getAllManufacturers(page);

  Future<List<ManufacturerInfoModel>> getManufacturerInfo(String name) async =>
      await manufacturersRepository.getManufacturerInfo(name);
}
