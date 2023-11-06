import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class IsimModeli {
  String? kizIsmi;
  String? kizIsmiManasi;
  String? erkekIsmi;
  String? erkekIsmiManasi;

  IsimModeli({
    this.kizIsmi,
    this.kizIsmiManasi,
    this.erkekIsmi,
    this.erkekIsmiManasi
  });

  factory IsimModeli.fromJson(Map<String, dynamic> json) {
    return IsimModeli(
      kizIsmi: json['kiz_ismi'],
      kizIsmiManasi: json['kiz_ismi_manasi'],
      erkekIsmi: json['erkek_ismi'],
      erkekIsmiManasi: json['erkek_ismi_manasi']
    );
  }
 static Future<String> loadisimler_JsonFromAsset() async {
  print("isim fetch json başladı");
var a=  await rootBundle.loadString('assets/json/kiz_erkek_json.json');
print("isimden json gelen cevap");
    return a; 
}
 static Future <List <IsimModeli>> loadisimler() async {
print("hadis load başladı");
  String jsonString = await loadisimler_JsonFromAsset();
  final jsonResponse = json.decode(jsonString);
  print("gelen cevap");
  print(jsonResponse);
  List<IsimModeli> isimler = [];
  for (var u in jsonResponse) {
    IsimModeli isim = IsimModeli.fromJson(u);
    isimler.add(isim);
  }
  IsimKont.isimler = isimler;
  return isimler;  

}



}

class IsimKont extends GetxController {

static List<IsimModeli> isimler = [];
static var seciliisimler = <Rx<IsimModeli>>[].obs;


isimbelirle(){
seciliisimler.clear();
 var random = new Random();
var rastgeleIndex = random.nextInt(isimler.length);
 seciliisimler.add( isimler[rastgeleIndex].obs);

return [seciliisimler[0].value.kizIsmi.toString(), seciliisimler[0].value.kizIsmiManasi.toString(), seciliisimler[0].value.erkekIsmi.toString(), seciliisimler[0].value.erkekIsmiManasi.toString()];
}



}