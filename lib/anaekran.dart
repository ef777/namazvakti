
 import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:namazvakti/alarm.dart';
import 'package:namazvakti/model-control/ayetlermodel.dart';
import 'package:namazvakti/model-control/dualarmodel.dart';
import 'package:namazvakti/model-control/hadismodel.dart';
import 'package:namazvakti/model-control/ilmihaller_model.dart';
import 'package:namazvakti/model-control/isim_model.dart';
import 'package:vibration/vibration.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/dinigunler.dart';
import 'package:namazvakti/model-control/vakitlermodel.dart';
import 'dart:math';

 import 'wrapper.dart';

 import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tarih biçimlendirme için
class ImsakDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog( 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Stack(
        clipBehavior: Clip.none, alignment: Alignment.topCenter,
        children: [
          
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Namaz Vakti", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text("Namaz vakti başlamıştır.", textAlign: TextAlign.center),
                SizedBox(height: 16),
              ],
            ),
          ),
          
          Positioned(
            top: -50,
            child: CircleAvatar(
              radius: 50, 
              backgroundImage: AssetImage("assets/namaz.png"),
            )  
          )
          
        ],
      ),
    );
  }

}
 // It is assumed that all messages contain a data field with the key 'type'
 class ColorController extends GetxController {
  final colors = [Colors.red, Colors.green].obs;
  RxInt currentColorIndex = 0.obs;

  void changeColor() {
    ever(currentColorIndex, (_) { 
      if (currentColorIndex < colors.length-1) {
        currentColorIndex++;
      } else {
        currentColorIndex.value = 0;
      }
    });
  }

}
// timer_controller.dart

void playAssetSound(String soundName, int duration) async {
  final player = AudioPlayer();

  // Start playing the audio
player.play(AssetSource('ezan/$soundName'));

  // Schedule stopping the audio after the specified duration
  await Future.delayed(Duration(seconds: duration));

  // Stop the audio playback
  await player.stop();
}
class TimerController extends GetxController {
  final RxDouble progress = 0.0.obs;
   
 Vakit bugunubul( NamazVakitleri vakitveri ){
  print("bugun bulunuyor");
  List <Vakit> vakitler = vakitveri.vakitler;
  var today = DateTime.now();
    var formattedDate = DateFormat('dd.MM.yyyy').format(today);

    for(var i = 0; i < vakitler.length; i++) {
      if(vakitler[i].miladiTarihKisa == formattedDate) {
        print("bugun bulundu $formattedDate");
        return vakitler[i];
      }
    }
    print("bugun bulunamadi");
      return vakitler[0];



 }
 Vakit dunubul( NamazVakitleri vakitveri ){
  List <Vakit> vakitler = vakitveri.vakitler;
  var today = DateTime.now();
    var tomorrow = DateTime(today.year, today.month, today.day - 1);

    var formattedDate = DateFormat('dd.MM.yyyy').format(tomorrow);

    for(var i = 0; i < vakitler.length; i++) {
      if(vakitler[i].miladiTarihKisa == formattedDate) {
              print("dün bulundu $formattedDate");

        return vakitler[i];
      }
    }
    print("dün bulunamadi");
      return vakitler[0];



 }
   
