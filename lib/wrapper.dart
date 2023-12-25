
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:namazvakti/alarm.dart';
import 'package:namazvakti/anaekran.dart';
import 'package:namazvakti/bildirimekran.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/home.dart';
import 'package:namazvakti/model-control/ayetlermodel.dart';
import 'package:namazvakti/model-control/hadismodel.dart';
import 'package:namazvakti/model-control/vakitlermodel.dart';
import 'package:namazvakti/veritabani.dart';
import 'package:namazvakti/wellcome.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';

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

 disableoptimizationforautostart()async{
   await DisableBatteryOptimization.isAutoStartEnabled.then((value) => print("otomatik başlatma durumu : " + value.toString()));
  }
 /*gpsizin() async {


  loc.Location location = loc.Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
loc.LocationData _locationData;

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

_permissionGranted = (await location.hasPermission()) as PermissionStatus;
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = (await location.requestPermission()) as PermissionStatus;
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

_locationData = await location.getLocation();
 } */
disableopt ()async{
  bool deger = await DisableBatteryOptimization.isBatteryOptimizationDisabled.then((value) => value!);
if (deger==false) {
   showDisableOptimizationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Optimizasyon devre dışı bırakılmamış'), 
          content: Text('Uygulamanın arka planda çalışabilmesi için optimizasyon devre dışı bırakılmalıdır.'),
          actions: [
            TextButton(
              onPressed: () {
                
                Navigator.of(context).pop();

              },
              child: Text('TAMAM'),
            ),
          ],
        );
      },
    );
    return null;
  }
  await showDisableOptimizationDialog(context);
  await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
   
                  }}

  
  final box = GetStorage();
  namazvakital()async{
  NamazVakitleri a= await NamazVakitleri.getNamazVakitleri(AppConfig.ilceid);
  print("namaz vakitleri alındı");
  return a;
  }

     final duac = Get.put(DuaKont());

bildirimliacilis(){
   Object? notificationData = ModalRoute.of(context)!.settings.arguments;

    if(notificationData != null) {
      print("bildirimli açılış");
      // Bildirim ile açılmışsa, bildirim sayfasına git 
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>  PrayerTimeScreen(
          notificationData: notificationData,)
        ),  
      );
    } else {
     // Bildirim yoksa normal akışa devam et
    }

   

}

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
disableopt();
    return true ;

}
else{
  await controller.okuid();
        AppConfig.login=true;
 //await vakitalarmkontrol();
// hadis yükle
  //  await db.veritabanisil();

  // günü kontrol et
  // bugunu al 
 var tgun = await box.read("dbgun");

 DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  print("bugünün tarihi : " + formattedDate);
  if (tgun!=formattedDate) {
    print("bugünün tarihi farklı");
           box.write("dbgun", formattedDate);
      db.tarihicontrolEt();
  }
  else{
    print("bugünün tarihi aynı");
    print("db işlemi yapılmayacak");
  }
 //namaz1 şifre

  print("hop ilk kez girmiyor");
  disableopt();
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
      
       
  