
 import 'dart:math';
import 'dart:ui';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';
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
              backgroundImage: AssetImage("assets/imsak.jpg"),
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
  
 Vakit bugunubul( NamazVakitleri vakitveri ){
  List <Vakit> vakitler = vakitveri.vakitler;

  var today = DateTime.now();
    var formattedDate = DateFormat('dd.MM.yyyy').format(today);


    for(var i = 0; i < vakitler.length; i++) {
      print("vakit bulundu");
      if(vakitler[i].miladiTarihKisa == formattedDate) {
        return vakitler[i];
      }
    }
    print("bugun bulunamad");
      return vakitler[0];



 }
   
 


 
   
DateTime? enYakinVakitBul(DateTime suan, List<DateTime> vakitler) {
  int vakindex= 0;
  DateTime? enYakinVakit;
  int enKucukFark = 999999; 
  
  for (var vakit in vakitler) {
    
    if (vakit.isBefore(suan)) {
            vakindex = vakindex + 1;
            AppConfig.vakitstxt = vakindex;
print("vakindex" + vakindex.toString());
      continue; 
    }
    
    int fark = suan.difference(vakit).inSeconds.abs();
    
    if (fark < enKucukFark) {
      enKucukFark = fark;
      enYakinVakit = vakit;
    }
    
  }

  return enYakinVakit;
  
}
 vakithesaplailk( NamazVakitleri vakitveri){
  Vakit ilkgun = bugunubul(  vakitveri);
  print("ilk gün" + ilkgun.miladiTarihKisa.toString());
 DateTime suan= DateTime.now();
  
  DateTime imsak= ilkgun.imsakdate;
  DateTime gunes= ilkgun.gunesdate;
  DateTime ogle= ilkgun.ogledate;
  DateTime ikindi= ilkgun.ikindidate;
  DateTime aksam= ilkgun.aksamdate;
  DateTime yatsi= ilkgun.yatsidate;
DateTime? siradaki_vakit = enYakinVakitBul(suan, [imsak, gunes, ogle, ikindi, aksam, yatsi]);
 prayerTime.value = siradaki_vakit!.obs.value;

 return siradaki_vakit;

   }



var prayerTime = DateTime(2030, 10, 22, 10, 0, 0).obs;
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

    remainingTime.value = prayerTime.value.difference(currentTime.value); 
      String formattedTime = formatDuration(remainingTime.value);
        
  });

  ever(remainingTime, (_) {

  if (remainingTime.value.inSeconds <= 0) {

    // Bir sonraki vakte geçildi, uyarı ver
    
    print("Vakit değişti! Yeni vakit: ${AppConfig.vakitstxt}");
Vibration.vibrate(pattern: [500, 1000, 500, 2000]);

    // Bir sonraki vakte geç
    prayerTime.value = vakithesaplailk(vakitveri!);
Get.dialog(ImsakDialog());
playAssetSound ("ezan1.mp3", 10);
  }
  
});
}
}



 class AnaEk extends StatefulWidget {
    AnaEk({super.key});

  @override
  State<AnaEk> createState() => _AnaEkState();
}

class _AnaEkState extends State<AnaEk> {
 @override
    final TimerController timerController = Get.put(TimerController());

ColorController controller = Get.put(ColorController());

  List<Color> _colors = [ /*   Color(0xFF21367F).withOpacity(0.5), */
 /* Color(0xFF194D91).withOpacity(0.5), */
   Color(0xFF1590C1).withOpacity(0.5),
   Color(0xFF0298CA).withOpacity(0.5),
]; 
 // List of gradient colors
  int _currentColorIndex = 0; 

 late DateTime currentTime;
 var vakitstring= "Öğlenin Çıkmasına";
  late String selectedCity;

var siradakivakit;
  void initState() {
    super.initState();
  currentTime = DateTime.now();
    selectedCity = '${AppConfig.sehirname}'; // Başlangıçta seçilen şehir
controller.changeColor(); 

  }

  @override
  void dispose() {
    super.dispose();
  }

  


