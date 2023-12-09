//Json verisini modellemek için bir sınıf
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

 

//Json array'ini model listesine çevirme
/*List<AyetModel> namazListFromJson(String jsonData) {
  return List<AyetModel>.from(data.map((item) => AyetModel.fromJson(item)));
} */
 static Future<String> loadayetler_JsonFromAsset() async {
 // print("ayet fetch json başladı");
var a=  await rootBundle.loadString('assets/json/ayetler_json.json');
//print("ayetten json gelen cevap");
    return a; 

}

 static Future <List <AyetModel>> loadAyetler() async {
  String jsonString = await loadayetler_JsonFromAsset();
  final jsonResponse = json.decode(jsonString);
  List<AyetModel> ayetler = [];
  for (var u in jsonResponse) {
    AyetModel ayet = AyetModel.fromJson(u);
    ayetler.add(ayet);
  }
  AyetKont.ayetler = ayetler;
  return ayetler;  

}



}

class AyetKont extends GetxController {

static List<AyetModel> ayetler = [];
static var seciliayet = <Rx<AyetModel>>[].obs;


ayetbelirle(){
seciliayet.clear();
 var random = new Random();
var rastgeleIndex = random.nextInt(ayetler.length);
 seciliayet.add( ayetler[rastgeleIndex].obs);
return seciliayet;
}

ayetvakit(String tip,)async{
RxList<Rx<AyetModel>> ayet = await ayetbelirle();
if(  tip == "1"){
   var aciklama= ayet[0].value.gunes.toString();
    var kimden = ayet[0].value.sabah_h_ayet.toString();

   return [ aciklama , kimden];
   
   }

    else if(  tip == "2"){
    var aciklama= ayet[0].value.sabah.toString();
    var kimden = ayet[0].value.sabah_h_ayet.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "3"){
    var aciklama= ayet[0].value.ogle.toString();
    var kimden = ayet[0].value.ogle_h_ayet.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "4"){

    var aciklama= ayet[0].value.ikindi.toString();
    var kimden = ayet[0].value.ikindi_h_ayet.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "5"){
    var aciklama= ayet[0].value.aksam.toString();
    var kimden = ayet[0].value.aksam_h_ayet.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "6"){
    var aciklama= ayet[0].value.yatsi.toString();
    var kimden = ayet[0].value.yatsi_h_ayet.toString();
    return [ aciklama , kimden];
    }
    else if(  tip == "0"){
   var aciklama= ayet[0].value.gunes.toString();
    var kimden = ayet[0].value.sabah_h_ayet.toString();

   return [ aciklama , kimden];
   
   }

    else{
      return ["hata","hata"];
    }


  //günes 1
  //sabah 2
  //oglen 3
  //ikindi 4
  //akşam 5 



}
}