 Vakit yarinibul( NamazVakitleri vakitveri ){
  List <Vakit> vakitler = vakitveri.vakitler;
  var today = DateTime.now();
    var tomorrow = DateTime(today.year, today.month, today.day + 1);

    var formattedDate = DateFormat('dd.MM.yyyy').format(tomorrow);

    for(var i = 0; i < vakitler.length; i++) {
      if(vakitler[i].miladiTarihKisa == formattedDate) {
                      print("yarin bulundu $formattedDate");

        return vakitler[i];
      }
    }
    print("yarin bulunamadi");
      return vakitler[0];



 }
 


 
   DateTime? oncekiVakitBul(DateTime suan, List<DateTime> vakitler) {

    // gece 12 den sonra onceki vakri nasıl bulrusun?

  int vakindex= 0;
  DateTime? oncekivakit;
  int enKucukFark = 999999; 
  print( "suan" + suan.toString() ); //         2023-11-04 19:31:56.842374
  print( "vakitler!" + vakitler.toString()); // 2023-11-04 05:48:00.000
  for (var i = 0 ; i< vakitler.length; i++) {
  
  
    if (vakitler[i].isBefore(suan)) {
            vakindex = vakindex + 1;
      continue; 
    }
    
    int fark = suan.difference(vakitler[i-1]).inSeconds.abs();
    
    if (fark < enKucukFark) {
      enKucukFark = fark;
      oncekivakit = vakitler[i-1];
    }
    
  }

  return oncekivakit;
  
}
DateTime? enYakinVakitBul(DateTime suan, List<DateTime> vakitler) {
  print("en yakın vakit bul başladı");
  int vakindex= 0;
  DateTime? enYakinVakit;
  int enKucukFark = 999999; 
  print("debug alani ********************************************");
  print( "suan" + suan.toString() ); //         2023-11-04 19:31:56.842374
  print( "vakitler!" + vakitler.toString()); // 2023-11-04 05:48:00.000
  for (var vakit in vakitler) {
  //   akşam okunacak saat 1 saat var 
    if (vakit.isBefore(suan)) {
            vakindex = vakindex + 1;
print("vakindexlm" + vakindex.toString());

apf.updateindexValue(vakindex);
 print("hop");
     continue; 
    }
    else {

   int fark = suan.difference(vakit).inSeconds.abs();
    print("fark" + fark.toString());
    print("şuanki saat " + suan.toString());
    if (fark < enKucukFark) {
      enKucukFark = fark;
      enYakinVakit = vakit;
    }
    // ama işte yakın veya uzak bir sonrakini seçmeli
  }
  print("dönen en yakın vakit" + enYakinVakit.toString());
  print("debug alani bitti ********************************************");

  return enYakinVakit;
    }
   print("en yakın vakit hata vakit");
     print("en yakın vakit bul bitti");
     if( vakindex> 5){
  print("bulunamadı sonraki güne gidilmeli");
  return null;
 }
var sonuc = vakitler[vakindex+1];

  return  sonuc; //333
}
 vakithesaplailk( NamazVakitleri vakitveri)async{
  print("ilk vakit bul başladı");
  Vakit ilkgun = bugunubul(vakitveri);
 DateTime suan= await DateTime.now();
  DateTime imsak= ilkgun.imsakdate;
  DateTime gunes= ilkgun.gunesdate;
  DateTime ogle= ilkgun.ogledate;
  DateTime ikindi= ilkgun.ikindidate;
  DateTime aksam= ilkgun.aksamdate;
  DateTime yatsi= ilkgun.yatsidate;
  DateTime? siradaki_vakit = await enYakinVakitBul(suan, [imsak, gunes, ogle, ikindi, aksam, yatsi]);
// 333
if(siradaki_vakit != null){
  // yani eğer yatsi değilse vakit
  print("siradaki_vakit var o gün için yani yatsi değil şuanki vakit" + siradaki_vakit.toString());
  var now =suan;

 if(now.hour >= 0 && now.hour < imsak.hour){  
 Vakit dungun  = dunubul(vakitveri);
  // Gece yarısından sonra ve sabah 7'den ö nce
  print(dungun.yatsi);
  print("Gece yarısından sonra ve sabah 7'den önceki zaman dilimi");
  DateTime? onceki_vakit = yatsi;
  oncekiVakit.value = dungun.yatsidate.obs.value;
 prayerTime.value = siradaki_vakit!.obs.value;
 apf.updateindexValue(1);
 apf.updateStringValue("İmsak Vaktine .");
}

  else {
    print("dq23");
  DateTime? onceki_vakit = oncekiVakitBul(suan, [imsak, gunes, ogle, ikindi, aksam, yatsi]);

    oncekiVakit.value = onceki_vakit!.obs.value;
      print( "onceki_vakit!" + onceki_vakit.toString() );
 prayerTime.value = siradaki_vakit!.obs.value;
  
  print( "siradaki_vakit" + siradaki_vakit.toString() );

}}
if (siradaki_vakit == null) {
  // eğer vakit yatsı ise
  print("dl25");
  print("bir sonraki vakit yatsi ve o vakitten sonra başka vakit yok. bir sonraki güne bakılıyor");
  Vakit yarin = yarinibul(vakitveri);
   Vakit bugun = bugunubul(vakitveri);
  print( "yarin" + yarin.miladiTarihKisa.toString() );
  print( "bugun" + bugun.miladiTarihKisa.toString() );
  DateTime yarin_imsak= yarin.imsakdate;
  DateTime yarin_gunes= yarin.gunesdate;
  DateTime yarin_ogle= yarin.ogledate;
  DateTime yarin_ikindi= yarin.ikindidate;
  DateTime yarin_aksam= yarin.aksamdate;
  DateTime yarin_yatsi= yarin.yatsidate;


  DateTime imsak= bugun.imsakdate;
  DateTime gunes= bugun.gunesdate;
  DateTime ogle= bugun.ogledate;
  DateTime ikindi= bugun.ikindidate;
  DateTime aksam= bugun.aksamdate;
  DateTime yatsi= bugun.yatsidate;


  DateTime? siradaki_vakit = await enYakinVakitBul(suan, [yarin_imsak, yarin_gunes, yarin_ogle, yarin_ikindi, yarin_aksam, yarin_yatsi]);
  DateTime? onceki_vakit = yatsi;


 prayerTime.value = siradaki_vakit!.obs.value;
 oncekiVakit.value = onceki_vakit!.obs.value;
  print( "siradaki_vakit" + siradaki_vakit.toString() );
  print( "onceki_vakit" + onceki_vakit.toString() );
}

  print("ilk vakit bul bitti");


   }



var prayerTime = DateTime(2030, 10, 22, 10, 0, 0).obs;
var oncekiVakit = DateTime(2030, 10, 22, 10, 0, 0).obs;
Rx<DateTime> currentTime = DateTime.now().obs;
Rx<Duration> remainingTime = Rx(Duration());
   NamazVakitleri ? vakitveri;
String formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return '$hours saat $minutes dakika $seconds saniye';
}
@override 
void onInit() {
  print("timer on init başladı");
  Timer.periodic(Duration(seconds: 1), (timer) {
  currentTime.value = DateTime.now();
});

  ever(currentTime, (_) {     
    remainingTime.value = prayerTime.value.difference(currentTime.value ); 
        var kalandakika = prayerTime.value.difference(currentTime.value).inSeconds / 60.0; 
        var ilkdakika= prayerTime.value.difference(oncekiVakit.value).inSeconds / 60.0;
         //   print("ilk dakika" + ilkdakika.toString());
       // print("kalan dakika" + kalandakika.toString());
        var progressdegeri = 100 - (kalandakika / ilkdakika) * 100;
          progress.value = progressdegeri;


  });

  ever(remainingTime, (_) {

  if (remainingTime.value.inSeconds <= 0) {

    // Bir sonraki vakte geçildi, uyarı ver
    
    print("Vakit değişti! Yeni vakit: ${apf.vakitstxt}");
Vibration.vibrate(pattern: [500, 1000, 500, 2000]);

    // Bir sonraki vakte geç
  vakithesaplailk(vakitveri!);
//Get.dialog(ImsakDialog());
//playAssetSound ("ezan1.mp3", 10);
  }
  
});
}
}

  final HadisKont hadisc = Get.put(HadisKont());
    final DuaKont duac = Get.put(DuaKont());
    final IlmihalKont ilmihalc = Get.put(IlmihalKont());
    final AyetKont ayetc = Get.put(AyetKont());
    final IsimKont isimc = Get.put(IsimKont());