  Future<List> AnaekranFuture() async{
 
  AppConfig.sehirname;
  AppConfig.ilceid;
NamazVakitleri a= await NamazVakitleri.getNamazVakitleri(   AppConfig.ilceid);
print("leng" + a.vakitler.length.toString());
print("aha" + a.vakitler.toString());
// tarihler
var vakitler= a.vakitler;
for( Vakit a in vakitler){
  print("miladiTarihKisa" + a.miladiTarihKisa.toString());

}


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
   
    timerController.vakitveri =   snapshot.data![0];
        print("vakit veri");
        print(timerController.vakitveri );
  Vakit bugun = timerController.bugunubul( timerController.vakitveri!);

print("bugun" + bugun.miladiTarihKisa.toString());
 String vakitstring="Vakte ";
if(  AppConfig.vakitstxt == 0){
   vakitstring= "İmsak Vaktine";
}
if(  AppConfig.vakitstxt == 1){
   vakitstring= "Güneşin Doğmasına";
}
if(  AppConfig.vakitstxt == 2){
   vakitstring= "Öğlenin Çıkmasına";
}
if(  AppConfig.vakitstxt == 3){
   vakitstring= "İkindinin Çıkmasına";
}
if(  AppConfig.vakitstxt == 4){
   vakitstring= "Akşamın Çıkmasına";
}
if(  AppConfig.vakitstxt == 5){
   vakitstring= "Yatsının Çıkmasına";
}

 
DateTime ? siradakivakit =timerController.vakithesaplailk( timerController.vakitveri!); 

    double progressValue = 1 - (timerController.remainingTime.value.inSeconds / Duration(hours: 1).inSeconds);

     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
double normalizedValue = progressValue / 100.0;

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
          height: size.height * 0.195,
          width: size.width * 0.8,
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
             
              Text(
        "$vakitstring",
                 textAlign: TextAlign.center,

        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )  ]),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start, // Orta hizalamalı olarak değiştiriyoruz
              crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() =>   Text(
                timerController.remainingTime.value.inHours.toString() + " : ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              )),
              Center(child: Text(
              
              textAlign:TextAlign.center, 
                "saat",
                style: TextStyle(fontSize: 11, color: Colors.white),
              )),
            ],
          ),
        
          Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
           Obx(() =>   Text(
     

                timerController.remainingTime.value.inMinutes.remainder(60).toString() +" : ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ) ),
              Text(
                "dakika",
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            ],
          ),
       
          Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

              mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Obx(() =>    Text(
                 timerController.remainingTime.value.inSeconds.remainder(60).toString() ,
            
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
             )),
              Text(
                textAlign: TextAlign.center,
                "saniye",
                style: TextStyle(fontSize: 11, color: Colors.white),
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
      
TirtikliLinearProgressIndicator(progressValue: 30),
            
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
      ),
    
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
          height: size.height * 0.11,
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
          height: size.height * 0.39,
          width: size.width * 0.8,
          margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.005, size.width * 0.05, size.width * 0.005),
       child:  EzanVakitleri( vakitveri : timerController.vakitveri!),

      
        
            

      
      
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

               baslik: "Vakit Hadisi",icerik: "Resulullah (sav) buyurdular ki: “İnsanların en hayırlısı, ailesine karşı en hayırlı olanıdır. Ben de aileme karşı en hayırlı olanınızım.” (Tirmizi, Menakıb, 67)",

 
      
       
      
      )),

 SliverToBoxAdapter(
      child:  HadisKarti( renk : [   Color(0xFF21D884).withOpacity(1),
                Color(0xFF005510).withOpacity(1) ],
               baslik: "Vakit Hadisi",icerik: "Resulullah (sav) buyurdular ki: “İnsanların en hayırlısı, ailesine karşı en hayırlı olanıdır. Ben de aileme karşı en hayırlı olanınızım.” (Tirmizi, Menakıb, 67)",

 
      
       
      
      )), SliverToBoxAdapter(
      child:  HadisKarti( renk : [ 
      Color(0xFF0c1732),
      Color(0xFF65b2ff),
    ],
               baslik: "Vakit Hadisi",icerik: "Resulullah (sav) buyurdular ki: “İnsanların en hayırlısı, ailesine karşı en hayırlı olanıdır. Ben de aileme karşı en hayırlı olanınızım.” (Tirmizi, Menakıb, 67)",

 
      
       
      
      )),


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
  margin: EdgeInsets.fromLTRB(40, 1, 0, 1),
  
  child:
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

