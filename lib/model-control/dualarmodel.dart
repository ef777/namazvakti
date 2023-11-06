import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DualarModel {
    String genelBaslik;
    String altBaslik;
    String arapcasi;
    String anlami;
    String soyleyen;

    DualarModel({
        required this.genelBaslik,
        required this.altBaslik,
        required this.arapcasi,
        required this.anlami,
        required this.soyleyen,
    });


   factory DualarModel.fromJson(Map<String, dynamic> json) {
    return DualarModel(
      genelBaslik: json['genel_baslik'],
      altBaslik: json['alt_baslik'],
      arapcasi: json['arapcasi'],
      anlami: json['anlami'],
      soyleyen: json['soyleyen'],
      
    );
  }
  
  // genel başlıklara göre ayırmak 
   static Future<String> loaddualar_JsonFromAsset() async {
  print("dua fetch json başladı");
var a=  await rootBundle.loadString('assets/json/dualar.json');
print("dua json gelen cevap");
print("$a");
    return a; 

}

 static Future <List <DualarModel>> loaddualar() async {
print("hadis load başladı");
  String jsonString = await loaddualar_JsonFromAsset();
  final jsonResponse = json.decode(jsonString);
  print("gelen cevap");
  print(jsonResponse);
  List<DualarModel> dualar = [];
  for (var u in jsonResponse) {
    DualarModel dua = DualarModel.fromJson(u);
    dualar.add(dua);
  }
  DuaKont.dualar = dualar;
  return dualar;  

}




}

class DuaKont extends GetxController {

static List<DualarModel> dualar = [];


// get namaz dua
namazdua(){
var a =istenenbasliktipdua("Namaz");
return a;

}


istenenbasliktipdua(String tip) {
  List<DualarModel> istenendualar = [];
  for (var i = 0; i < dualar.length; i++) {
    if (dualar[i].genelBaslik == tip) {
      istenendualar.add(dualar[i]);
    }
  }
  return istenendualar;
}
istenenaltbasliktipdua(String tip) {
  List<DualarModel> istenendualar = [];
  for (var i = 0; i < dualar.length; i++) {
    if (dualar[i].altBaslik == tip) {
      istenendualar.add(dualar[i]);
    }
  }
  return istenendualar;
}






}
