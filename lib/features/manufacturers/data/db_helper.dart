/* External dependencies */
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/data/models/manufacturer_info_model.dart';
import 'package:test_project/features/manufacturers/data/models/manufacturers_model.dart';

class DBHelper {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'manufacturers.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    const sql = '''CREATE TABLE manufacturers(
      Mfr_ID INTEGER PRIMARY KEY,
      Country TEXT,
      Mfr_Name TEXT
    )
    ''';

    await db.execute(sql);
  }

  static Future<int> createManufactures(ManufacturersModel manufacturer) async {
    Database db = await DBHelper.initDB();

    return await db.insert(
      'manufacturers',
      manufacturer.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ManufacturersModel>> readManufacturers() async {
    Database db = await DBHelper.initDB();
    var manufacturer = await db.query('manufacturers', orderBy: 'Mfr_ID');

    List<ManufacturersModel> manufacturersList = manufacturer.isNotEmpty
        ? manufacturer
            .map((details) => ManufacturersModel.fromJson(details))
            .toList()
        : [];

    return manufacturersList;
  }

  // For Detail
  static Future<Database> initDBInfo() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'manufacturersInfo.db');

    return await openDatabase(path, version: 1, onCreate: _onCreateInfo);
  }

  static Future _onCreateInfo(Database db, int version) async {
    const sql = '''CREATE TABLE manufacturersInfo(
      Model_Name TEXT
    )
    ''';

    await db.execute(sql);
  }

  static Future<int> createManufacturesInfo(
      ManufacturerInfoModel manufacturerInfo) async {
    Database db = await DBHelper.initDBInfo();

    return await db.insert(
      'manufacturersInfo',
      manufacturerInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ManufacturerInfoModel>> readManufacturersInfo() async {
    Database db = await DBHelper.initDBInfo();

    var manufacturerInfo = await db.query(
      'manufacturersInfo',
      orderBy: 'Model_Name',
    );

    List<ManufacturerInfoModel> manufacturersInfoList =
        manufacturerInfo.isNotEmpty
            ? manufacturerInfo
                .map((details) => ManufacturerInfoModel.fromJson(details))
                .toList()
            : [];

    return manufacturersInfoList;
  }
}
