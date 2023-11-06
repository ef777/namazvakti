
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
  //vakitleri al
  // sonra local notftan verileri al yazdır
  namazvakital()async{
  NamazVakitleri a= await NamazVakitleri.getNamazVakitleri(AppConfig.ilceid);
  print("namaz vakitleri alındı");
  return a;
  }

 

bekleyenBildirim() async {

  var pendingNotifications = await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  print("bildirim adeti " + pendingNotifications.length.toString());

  for(PendingNotificationRequest notification in pendingNotifications) {
                                                                  
  
    var payloadStr = notification.payload as String;
var parts = payloadStr.split('|');
var dateTimeStr = parts[0]; 
var customPayload = parts[1];
var dateTime = DateTime.parse(dateTimeStr);

print("payload gelen tarih : " + dateTime.toString());

    if (dateTime.isBefore(DateTime.now())) {
      print("bildirim tarihi geçmiş");
      flutterLocalNotificationsPlugin.cancel(notification.id);
    }
    else {
      print("bildirim tarihi geçmemiş");
    }
    

  }
  return pendingNotifications;

}


// tamam vakitleri aldım. kurulu alarmların tarihini aldım. şimdi bu tarihlerle vakitleri karşılaştıracağım
vakitalarmkontrol() async {
 NamazVakitleri gelennamaz= await namazvakital();
  List<Vakit> vakits= await gelennamaz.vakitler;

 List<PendingNotificationRequest> gelenalarms=await  bekleyenBildirim();
print("vakit adeti : " + vakits.length.toString());

 for( var i=1; i<vakits.length; i++){
    var vakit= vakits[i].miladiTarihKisa;
    print("vakit tarih : " + vakit);
    var deger=0;

   for( var a=0; a<gelenalarms.length; a++){
   var payloadStr = gelenalarms[a].payload as String;
var parts = payloadStr.split('|');
var dateTimeStr = parts[0];
var customPayload = parts[1];
var dateTime = DateTime.parse(dateTimeStr);
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
var alarm = formatter.format(dateTime);
print("alarm tarihi : " + alarm);
if (vakit==alarm) {
  deger=1;
  print("buldu");
  break;
}
else{

}
   }

if(deger == 1)
{
    print("alarm kurulu");

  
   }

else{
  print("alarm kurulu değil");
  _setAlarm(vakits[i].imsakdate, "imsak vakti");
  _setAlarm(vakits[i].gunesdate, "güneş vakti");
  _setAlarm(vakits[i].ogledate, "öğle vakti");
  _setAlarm(vakits[i].ikindidate, "ikindi vakti");
  _setAlarm(vakits[i].aksamdate, "akşam vakti");
  _setAlarm(vakits[i].yatsidate, "yatsı vakti");



}

}
print("döngü bitti");
return 1;
}


 // ilk kezz giris kontrol

giristum()async{
  List < HadisModel> hadisler  = await HadisModel.loadHadisler();
HadisKont.hadisler = hadisler;
List<DualarModel> dualar = await  DualarModel.loaddualar();
DuaKont.dualar = dualar;

List<AyetModel> ayetler = await AyetModel.loadAyetler();
AyetKont.ayetler = ayetler;
List<IlmihalBilgi> ilmihaller = await IlmihalBilgi.loadAyetler();
IlmihalKont.ilmihaller = ilmihaller;

List<IsimModeli> isimler = await IsimModeli.loadisimler();
IsimKont.isimler = isimler;

var giris = await controller.ilkgirismi();
if (giris==true) {
print("hop ilk kez giriyor");
    return true ;

}
else{
  await controller.okuid();
        AppConfig.login=true;
        
 //await vakitalarmkontrol();
// hadis yükle

  print("hop ilk kez değil");
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
      
       
  