ColorController controller = Get.put(ColorController());
    final AppConfig apf = Get.put(AppConfig());

 class AnaEk extends StatefulWidget {
    AnaEk({super.key});

  @override
  State<AnaEk> createState() => _AnaEkState();
}

class _AnaEkState extends State<AnaEk> {
 @override

 var hadis;
var ayet ;
var ilmihal;
var isim;

  List<Color> _colors = [ /*   Color(0xFF21367F).withOpacity(0.5), */
 /* Color(0xFF194D91).withOpacity(0.5), */
   Color(0xFF1590C1).withOpacity(0.5),
   Color(0xFF0298CA).withOpacity(0.5),
]; 
 // List of gradient colors
  int _currentColorIndex = 0; 

 late DateTime currentTime;
  late String selectedCity;

var siradakivakit;
  void initState() {
    super.initState();
  currentTime = DateTime.now();
    selectedCity = '${AppConfig.sehirname}'; // Başlangıçta seçilen şehir
controller.changeColor(); 
  print("Vakit değişti! Yeni vakit: ${apf.vakitstxt}");
//Vibration.vibrate(pattern: [500, 1000, 500, 2000]);

    // Bir sonraki vakte geç
//Get.dialog(ImsakDialog());
//playAssetSound ("ezan1.mp3", 10);
  }

  @override
  void dispose() {
    super.dispose();
  }

  

  Future<List> AnaekranFuture() async{
 
NamazVakitleri a= await NamazVakitleri.getNamazVakitleri(   AppConfig.ilceid);

// tarihler
var vakitler= a.vakitler;

for( Vakit a in vakitler){

}

  timerController.vakitveri =    a;
        print(timerController.vakitveri );
 

timerController.vakithesaplailk( timerController.vakitveri!);
 hadis =  await hadisc.hadisvakit( apf.vakitstxt.value.toString());
 ayet = await ayetc.ayetvakit( apf.vakitstxt.value.toString());
 ilmihal =  await ilmihalc.imihalbelirle();
 isim = await isimc.isimbelirle(); 


 return [a];

   }
   @override
   Widget build(BuildContext context) {

    return FutureBuilder<List<dynamic>>(
        future:AnaekranFuture(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } if (snapshot.hasData) {
   
   Vakit bugun = timerController.bugunubul( timerController.vakitveri!);
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
void _showNotification(String title, String body) {
    NotificationService().showNotification(title: title, body: body);
  }
 
 ilkkezbildirim()async{

var dateInput = "30.10.2023";

// Bunu parçalara ayıralım
var datePieces = dateInput.split(".");

// Tarih bilgisini çıkaralım
var day = int.parse(datePieces[0]);
var month = int.parse(datePieces[1]);  
var year = int.parse(datePieces[2]);
var hour = 14;
var minute = 30;

var notificationDate = DateTime(year, month, day, hour, minute);
print(notificationDate.toString());
 await notf.setAlarm(
        notificationDate, 'Alarm', "ilk kez");
    _showNotification('Alarm Ayarlandı', "ilk kez");


 }
     return Scaffold(    
     
    
         body:  AnimatedContainer(
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.5,
            center: Alignment.topCenter,

    
            colors: [_colors[_currentColorIndex], Colors.white],
          ),
        ),
        child:    CustomScrollView(
          shrinkWrap: true,

  slivers: [
    
  SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.20,
          width: size.width * 0.82,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Row(
            
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
             SizedBox(
        width: size.width * 0.1,
             ),
             
             Obx(
                () => Text(
                   textAlign: TextAlign.center,

        style: TextStyle(
                                fontSize: size.height * 0.015,

          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
                  apf.vakitstring.value,
                ),
              ),      ]),
SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
            Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.white, width: 1), // Beyaz ince çerçeve ekleme
    color: Colors.transparent,
  ),
  padding: EdgeInsets.all(4.0),
  child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // Orta hizalamalı olarak değiştiriyoruz
              crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() =>   Text(
                timerController.remainingTime.value.inHours.toString() + " : ",
                style: TextStyle(fontSize: size.height * 0.030, fontWeight: FontWeight.bold, color: Colors.white),
              )),
              Center(child: Text(
              
              textAlign:TextAlign.center, 
                "saat",
                style: TextStyle(fontSize: size.height * 0.015, color: Colors.white),
              )),
            ],
          ),
        
          Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
           Obx(() =>   Text(   timerController.remainingTime.value.inMinutes.remainder(60).toString() +" : ",
                style: TextStyle(fontSize: size.height * 0.030, fontWeight: FontWeight.bold, color: Colors.white),
              ) ),
              Text(
                              textAlign:TextAlign.center, 

                "dakika    ",
                style: TextStyle(fontSize: size.height * 0.015, color: Colors.white),
              ),
            ],
          ),
          Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

              mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Obx(() =>    Text(
                 timerController.remainingTime.value.inSeconds.remainder(60).toString() ,
            
                style: TextStyle(fontSize: size.height * 0.030, fontWeight: FontWeight.bold, color: Colors.white),
             )),
              Text(
                textAlign: TextAlign.center,
                "saniye",
                style: TextStyle(fontSize: size.height * 0.015, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
),
Container(
  decoration: BoxDecoration(
    color: Colors.white, // Beyaz arka plan rengi
    borderRadius: BorderRadius.circular(10), // Köşeleri yuvarlatılmış çerçeve
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5), // Gölge rengi ve opaklık
        spreadRadius: 3,
        blurRadius: 5,
        offset: Offset(0, 3), // Gölgenin yönü
      ),
    ],
  ),
  padding: EdgeInsets.all(2.0),
  margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
  child: DropdownButton<String>(
    value: selectedCity,
    items: <String>[AppConfig.sehirname]
        .map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(fontSize: 14, color: Colors.blue),
        ),
      );
    }).toList(),
    onChanged: (String? newValue) {
      setState(() {
        selectedCity = newValue!;
      });
    },
    dropdownColor: Colors.white, // Dropdown arka plan rengi
    icon: Icon(Icons.arrow_drop_down, color: Colors.blue), // Dropdown simgesi
    underline: Container(), // Seçili öğe alt çizgisini kaldırma
  ),
)

                ],
              ),
              SizedBox(height: 10.0),
      
