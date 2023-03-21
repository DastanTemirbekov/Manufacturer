import 'dart:convert';

class ManufacturersModel {
  String country;
  int mfrId;
  String mfrName;

  ManufacturersModel({
    required this.country,
    required this.mfrId,
    required this.mfrName,
  });

  factory ManufacturersModel.fromRawJson(String str) =>
      ManufacturersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ManufacturersModel.fromJson(Map<String, dynamic> json) =>
      ManufacturersModel(
        country: json["Country"],
        mfrId: json["Mfr_ID"],
        mfrName: json["Mfr_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "Mfr_ID": mfrId,
        "Mfr_Name": mfrName,
      };

  @override
  String toString() {
    return "Country: $country, Mfr_ID: $mfrId, Mfr_Name: $mfrName ";
  }
}