Text("Erkek İsim: AHMET",style: TextStyle(
  
)),
 Text("Çok övülmüş , methedilmiş",style: TextStyle( 
   fontSize: 12,
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
  margin: EdgeInsets.fromLTRB(1, 1, 40, 1),
  
  child:
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

Text("Kız İsim: Azize",style: TextStyle(
  
)),
 Text("Sevgili, izzetli , nurlu,dost",style: TextStyle( 
   fontSize: 12,
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:  AppConfig.selectedaygunIndex == i ?         Colors.white        : Color(0xFF004eff)  ,
                ),
              ),
              Text(
              
                DateFormat('MMMM', 'tr_TR').format(gunler[i].vakitTarih!), // Ayı türkçe olarak yazdırıyoruz
                style: TextStyle(
                  fontSize: 12,
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
    EzanVakitleri({Key? key,   
required this.vakitveri
    }) : super(key: key);
    

  @override
  Widget build(BuildContext context) {
           var size = MediaQuery.of(context).size;
   int seciliVakit = AppConfig.selectedEzanvakti;

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



for (int i = 0; i < gvakitler.length; i++) {
 print("aha imsak" + gvakitler[i].imsak);
}

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
print("yeniden");
child:
       return GestureDetector(
                onTap: () {
                  setState(() {
                    AppConfig.selectedEzanvakti=i;
                    print("tikladin");
                    
                  });
                },
                child:   Container(
          
          height: size.height * 0.18,
          width: size.width * 0.050,
          padding: EdgeInsets.all(13),
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
           color:  AppConfig.selectedEzanvakti ==i ?    Color(0xFF004eff).withOpacity(0.8): Color(0xFF004eff).withOpacity(0.3)
          ,  boxShadow: [
               /*  BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ), */
              ],
            gradient:
            
             
                    AppConfig.selectedEzanvakti ==i ?  
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
                Text(
                '${ezanVakitleriMap[ezanVakitleri[i]]}',
                style: TextStyle(
                  fontSize: 22,
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
    Vakit bugun = vakit[AppConfig.selectedEzanvakti];
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

  TirtikliLinearProgressIndicator({required this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10, // İstediğiniz yükseklik
      width: 300, // İstediğiniz genişlik
      child: CustomPaint(
        painter: TirtikliPainter(progressValue),
      ),
    );
  }
}

class TirtikliPainter extends CustomPainter {
  final double progressValue;

  TirtikliPainter(this.progressValue);

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final filledPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.white],
        stops: [0.2, 0.8],
      ).createShader(Rect.fromLTWH(0, 0, size.width * (progressValue / 100), size.height))
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(5)),
      backgroundPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width * (progressValue / 100), size.height), Radius.circular(5)),
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
        height: size.height * 0.20,
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
      height: size.height * 0.20,

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
      height: size.height * 0.22,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
                            padding: EdgeInsets.fromLTRB(1, 4, 1, 1),

          child:Text("$baslik",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ))),
        Container(
                            padding: EdgeInsets.fromLTRB(1, 2, 1, 1),
child:
       SizedBox(
        height: size.height * 0.095,
        child: SingleChildScrollView(
          child: Text(" $icerik")))), 
          
          
          Align(
            
            alignment: Alignment.bottomLeft,
            
            child: Container(
              height: size.height * 0.034,
              child:  TextButton(
              
            child: Text("Devamını Oku",style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        )),
            
         
            onPressed: (){

            },)))
            
            

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
     SvgPicture.asset("assets/share.svg",color:Colors.white ,height: 15,width:15 , fit: BoxFit.scaleDown ,) ,
)),
  )

))]));
  }

}