Obx(() =>  TirtikliLinearProgressIndicator(progressValue: timerController.progress.value  ))
            
            ],
          ),
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
         gradient: LinearGradient(
              colors: [
                Color(0xFF21367F),
                Color(0xFF194D91),
                Color(0xFF1590C1),
                Color(0xFF0298CA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
           ),
      ),
    
          SliverToBoxAdapter(
      child: 
      
       GestureDetector(
        onTap: () {
          print("tiklandi");
               //   ilkkezbildirim();
//NotificationService.showCustomNotification("Namaz Vakti", "Sabah Namazı", "05:33");
  //zamanistring(datetime) // '06.11.2023:18:54',
     
    

NotificationService.bildirimayarla(  
        '${DateTime.now().add(Duration(seconds: 10))}', 
 "${AppConfig.bildirim_title}",
      "${AppConfig.bildirim_content}",
   '${AppConfig.sehirname}',
    '0',
          '${    NotificationService.saatVeDakika( timerController.vakitveri!.vakitler[0].imsakdate) 
}',
   '${    NotificationService.saatVeDakika( timerController.vakitveri!.vakitler[0].gunesdate)}',
    '${    NotificationService.saatVeDakika( timerController.vakitveri!.vakitler[0].ogledate)}',
    '${    NotificationService.saatVeDakika( timerController.vakitveri!.vakitler[0].ikindidate)}',
        '${    NotificationService.saatVeDakika( timerController.vakitveri!.vakitler[0].aksamdate)}',
                '${    NotificationService.saatVeDakika( timerController.vakitveri!.vakitler[0].yatsidate)}',
     
  
);
print("bitti");
         print("notf test");
               //   ilkkezbildirim();
//NotificationService.showCustomNotification("Namaz Vakti", "Sabah Namazı", "05:33");
print("bitti");
        },

      child:
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
         padding: EdgeInsets.all(12.0),
          height: size.height * 0.08,
          width: size.width * 0.8,
   margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.02, size.width * 0.05, size.width * 0.05),
       child: 
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
                children: [
            Container( child: Image.asset("assets/tarih.png",width: 50,height: 50,),),

   Text("Miladi Takvim"),
   Text("${bugun.miladiTarihKisa}",style:TextStyle(
    color:  Color(0xFF1687BB),
    fontSize: 14),),
                
                
                ],
              ),
        ) ),
    
          ),
          SliverToBoxAdapter(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
         padding: EdgeInsets.all(12.0),
          height: size.height * 0.08,
          width: size.width * 0.8,
          margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.01, size.width * 0.05, size.width * 0.05),
       child: 
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
                children: [
            Container( child: Image.asset("assets/tarih.png",width: 50,height: 50,),),

   Text("Hicri Takvim"),
   Text("${bugun.hicriTarihKisa}",style:TextStyle(
    color:  Color(0xFF1687BB),
    fontSize: 14),),        
                ],
              ),
      ),
          ),   SliverToBoxAdapter(
      child: Container(
        color: Colors.transparent,
           padding: EdgeInsets.all(2.0),
         /*  height: size.height * 0.11,
          width: size.width * 0.8, */
          margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.01, size.width * 0.02, size.width * 0.01),
     
        child: Text("Vakit Köşesi", style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        ),

      )),
     SliverToBoxAdapter(  
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
         padding: EdgeInsets.all(2.0),
          height: size.height * 0.125,
          width: size.width * 0.9,
          margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.005, size.width * 0.03, size.width * 0.005),
       child:  AyGunleriWidget(vakitveri : timerController.vakitveri!),

      
        
            

      
            ),
            ),
            SliverToBoxAdapter(
      child: Container(
           padding: EdgeInsets.all(2.0),
         /*  height: size.height * 0.11,
          width: size.width * 0.8, */
          margin: EdgeInsets.fromLTRB(
              size.width * 0.06, size.width * 0.01, size.width * 0.02, size.width * 0.01),
     
        child: Text("Ezan Vakitleri", style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        ),

      )),
  SliverToBoxAdapter(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ], 
          ),
         padding: EdgeInsets.all(2.0),
          height: size.height * 0.40,
          width: size.width * 0.8,
          margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.005, size.width * 0.05, size.width * 0.005),
       child: Obx(() =>  EzanVakitleri( vakitveri : timerController.vakitveri!,seciliVakit :apf.selectedEzanvakti.value),
       )
            ),
            ),
              SliverToBoxAdapter(
      child: Container(
        height: size.height * 0.20,
child:                      Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

  children:[  CircularProgressBar(vakitveri: timerController.vakitveri!,   tip:"1" ,
  backgroundColor: Colors.white.withOpacity(0.2),  
  foregroundColor: Colors.blue.withOpacity(0.8)
  
  ),
 CircularProgressBar(vakitveri: timerController.vakitveri!, backgroundColor:Colors.white.withOpacity(0.2), 
  foregroundColor: Colors.deepPurple ,tip :"2"), CircularProgressBar(vakitveri: timerController.vakitveri!, backgroundColor:    Colors.white.withOpacity(0.2),  

  foregroundColor: Colors.orange ,tip : "3",),

     ]) )),

      SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
           padding: EdgeInsets.all(12.0),
         /*  height: size.height * 0.11,
          width: size.width * 0.8, */
          margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.007, size.width * 0.02, size.width * 0.01),
     
        child: Text("Vakit Köşesi", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        ),

      )),

