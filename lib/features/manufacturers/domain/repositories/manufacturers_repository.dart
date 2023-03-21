/* Local dependencies */
import 'package:test_project/features/manufacturers/data/models/manufacturer_info_model.dart';
import 'package:test_project/features/manufacturers/data/models/manufacturers_model.dart';

abstract class ManufacturersRepository {
  Future<List<ManufacturersModel>> getAllManufacturers(int page);
  Future<List<ManufacturerInfoModel>> getManufacturerInfo(String name);
}
