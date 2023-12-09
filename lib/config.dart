import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:namazvakti/home.dart';
import 'package:namazvakti/wellcome.dart';

// yeni maps api AIzaSyD6fDwneuvZwuCwe-kbqZLl6E9qzwVq1s8
class AppConfig extends GetxController {

  static  var bildirim_title = "Namaz Vakti";
  static var bildirim_content = "Namaz Vakti geldi...";
bool getSwitchValue(String d1, String d2) {
  return ezanvaktibildirim[d1]![d2]![0] == "1";
}

void onSwitchChange(bool value, String d1, String d2) {
  ezanvaktibildirim[d1]![d2]![0] = value ? "1" : "0"; 
}
static Map<String, Map<String, RxList<String>>> ezanvaktibildirim = {
  'imsak': { 
    'vaktinde': ['1', 'default', '0:0'].obs,
    'once': ['0', 'default', '0:0'].obs,
    'gunes': ['0', 'default', '0:0'].obs,
  },
  'oglen': {
    'vaktinde': ['1', 'default', '0:0'].obs,
    'once': ['0', 'default', '0:0'].obs,
  },
  'ikindin': {
    'vaktinde': ['1', 'default', '0:0'].obs,
    'once': ['0', 'default', '0:0'].obs,
  },
  'aksam': {
    'vaktinde': ['1', 'default', '0:0'].obs,
    'once': ['0', 'default', '0:0'].obs,
  },
  'yatsi': {
    'vaktinde': ['1', 'default', '0:0'].obs,
    'once': ['0', 'default', '0:0'].obs,
  }
}.obs;


 e_kaydet(Map<String,  Map<String, RxList<String>>> ezanvaktibildirim)async {
 await box.write('ezan', ezanvaktibildirim);
  print("ezanvakti kaydedildi");
 var ezan= await box.read('ezan');
  print("ezanvakti okundu");
  print(ezan.toString());
  
}
Future<  Map<String,  Map<String, RxList<String>>>> e_getir() async {
  var gelen = await box.read('ezan');
  print("ezanvakti hafizadan okundu");
  print(gelen.toString());
  return gelen;
}



static String ulkeid = "2";
static  String ulkename = "2";
static String sehirid = "2";
static String sehirname = "2";
static String ilceid = "2";
static String ilcename = "2";
static int vakitstxt = 0; 
 static var vakitstring= "Vaktin Çıkmasına";

  final box = GetStorage();

ilkgiriskayit() async {

  await box.write('ilgiris', true);

  print("ilgiris kaydedildi");

}

ilkgirismi( ) async {
 await box.read('ilgiris');
  print("ilgiris okundu");
  print(box.read('ilgiris'));
  if (box.read('ilgiris')==null) {
    print("ilk kez giriş yapılıyor");
    return true;
  }
  else{
    print("önceden giriş yapılmış");

    AppConfig.login=true;
    return false; // config test  için true yap
  } 

}


okuid() async {
  String ulkeid = await box.read('ulkeid');
  AppConfig.ulkeid = ulkeid;

  var ulkename = await box.read('ulkename');
  AppConfig.ulkename = ulkename;
  var sehirid = await box.read('sehirid');
  AppConfig.sehirid = sehirid;
  var sehirname = await box.read('sehirname');
  AppConfig.sehirname = sehirname;
  var ilceid = await box.read('ilceid');
  AppConfig.ilceid = ilceid;
  var ilcename = await box.read('ilcename');
  AppConfig.ilcename = ilcename;
  print("okunan idler");
  print(ulkeid);
  print(ulkename);
  print(sehirid);
  print(sehirname);
  print(ilceid);
  print(ilcename);
}

static var col1= Colors.blue ;
static var col2= Colors.blueAccent;
static var login = true;
 static List<bool> isSelected = [true, false, false];
 static int selectedaygunIndex = 1;
  static int selectedEzanvakti = 0;
  static int namazduaindex = 0;
  static int selecteddiniyil = 0;
RxInt selecteddinigun = 0.obs;
static final vakitler = <RxBool>[true.obs, false.obs, false.obs,false.obs,false.obs,false.obs,].obs;

//

 RxInt selectedesmaulhusna = 0.obs;
  RxInt selectedesmaulhusna_player = 0.obs;

  static void vakitDegistir(int index, RxBool value) {
    AppConfig.vakitler[index].value = value.value;
  }
    esmaulhusnaidDegistir(int index) {
    selectedesmaulhusna.value = index;
  }
   esmaulhusna_play_Degistir(int index) {
    selectedesmaulhusna_player.value = index;
  }
// AIzaSyDgCtLy0MA-gbwFH1UJHHB0h7Ljfz8-eI8

}