//sss
 SliverToBoxAdapter(
      child:  HadisKarti( renk : [   Color(0xFF21367f),
      Color(0xFF194d91),
      Color(0xFF1590c1),
      Color(0xFF0298ca),
      Color(0xFF0298ca), ],
               baslik: "Vaktin Hadisi",icerik: "${hadis[0] + " " + hadis[1]}",
      )),

 SliverToBoxAdapter(
      child:  HadisKarti( renk : [   Color(0xFF21D884).withOpacity(1),
                Color(0xFF005510).withOpacity(1) ],
               baslik: "Vaktin Ayeti",icerik: "${ayet[0] + " " + ayet[1]}", )),
       SliverToBoxAdapter(
      child:  HadisKarti( renk : [ 
      Color(0xFF0c1732),
      Color(0xFF65b2ff),
    ],
               baslik: "İlmihal",icerik: "${ilmihal[1]}  ${ilmihal[0]} +" )),
     SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
           padding: EdgeInsets.all(10.0),
         /*  height: size.height * 0.11,
          width: size.width * 0.8, */
          margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.007, size.width * 0.02, size.width * 0.01),
     
        child: Text("Kız-Erkek İsimleri", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ), 
      ),
      )),SliverToBoxAdapter(
      child: Container(
        height: size.height * 0.20,
        decoration: BoxDecoration(
  color:  Colors.red.withOpacity(0), 
  borderRadius: BorderRadius.circular(10)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.005, size.width * 0.03, size.width * 0.005),

  child:
         Stack(children: [
     
   
   Align(
  alignment: Alignment.center,
    
    child: 
   Container(
       
        height: 100,
        decoration: BoxDecoration(
  color:   Color(0xFFFF702C). withOpacity(0.4), 
  borderRadius: BorderRadius.circular(10)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.005, size.width * 0.03, size.width * 0.005),
   )), 
      Align(
  alignment: Alignment.topLeft,
child: Container(
  padding: EdgeInsets.all(10),
  child: Image .asset("assets/er.png",width: 85,height: 110,fit: BoxFit.cover,),

          )),
    Align(
      
  alignment: Alignment.center,
child: Container(
  margin: EdgeInsets.fromLTRB(70, 1, 5, 1),
  padding: EdgeInsets.all(30),
  
  child:
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

Text("Erkek İsim: ${isim[2] }",style: TextStyle(
  
)),
 Text(" ${isim[3] }",style: TextStyle( 
    fontSize: isim[1].length > 20 ? 10 : 12 ,
   color: Colors.black.withOpacity(0.5)
 
  ),
  ), ])))
          ]),
      )),

 SliverToBoxAdapter(
      child: Container(
        height: size.height * 0.20,
        decoration: BoxDecoration(
  color:  Colors.red.withOpacity(0), 
  borderRadius: BorderRadius.circular(10)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.005, size.width * 0.03, size.width * 0.005),

  child:
         Stack(children: [
     
   
   Align(
  alignment: Alignment.center,
    
    child: 
   Container(
       
        height: 100,
        decoration: BoxDecoration(
  color:   Color(0xFFFF702C). withOpacity(0.4), 
  borderRadius: BorderRadius.circular(10)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.005, size.width * 0.03, size.width * 0.005),
   )), 
      Align(
  alignment: Alignment.topRight,
child: Container(
  padding: EdgeInsets.all(10),
  child: Image .asset("assets/ki.png",width: 85,height: 110,fit: BoxFit.cover,),

          )),
    Align(
      
  alignment: Alignment.center,
child: Container(
  padding: EdgeInsets.all(30),
  margin: EdgeInsets.fromLTRB(1, 1, 70, 1),
  
  child:
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

Text("Kız İsim:   ${isim[0]} ",style: TextStyle(
  
)),
 Text("${isim[1]} ",style: TextStyle( 
   fontSize: isim[1].length > 20 ? 10 : 12 ,
   color: Colors.black.withOpacity(0.5)
 
  ),
  ), ])))
          ]),
      )),

 
       
            SliverToBoxAdapter(
      child: Container(
        height: 100,

      ))
          
  ],
)
            ),




         
           );
    }
       else {
            return Center(child: CircularProgressIndicator());
          }
    
    }
    );
  }
}



 
class AyGunleriWidget extends StatefulWidget {
    NamazVakitleri ? vakitveri;
    AyGunleriWidget({Key? key,   
required this.vakitveri
    }) : super(key: key);
    
  
  @override

