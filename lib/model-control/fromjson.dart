import 'package:flutter/services.dart';
import 'package:namazvakti/model-control/ayetlermodel.dart';

Future<List<AyetModel>> readJsonFromFile(String getfile) async {

  // Dosya yolunu belirle
 String jsonFile="";
if (getfile == "namazlar") {

  String jsonFile = "assets/namazlar.json"; 
  
} else if (getfile == "ayetler") {

  String jsonFile = "assets/ayetler.json";

} else if (getfile == "sureler") {

  String jsonFile = "assets/sureler.json";

} else if (getfile == "dua") {
  String jsonFile = "assets/dua.json";
}

  // Dosyadan veriyi oku
  String jsonData = await rootBundle.loadString(jsonFile);
  
  // Json'u model listesine çevir
  List<AyetModel> namazList = namazListFromJson(jsonData);
  
  return namazList;

} 