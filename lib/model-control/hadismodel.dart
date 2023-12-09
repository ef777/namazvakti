import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:namazvakti/config.dart';

class HadisModel {
  String? imsakHadisi;
  String? imsakMuctehidi;
  String? sabahHadisi;
  String? sabahMuctehidi;
  String? oglenHadisi;
  String? oglenMuctehidi;
  String? ikindiHadisi;
  String? ikindiMuctehidi;
  String? aksamHadisi;
  String? aksamMuctehidi; 
  String? yatsiHadisi;
  String? yatsiMuctehidi;

  HadisModel({
    this.imsakHadisi,
    this.imsakMuctehidi,
    this.sabahHadisi,
    this.sabahMuctehidi,
    this.oglenHadisi,
    this.oglenMuctehidi,
    this.ikindiHadisi,
    this.ikindiMuctehidi,
    this.aksamHadisi,
    this.aksamMuctehidi,
    this.yatsiHadisi,
    this.yatsiMuctehidi
  });

  factory HadisModel.fromJson(Map<String, dynamic> json) {
    return HadisModel(
      imsakHadisi: json['imsak_hadisi'],
      imsakMuctehidi: json['imsak_muctehidi'],
      sabahHadisi: json['sabah_hadisi'],
      sabahMuctehidi: json['sabah_muctehidi'],
      oglenHadisi: json['oglen_hadisi'],
      oglenMuctehidi: json['oglen_muctehidi'],
      ikindiHadisi: json['ikindi_hadisi'],
      ikindiMuctehidi: json['ikindi_muctehidi'],
      aksamHadisi: json['aksam_hadisi'],
      aksamMuctehidi: json['aksam_muctehidi'],
      yatsiHadisi: json['yatsi_hadisi'],
      yatsiMuctehidi: json['yatsi_muctehidi'],
    );
  }

static   Future<String> loadhadisler_JsonFromAsset() async {
var a=  await rootBundle.loadString('assets/json/hadisler_json.json');
    return a; 

}
static Future <List <HadisModel>> loadHadisler() async {
  String jsonString = await loadhadisler_JsonFromAsset();
  final jsonResponse = json.decode(jsonString);

  List<HadisModel> hadisler = [];
  for (var u in jsonResponse) {
    HadisModel hadis = HadisModel.fromJson(u);
    hadisler.add(hadis);
  }
  
  return hadisler;  

}








}



class HadisKont extends GetxController {

static List<HadisModel> hadisler = [];
static var secilihadis = <Rx<HadisModel>>[].obs;







hadisbelirle(){
secilihadis.clear();
 var random = new Random();
var rastgeleIndex = random.nextInt(HadisKont.hadisler.length);
 secilihadis.add( HadisKont.hadisler[rastgeleIndex].obs);

return secilihadis;
}

hadisvakit(String tip)async {
RxList<Rx<HadisModel>> hadis =await hadisbelirle();
if(  tip == "0"){
   var aciklama= hadis[0].value.imsakHadisi.toString();
    var kimden = hadis[0].value.imsakMuctehidi.toString();

   return [ aciklama , kimden];
   
   }
    else if(  tip == "1"){
    var aciklama= hadis[0].value.sabahHadisi.toString();
    var kimden = hadis[0].value.sabahMuctehidi.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "2"){
    var aciklama= hadis[0].value.oglenHadisi.toString();
    var kimden = hadis[0].value.oglenMuctehidi.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "3"){

    var aciklama= hadis[0].value.ikindiHadisi.toString();
    var kimden = hadis[0].value.ikindiMuctehidi.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "4"){
    var aciklama= hadis[0].value.aksamHadisi.toString();
    var kimden = hadis[0].value.aksamMuctehidi.toString();
    return [ aciklama , kimden];
    }

    else if(  tip == "5"){
    var aciklama= hadis[0].value.yatsiHadisi.toString();
    var kimden = hadis[0].value.yatsiMuctehidi.toString();
    return [ aciklama , kimden];
    }
else if(  tip == "6"){
   var aciklama= hadis[0].value.imsakHadisi.toString();
    var kimden = hadis[0].value.imsakMuctehidi.toString();

   return [ aciklama , kimden];
   
   }
    else{
      return ["hata","hata"];
    }


  //imsak 1
  //sabah 2
  //oglen 3
  //ikindi 4
  //akşam 5 



}
}