  State<AyGunleriWidget> createState() => _AyGunleriWidgetState();
}

class _AyGunleriWidgetState extends State<AyGunleriWidget> {
  @override
    

var  isSelected = false;

  Widget build(BuildContext context) {

           var size = MediaQuery.of(context).size;
 List<Vakit> gunler = widget.vakitveri!.vakitler;

    DateTime now = DateTime.now();
  
    List<Widget> gunListesi = [];
  

    // gelen gün ve ay sayısına göre günleri oluşturuyoruz



    for (int i = 0; i < gunler.length; i++) {

      gunListesi.add(
        GestureDetector(
          onTap: () {
            print('${gunler[i]}');
           setState(() {
        AppConfig.selectedaygunIndex = i;   });

          
          },
          child:
        Container(
          height: size.height * 0.050,
          width: size.width * 0.050,
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            gradient:
             AppConfig.selectedaygunIndex == i ?
            
             LinearGradient(
              colors: [
              
                Color(0xFF194D91),
                Color(0xFF1590C1),
                Color(0xFF0298CA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ):
             LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 240, 241, 242),
            
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            
            ,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${gunler[i].vakitTarih!.day}',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.bold,
                  color:  AppConfig.selectedaygunIndex == i ?         Colors.white        : Color(0xFF004eff)  ,
                ),
              ),
              Text(
              
                DateFormat('MMMM', 'tr_TR').format(gunler[i].vakitTarih!), // Ayı türkçe olarak yazdırıyoruz
                style: TextStyle(
                            fontSize: size.height * 0.017,

                  color:  AppConfig.selectedaygunIndex == i ?   Colors.white : Colors.black ,
                ),
              ),
            ],
          ),
        ),
       ) );
    }

    String ayAdi = DateFormat('MMMM y', 'tr_TR').format(now);    
return   GridView.count(
          crossAxisCount: 1, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.horizontal,

          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: gunListesi,
     
    );
  }
}

class EzanVakitleri extends StatelessWidget {
          NamazVakitleri ? vakitveri;
          int seciliVakit;
    EzanVakitleri({Key? key,   
required this.vakitveri
    ,required this.seciliVakit
    }) : super(key: key);
    

