import 'dart:convert';

class ManufacturerInfoModel {
  String? modelName;

  ManufacturerInfoModel({this.modelName});

  factory ManufacturerInfoModel.fromRawJson(String str) =>
      ManufacturerInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ManufacturerInfoModel.fromJson(Map<String, dynamic> json) =>
      ManufacturerInfoModel(modelName: json["Model_Name"]);

  Map<String, dynamic> toJson() => {"Model_Name": modelName};

  @override
  String toString() {
    return "modelName: $modelName";
  }
}
