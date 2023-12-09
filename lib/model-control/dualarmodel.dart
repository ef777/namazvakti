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
  




}

class DuaKont extends GetxController {

 List<DualarModel> dualar = [];
 static Future<String> loaddualar_JsonFromAsset() async {
 // print("dua fetch json başladı");
var a=  await rootBundle.loadString('assets/json/dualar.json');
//print("dua json gelen cevap");
//print("$a");
    return a; 

}

  Future <List <DualarModel>> loaddualar() async {
//print("hadis load başladı");
  String jsonString = await loaddualar_JsonFromAsset();
  final jsonResponse = json.decode(jsonString);
  //print("gelen cevap");
  //print(jsonResponse);
  List<DualarModel> dualar1 = [];
  for (var u in jsonResponse) {
    DualarModel dua = DualarModel.fromJson(u);
    dualar1.add(dua);
  }
  dualar = dualar1;
  return dualar;  

}

// get namaz dua


duagetir (String anlami){
  List<DualarModel> dualar1 = [];
  for (var i = 0; i < dualar.length; i++) {
    if (!dualar1.contains(anlami)) {
      dualar1.add(dualar[i]);
    }
  }
  return dualar1[0];
}

// genel baslıklar getir *ok


Future <List<String>> genelbasliklargetir() async{
 var a = await  ustbasliklargetir();
  return a;
}

List<String> ustbasliklargetir(){
  List<String> ustbasliklar = [];
  for (var i = 0; i < dualar.length; i++) {
    if (!ustbasliklar.contains(dualar[i].genelBaslik)) {
      ustbasliklar.add(dualar[i].genelBaslik);
    }
  }
  
  return ustbasliklar;
}



// genel baslık seç alt baslık getir  *ok

Future <List<String>> altbaslik(String ustbaslik) async{
 var a = await  altbasliklarspesifik(ustbaslik);
  return a;
}

List<String> altbasliklarspesifik(String ustbaslik){
  List<String> altbasliklar = [];
  for (var i = 0; i < dualar.length; i++) {
    if( dualar[i].genelBaslik == ustbaslik) {
        if (!altbasliklar.contains(dualar[i].altBaslik)) {

      altbasliklar.add(dualar[i].altBaslik);
    }}
  }

 
  return altbasliklar;
}


// alt baslık seç dualar getir 
Future <List<DualarModel>> dualarim(String altbaslik) async{
 var a = await  altbasligagoredua(altbaslik);
  return a;
}
List<DualarModel> altbasligagoredua(String altbaslik){
  List<DualarModel> altbasliklar = [];
  for (var i = 0; i < dualar.length; i++) {
    if (dualar[i].altBaslik == altbaslik) {
      altbasliklar.add(dualar[i]);
    }
  }

 
  return altbasliklar;
}







}