  @override
  Widget build(BuildContext context) {
           var size = MediaQuery.of(context).size;
    

   List<String> iconlar = [
    'imsak_vakit.png',
    'sabah_vakit.png',
    'oglen_vakit.png',
    'ikindi_vakit.png',
    'aksam_vakit.png',
    'yatsi_vakit.png',
  ];
       List<String> ezanVakitleri = [
    'İmsak',
    'Sabah',
    'Öğle',
    'İkindi',
    'Akşam',
    'Yatsı',
  ];
   List<Vakit> gvakitler = vakitveri!.vakitler;

  List<String> vakitDegerleri = [
gvakitler[seciliVakit].imsakdate.hour.toString() + ":" + gvakitler[seciliVakit].imsakdate.minute.toString(),
gvakitler[seciliVakit].gunesdate.hour.toString() + ":" + gvakitler[seciliVakit].gunesdate.minute.toString(),
gvakitler[seciliVakit].ogledate.hour.toString() + ":" + gvakitler[seciliVakit].ogledate.minute.toString(),
gvakitler[seciliVakit].ikindidate.hour.toString() + ":" + gvakitler[seciliVakit].ikindidate.minute.toString(),
gvakitler[seciliVakit].aksamdate.hour.toString() + ":" + gvakitler[seciliVakit].aksamdate.minute.toString(),
gvakitler[seciliVakit].yatsidate.hour.toString() + ":" + gvakitler[seciliVakit].yatsidate.minute.toString(),
  ];

//pp





// selectedEzanvakti 
 Map<String, String> ezanVakitleriMap = {};

  for (int i = 0; i < ezanVakitleri.length; i++) {
    ezanVakitleriMap[ezanVakitleri[i]] = vakitDegerleri[i];
  }

    
    List<Widget> vakitler = [];

    for (int i = 0; i < ezanVakitleri.length; i++) {
      vakitler.add(
         StatefulBuilder(

            builder: (BuildContext context, StateSetter setState) {
print("yeniden build");
child:
       return GestureDetector(
                onTap: () {
                 
                },
                child:   Container(
          
          height: size.height * 0.25,
          width: size.width * 0.050,
          padding: EdgeInsets.all(13),
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
           color:  apf.selectedEzanvakti.value ==i ?    Color(0xFF004eff).withOpacity(0.8): Color(0xFF004eff).withOpacity(0.3)
          ,  boxShadow: [
               /*  BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ), */
              ],
            gradient:
            
             
                    apf.selectedEzanvakti.value ==i ?  
                     LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0, 1),
       colors: [
        Color(0xFF21367f),
        Color(0xFF194d91),
        Color(0xFF1590c1),
        Color(0xFF0298ca),
        Color(0xFF0298ca),
      ],
      stops: [0,0.28,0.88,1,1]
    )
   :  LinearGradient(
  begin: Alignment(0.0, 0.0),
        end: Alignment(0, 1),
        stops: [0,1]
,      colors: [
        Color(0xFF00A3FF),
        Color(0xFF004EFF),
      ]
    )
  ,
            borderRadius: BorderRadius.circular(10),
          ),
          child:
      
          
          
           Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Container(
          height: size.height * 0.040,
          width: size.width * 0.090,
          padding: EdgeInsets.all(1),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
          color:                 Color(0xFF004EFF).withOpacity(0.2),

            borderRadius: BorderRadius.circular(10),
          ),child: 
          
          Image.asset("assets/${iconlar[i]}",width: 35,height: 35,),
          ),
              Text(
                '${ezanVakitleri[i]}',
                style: TextStyle(
                  fontSize: size.width/ 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
                Text(
                '${ezanVakitleriMap[ezanVakitleri[i]]}',
                style: TextStyle(
                  fontSize: size.width/ 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
       );
    }));
    }


    return   GridView.count(
          crossAxisCount: 3, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.vertical,
                     physics: NeverScrollableScrollPhysics(),
 childAspectRatio: 0.8,
          shrinkWrap: false, // GridView'ın içeriği sığdırılabilir
          children: vakitler,
     
    );
  }
}


class CircularProgressBar extends StatelessWidget {
   double ? progress;
  final double radius;
  final double strokeWidth;



  
  final Color backgroundColor;
  final Color foregroundColor;
  final String tip;
        NamazVakitleri ? vakitveri;

  CircularProgressBar({

  

     this.progress,
    required this.tip,
    this.radius = 50.0,
    this.strokeWidth = 10.0,
    required this.backgroundColor, 
    required this.foregroundColor,
    required this.vakitveri

  });

  @override
  Widget build(BuildContext context) {
  
    List<Vakit> vakit = vakitveri!.vakitler;
    Vakit bugun = vakit[apf.selectedEzanvakti.value];
    // ayin kaçıncı günü 
    int ayinKacinciGunu = bugun.vakitTarih!.day;
    // yılın kaçıncı ayı
    int yilinKacinciAyi = bugun.vakitTarih!.month;
    // kalan gün
    // secili ayda kac gun var 
int daysInMonth = DateTimeRange(
                       start: bugun.vakitTarih!,
                       end: DateTime( bugun.vakitTarih.year,  bugun.vakitTarih.month + 1))
                    .duration
                    .inDays;
    int kalanGun =   daysInMonth;
        progress = 0.1;
    if (tip == "1") {
      progress = ayinKacinciGunu/3 / 30;
    } else if (tip == "2") {
      progress = yilinKacinciAyi/3 / 12;
    } else if (tip == "3") {
      progress = kalanGun/3 / 30;
    }
      double normalizedProgress = max(0, min(1, progress!)); // Progress'i 0 ile 1 arasında sınırla
    double angle = 1 * pi * normalizedProgress;
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: Stack(children: [ CustomPaint(
        painter: CircularProgressBarPainter(
          progress: angle,
          strokeWidth: strokeWidth,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
         
        ),
      child: Center(
            child: tip == "1" ?
            
            // 1. tip için

            Container(child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,

              children:[ Text(
              "Ayın" ,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            ),Text(
              "$ayinKacinciGunu." ,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: foregroundColor,

              ),
            ) ,Text(
              "Günü" ,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            )  ]) )
            
            
            : 
            
        
            tip == "2" ?     
             
            Container(child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,

              children:[ Text(
              "Yılın" ,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            ),Text(
              "$yilinKacinciAyi." ,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: foregroundColor,

              ),
            ) ,Text(
              "Ayı" ,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            )  ]) ): tip == "3" ?     
             
            Container(child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,

              children:[ Text(
              "Kalan" ,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            ),Text(
              "$kalanGun" ,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: foregroundColor,

              ),
            ) ,Text(
              "Gün" ,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            )  ]) ) : SizedBox() ,

            
          ), ),
   ]) );
  }
}
class CircularProgressBarPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;
  

  CircularProgressBarPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.foregroundColor,
    
  });

  @override
  void paint(Canvas canvas, Size size) {
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
  final cPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
  
    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * progress;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
        final image2 = AssetImage("assets/vakit2.png"); // ImageProvider kullanıyoruz

final imageResolver2 = image2.resolve(ImageConfiguration.empty);
imageResolver2.addListener(ImageStreamListener((info, synchronousCall) {
  final image2 = info.image;

     canvas.drawCircle(
      Offset(center.dx+2 + radius * cos(startAngle), center.dy + radius * sin(startAngle)),
    strokeWidth/1.5,
      cPaint,
    ); 
 // canvas.drawImage(image2,   Offset(center.dx + radius * cos(startAngle)-5, center.dy + radius * sin(startAngle) -10), Paint()); // Resmi çizdirme işlemi
final srcRect = Rect.fromPoints(
  Offset(center.dx + radius * cos(startAngle) - 6, center.dy - 10 + radius * sin(startAngle)),
  Offset(center.dx + radius * cos(startAngle) - 6 + image2.width.toDouble()*1.2, center.dy - 10 + radius * sin(startAngle) + image2.height.toDouble()*1.2),
);



 paintImage(
        canvas: canvas,
        rect: srcRect,
        image: image2,
        fit: BoxFit.cover);
  


  }));
    // Draw start and end icons
 

  canvas.drawCircle(
      Offset(center.dx+2 + radius * cos(startAngle + sweepAngle), center.dy + radius * sin(startAngle + sweepAngle)),
      strokeWidth/1.5,
      cPaint,
    );

        final image1 =AssetImage("assets/vakit1.png");
// ImageProvider kullanıyoruz


final imageResolver = image1.resolve(ImageConfiguration.empty);
imageResolver.addListener(ImageStreamListener((info, synchronousCall) {
  var image = info.image;
// Yeni yükseklik
final srcRect = Rect.fromPoints(
  Offset(center.dx + radius * cos(startAngle + sweepAngle) - 6, center.dy - 10 + radius * sin(startAngle + sweepAngle)),
  Offset(center.dx + radius * cos(startAngle + sweepAngle) - 6 + image.width.toDouble()*1.3, center.dy - 10 + radius * sin(startAngle + sweepAngle) + image.height.toDouble()*1.3),
);


 paintImage(
        canvas: canvas,
        rect: srcRect,
        image: image,
        fit: BoxFit.cover);
  

 // canvas.drawImage(image,  Offset(center.dx + radius * cos(startAngle + sweepAngle)-6, center.dy -10+ radius * sin(startAngle + sweepAngle))
 // , Paint()); // Resmi çizdirme işlemi
  
  }));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}class TirtikliLinearProgressIndicator extends StatelessWidget {
  final double progressValue; // 0 ile 100 arasında değer
    final TimerController timerController = Get.put(TimerController());

  TirtikliLinearProgressIndicator({required this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: 10, // İstediğiniz yükseklik
      width: 300, // İstediğiniz genişlik
      child: CustomPaint(
        painter:  TirtikliPainter( timerController.progress.value),
      ),
     ) );
  }
}
    final TimerController timerController = Get.put(TimerController());

