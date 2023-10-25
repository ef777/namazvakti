//Json verisini modellemek için bir sınıf
import 'dart:convert';

class AyetModel {
  String? gunes;
  String? gunes_h_ayet;
  String? sabah;
  String? sabah_h_ayet;
  String? ogle;
  String? ogle_h_ayet;
  String? ikindi;
  String? ikindi_h_ayet;
  String? aksam;
  String? aksam_h_ayet;
  String? yatsi;
  String? yatsi_h_ayet;

  AyetModel({
    this.gunes,
    this.gunes_h_ayet,
    this.sabah,
    this.sabah_h_ayet,
    this.ogle,
    this.ogle_h_ayet,
    this.ikindi,
    this.ikindi_h_ayet,
    this.aksam,
    this.aksam_h_ayet,
    this.yatsi,
    this.yatsi_h_ayet
  });

  factory AyetModel.fromJson(Map<String, dynamic> json) {
    return AyetModel(
      gunes: json['gunes'],
      gunes_h_ayet: json['gunes_h_ayet'],
      sabah: json['sabah'],
      sabah_h_ayet: json['sabah_h_ayet'],
      ogle: json['ogle'],
      ogle_h_ayet: json['ogle_h_ayet'],
      ikindi: json['ikindi'],
      ikindi_h_ayet: json['ikindi_h_ayet'],
      aksam: json['aksam'],
      aksam_h_ayet: json['aksam_h_ayet'],
      yatsi: json['yatsi'],
      yatsi_h_ayet: json['yatsi_h_ayet'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gunes'] = gunes;
    data['gunes_h_ayet'] = gunes_h_ayet;
    data['sabah'] = sabah;
    data['sabah_h_ayet'] = sabah_h_ayet;
    data['ogle'] = ogle;
    data['ogle_h_ayet'] = ogle_h_ayet;
    data['ikindi'] = ikindi;
    data['ikindi_h_ayet'] = ikindi_h_ayet;
    data['aksam'] = aksam;
    data['aksam_h_ayet'] = aksam_h_ayet;
    data['yatsi'] = yatsi;
    data['yatsi_h_ayet'] = yatsi_h_ayet;
    return data;
  }
}

//Json array'ini model listesine çevirme
List<AyetModel> namazListFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<AyetModel>.from(data.map((item) => AyetModel.fromJson(item)));
}

//Id'ye göre model getirme
AyetModel getById(List<AyetModel> list, int id) {
 // return list.firstWhere((element) => element.id == id); 
  return list[id];
}

//Encode json 
String modelToJson(AyetModel data) {
  return json.encode(data.toJson());
}