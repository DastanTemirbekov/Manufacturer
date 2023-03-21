/* External dependencies */
import 'dart:developer';
import 'package:dio/dio.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/data/db_helper.dart';
import 'package:test_project/features/manufacturers/data/models/manufacturer_info_model.dart';
import 'package:test_project/features/manufacturers/data/models/manufacturers_model.dart';
import 'package:test_project/features/manufacturers/domain/repositories/manufacturers_repository.dart';
import 'package:test_project/internal/helpers/api_requester.dart';
import 'package:test_project/internal/helpers/catch_exceptions_helper.dart';

class ManufacturersRepositoryImpl implements ManufacturersRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<List<ManufacturersModel>> getAllManufacturers(int page) async {
    List<ManufacturersModel> manufacturersList = [];

    try {
      Response response = await apiRequester.toGet(
        'vehicles/GetAllManufacturers',
        param: {
          'format': 'json',
          'page': page,
        },
      );

      log('manufacturers response === ${response.data}');

      if (response.statusCode == 200) {
        response.data['Results'].forEach((element) async {
          manufacturersList.add(ManufacturersModel.fromJson(element));

          await DBHelper.createManufactures(
              ManufacturersModel.fromJson(element));
        });

        return manufacturersList;
      }

      throw response;
    } catch (e) {
      print('manufacturers error === $e');

      manufacturersList = await DBHelper.readManufacturers();

      if (manufacturersList.isNotEmpty) {
        return manufacturersList;
      } else {
        throw CatchException.convertException(e);
      }
    }
  }

  @override
  Future<List<ManufacturerInfoModel>> getManufacturerInfo(String name) async {
    List<ManufacturerInfoModel> manufacturersInfoList = [];

    try {
      Response response = await apiRequester.toGet(
        'vehicles/getmodelsformake/$name',
        param: {'format': 'json'},
      );

      log('manufacturers info response === ${response.data}');

      if (response.statusCode == 200) {
        response.data['Results'].forEach((element) async {
          manufacturersInfoList.add(ManufacturerInfoModel.fromJson(element));

          await DBHelper.createManufacturesInfo(
              ManufacturerInfoModel.fromJson(element));
        });
      }

      throw response;
    } catch (e) {
      manufacturersInfoList = await DBHelper.readManufacturersInfo();

      if (manufacturersInfoList.isNotEmpty) {
        return manufacturersInfoList;
      } else {
        throw CatchException.convertException(e);
      }
    }
  }
}