class TirtikliPainter extends CustomPainter {
var progressValue = timerController.progress.value;

  TirtikliPainter(this.progressValue);

  @override
  void paint(Canvas canvas, Size size) {
double normalizedProgress = progressValue.clamp(0, 100).toDouble();
    final backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final filledPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.white],
        stops: [0.2, 0.8],
      ).createShader(Rect.fromLTWH(0, 1, size.width * (normalizedProgress / 100), size.height))
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 1, size.width, size.height), Radius.circular(5)),
      backgroundPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 1, size.width * (normalizedProgress / 100), size.height), Radius.circular(5)),
      filledPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class HadisKarti extends StatelessWidget {

  // İçerik bilgileri için değişkenler tanımlayalım
  final String baslik;
  final String icerik;
  final List<Color> renk;

   HadisKarti({
    required this.baslik,
    required this.renk,
    required this.icerik,
  });

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
    // Buraya kod parçasını yapıştıralım
     return Container(
decoration: BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(10)
),
padding: EdgeInsets.all(size.width * 0.01),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.010, size.width * 0.03, size.width * 0.005),
       
child:
Stack(children: [


Align(
 alignment: Alignment.center,
  
  child:
Container(
  decoration: BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(10)
),
  child:
 Row(children:[ 

  Expanded(
    flex: 1,
    child: Container(
      
      decoration: BoxDecoration(
         gradient: LinearGradient(
              colors: 
               renk
               
              
         
            ),
  color: Colors.white,
borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
    ),
),
      height: size.height * 0.25 *  ((icerik.length) / 222),

      child: Image .asset("assets/aicon.png"),
    ),



  ),
Expanded(
  flex: 3,
    child: Container(
      padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
  color: Colors.white,
 borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
                            padding: EdgeInsets.fromLTRB(1, 4, 1, 1),

          child:Text("$baslik",style: TextStyle(
          fontSize: size.width / 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ))),
        Container(
                            padding: EdgeInsets.fromLTRB(1, 2, 1, 1),
child:
       SizedBox(
        child: SingleChildScrollView(
          child: Text(" $icerik")))), 
          
          
       
            
            

    ],),
    ),



  )


  ]))
      
      
  ) ,Align(
 alignment: Alignment.topRight,
  
  child:
  Container(
          height: size.height * 0.05,
          width: size.width * 0.08,
          
  padding: EdgeInsets.all(2),
  margin: EdgeInsets.fromLTRB(0, 6,6, 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: renk  ,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),  
          child: Center(child:
Container(child:
SizedBox(child: 
GestureDetector(
  onTap: () {
     Share.share( "$baslik \n $icerik");
    print("tıklandı");
  },
  child:
     SvgPicture.asset("assets/share.svg",color:Colors.white ,height: 15,width:15 , fit: BoxFit.scaleDown ,) ,
),

)),
  )

))]));
  }

}
