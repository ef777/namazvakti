import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// yeni maps api AIzaSyD6fDwneuvZwuCwe-kbqZLl6E9qzwVq1s8
class AppConfig extends GetxController {
static var col1= Colors.blue ;
static var col2= Colors.blueAccent;
static var login = false;
 static List<bool> isSelected = [true, false, false];
 static int selectedaygunIndex = 1;
  static int selectedEzanvakti = 0;
  static int namazduaindex = 0;
  static int selecteddiniyil = 0;
RxInt selecteddinigun = 0.obs;
static final vakitler = <RxBool>[true.obs, false.obs, false.obs,false.obs,false.obs,false.obs,].obs;
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
