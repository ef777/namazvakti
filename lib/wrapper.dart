
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:namazvakti/alarm.dart';
import 'package:namazvakti/anaekran.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/home.dart';
import 'package:namazvakti/model-control/ayetlermodel.dart';
import 'package:namazvakti/model-control/hadismodel.dart';
import 'package:namazvakti/model-control/vakitlermodel.dart';
import 'package:namazvakti/veritabani.dart';
import 'package:namazvakti/wellcome.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

import 'model-control/dualarmodel.dart';
import 'model-control/ilmihaller_model.dart';
import 'model-control/isim_model.dart';

   final controller = Get.put(AppConfig()); 
var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final notf = Get.put(NotificationService());
  final db = Get.put(VeritabaniYardimcisi());

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
void _showNotification(String title, String body) {
    NotificationService().showNotification(title: title, body: body);
  }
  void _setAlarm(DateTime selectedDateTime, String alarmMessage) async {
    await notf.setAlarm(
        selectedDateTime, 'Alarm', alarmMessage);
   // _showNotification('Alarm Ayarlandı', alarmMessage);
  }

 
  final box = GetStorage();
  namazvakital()async{
  NamazVakitleri a= await NamazVakitleri.getNamazVakitleri(AppConfig.ilceid);
  print("namaz vakitleri alındı");
  return a;
  }

     final duac = Get.put(DuaKont());

giristum()async{
  List < HadisModel> hadisler  = await HadisModel.loadHadisler();
HadisKont.hadisler = hadisler;
//print("gelen hadisler : " + hadisler.length.toString());
List<DualarModel> dualar = await  duac.loaddualar();
duac.dualar = dualar;

List<AyetModel> ayetler = await AyetModel.loadAyetler();
AyetKont.ayetler = ayetler;
List<IlmihalBilgi> ilmihaller = await IlmihalBilgi.loadAyetler();
IlmihalKont.ilmihaller = ilmihaller;

List<IsimModeli> isimler = await IsimModeli.loadisimler();
IsimKont.isimler = isimler;

var giris = await controller.ilkgirismi();
if (giris==true) {
print("hop ilk kez giriyor");
     await db.veritabaniolustur();
print("veri tabanı oluşturuldu");
    return true ;

}
else{
  await controller.okuid();
        AppConfig.login=true;
 //await vakitalarmkontrol();
// hadis yükle
  //  await db.veritabanisil();
      db.tarihicontrolEt();

  print("hop ilk kez girmiyor");
  return false;

}}

// her lışta  
 // eğer giris yapılmışsa ve şehir info yoksa şehir seçim sayfasına yönlendir
 
// ardından uyarı vakitleri aç kapa yapılacak




  @override
  Widget build(BuildContext context) {
   
      return FutureBuilder(future: 
   giristum(),
      
       
      builder: 
      (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data==false) {
            return HomePage();
          }
          else{
            return WellcomePage();
          }

        } else {
          return Scaffold(
            body: Center(
              child:   Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConfig.col2,
              AppConfig.col1,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      )
            ),
          )
          ;
        }
      },
    );
  }
}
      
       
  