import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class IlmihalBilgi {
  String? baslik;
  String? konu;

  IlmihalBilgi({this.baslik, this.konu});

  factory IlmihalBilgi.fromJson(Map<String, dynamic> json) {
    return IlmihalBilgi(
      baslik: json['baslik'],
      konu: json['konu'],
    );
  }

static Future<String> loadilmihal_JsonFromAsset() async {
var a=  await rootBundle.loadString('assets/json/ilmihaller_json.json');
    return a; 

}

static Future <List <IlmihalBilgi>> loadAyetler() async {
  String jsonString = await loadilmihal_JsonFromAsset();
  final jsonResponse = json.decode(jsonString);
  print(jsonResponse);
  List<IlmihalBilgi> ilmihaller = [];
  for (var u in jsonResponse) {
    IlmihalBilgi ilmihal = IlmihalBilgi.fromJson(u);
    ilmihaller.add(ilmihal);
  }   IlmihalKont.ilmihaller = ilmihaller;
  return [ilmihaller[0]];

}
}

class IlmihalKont extends GetxController {

static List<IlmihalBilgi> ilmihaller = [];
static var seciliilmihal = <Rx<IlmihalBilgi>>[].obs;


imihalbelirle(){
seciliilmihal.clear();
 var random = new Random();
var rastgeleIndex = random.nextInt(ilmihaller.length);
 seciliilmihal.add( ilmihaller[rastgeleIndex].obs);
return [seciliilmihal[0].value.baslik.toString(), seciliilmihal[0].value.konu.toString()];
}

 


}
