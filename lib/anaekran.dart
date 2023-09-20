
 import 'dart:math';
import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:namazvakti/config.dart';
import 'dart:math';

 import 'wrapper.dart';

 import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tarih biçimlendirme için

 // It is assumed that all messages contain a data field with the key 'type'
 
 class AnaEk extends StatefulWidget {
    AnaEk({super.key});

  @override
  State<AnaEk> createState() => _AnaEkState();
}

class _AnaEkState extends State<AnaEk> {
 @override
  

  List<Color> _colors = [ /*   Color(0xFF21367F).withOpacity(0.5), */
 /* Color(0xFF194D91).withOpacity(0.5), */
   Color(0xFF1590C1).withOpacity(0.5),
   Color(0xFF0298CA).withOpacity(0.5),
]; 
 // List of gradient colors
  int _currentColorIndex = 0; 
 // Index of the current color
  late Timer _timer; 

 // Timer for changing colors
 late DateTime currentTime;
 var vakitstring= "Öğlenin Çıkmasına";
  late String selectedCity;
  final DateTime prayerTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 0, 0); // Öğle namazı saati, örnek olarak 13:00:00 olarak alındı.
void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (currentTime.isBefore(prayerTime)) {
          currentTime = currentTime.add(Duration(seconds: 1));
        } else {
          timer.cancel();
        }
      }),
    );
  }
  void initState() {
    super.initState();
  currentTime = DateTime.now();
    selectedCity = 'Gaziantep'; // Başlangıçta seçilen şehir
    _startTimer();

    // Initialize the timer to change colors every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {
    // Hesaplamalar
    Duration remainingTime = prayerTime.difference(currentTime);
    int hours = remainingTime.inHours;
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);
    double progressValue = 1 - (remainingTime.inSeconds / Duration(hours: 1).inSeconds);

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
SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
            Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.white, width: 1), // Beyaz ince çerçeve ekleme
    color: Colors.transparent,
  ),
  padding: EdgeInsets.all(12.0),
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
              Text(
                hours.toString().padLeft(2, '0') + " : ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
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
              Text(
                minutes.toString().padLeft(2, '0') +" : ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
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
              Text(
                seconds.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
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
    items: <String>['Gaziantep', 'Ankara', 'Konya', 'Aydın']
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
   Text("27 mart 1997",style:TextStyle(
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
   Text("27 mart 2016",style:TextStyle(
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
       child:  AyGunleriWidget(),

      
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
       child:  EzanVakitleri(),

      
            ),
            ),
              SliverToBoxAdapter(
      child: Container(
        height: size.height * 0.20,
child:                      Row(
  
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

  children:[  CircularProgressBar(tip:"1" ,progress: 1 / 12 ,
  backgroundColor: Colors.white.withOpacity(0.2),  
  foregroundColor: Colors.blue.withOpacity(0.8)
  
  ),
 CircularProgressBar( backgroundColor:Colors.white.withOpacity(0.2), 
  foregroundColor: Colors.deepPurple ,tip :"2",progress: 1 / 32), CircularProgressBar( backgroundColor:    Colors.white.withOpacity(0.2),  

  foregroundColor: Colors.orange ,tip : "3",progress: 1 / 44),

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
      child:  HadisKarti( renk : [   Color(0xFF21D884).withOpacity(1),
                Color(0xFF005510).withOpacity(1) ],
               baslik: "Vakit Hadisi",icerik: "Resulullah (sav) buyurdular ki: “İnsanların en hayırlısı, ailesine karşı en hayırlı olanıdır. Ben de aileme karşı en hayırlı olanınızım.” (Tirmizi, Menakıb, 67)",

 
      
       
      
      )),

 SliverToBoxAdapter(
      child:  HadisKarti( renk : [   Color(0xFF21D884).withOpacity(1),
                Color(0xFF005510).withOpacity(1) ],
               baslik: "Vakit Hadisi",icerik: "Resulullah (sav) buyurdular ki: “İnsanların en hayırlısı, ailesine karşı en hayırlı olanıdır. Ben de aileme karşı en hayırlı olanınızım.” (Tirmizi, Menakıb, 67)",

 
      
       
      
      )), SliverToBoxAdapter(
      child:  HadisKarti( renk : [   Color(0xFF21D884).withOpacity(1),
                Color(0xFF005510).withOpacity(1) ],
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
        height: size.height * 0.17,
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
  alignment: Alignment.topLeft,
child: Container(
  padding: EdgeInsets.all(1),
  child: Image .asset("assets/er.png",width: 100,height: 100,fit: BoxFit.cover,),

          )),
   
   Align(
  alignment: Alignment.center,
    
    child: 
   Container(
       
        height: 100,
        decoration: BoxDecoration(
  color:   Color(0xFFFF702C). withOpacity(0.2), 
  borderRadius: BorderRadius.circular(10)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.005, size.width * 0.03, size.width * 0.005),
   )),  Align(
  alignment: Alignment.center,
child: Container(child:
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
        height: 200,

      ))
          
  ],
)
            ),




         
           );
    }}


 
class AyGunleriWidget extends StatefulWidget {
    AyGunleriWidget({Key? key,   

    }) : super(key: key);
    
  
  @override

  State<AyGunleriWidget> createState() => _AyGunleriWidgetState();
}

class _AyGunleriWidgetState extends State<AyGunleriWidget> {
  @override
    

var  isSelected = false;
  Widget build(BuildContext context) {
           var size = MediaQuery.of(context).size;
 
    DateTime now = DateTime.now();
    int ay = now.month;
    int yil = now.year;
    int gunSayisi = DateTime(yil, ay + 1, 0).day;
   
    List<Widget> gunListesi = [];
    
    for (int gun = 1; gun <= gunSayisi; gun++) {

      gunListesi.add(
        GestureDetector(
          onTap: () {
            print('$gun');
           setState(() {
        AppConfig.selectedaygunIndex =  gun;   });

          
          },
          child:
        Container(
          height: size.height * 0.050,
          width: size.width * 0.050,
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            gradient:
             AppConfig.selectedaygunIndex == gun ?
            
             LinearGradient(
              colors: [
                Color(0xFFffffff),
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
                '$gun',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:  AppConfig.selectedaygunIndex == gun ?         Colors.white        : Color(0xFF004eff)  ,
                ),
              ),
              Text(
                DateFormat('MMMM', 'tr_TR').format(now), // Ayı türkçe olarak yazdırıyoruz
                style: TextStyle(
                  fontSize: 12,
                  color:  AppConfig.selectedaygunIndex == gun ?   Colors.white : Colors.black ,
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

  List<String> vakitDegerleri = [
    '05:45',
    '05:45',
    '05:45',
    '05:45',
    '05:45',
    '05:45',
  ];
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
            boxShadow: [
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
              colors:
              
                          [
                Color(0xFF21367f).withOpacity(0.1), Color(0xFF194d91).withOpacity(0.28),
               Color(0xFF1590c1).withOpacity(0.88), Color(0xFF0298ca).withOpacity(1), Color(0xFF0298ca).withOpacity(1), 


                
                  
              ],
           begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
            ) :  LinearGradient(
              colors:
              
                          [

                Color(0xFF00a3ff).withOpacity(0.2), Color(0xFF004eff).withOpacity(0.4),

              ],
           begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
            ) ,
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
  final double progress;
  final double radius;
  final double strokeWidth;



  
  final Color backgroundColor;
  final Color foregroundColor;
  final String tip;
  CircularProgressBar({
    required this.progress,
    required this.tip,
    this.radius = 50.0,
    this.strokeWidth = 10.0,
    required this.backgroundColor, 
    required this.foregroundColor
  });

  @override
  Widget build(BuildContext context) {
    double normalizedProgress = max(0, min(1, progress)); // Progress'i 0 ile 1 arasında sınırla
    double angle = 2 * pi * normalizedProgress;

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
              "13." ,
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
              "12." ,
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
              "12" ,
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
      Offset(center.dx + radius * cos(startAngle), center.dy + radius * sin(startAngle)),
      strokeWidth /2,
      backgroundPaint,
    ); 
  canvas.drawImage(image2,   Offset(center.dx + radius * cos(startAngle)-5, center.dy + radius * sin(startAngle) -10), Paint()); // Resmi çizdirme işlemi
  

  }));
    // Draw start and end icons
 

  canvas.drawCircle(
      Offset(center.dx + radius * cos(startAngle + sweepAngle), center.dy + radius * sin(startAngle + sweepAngle)),
      strokeWidth /2,
      backgroundPaint,
    );
        final image1 = AssetImage("assets/vakit1.png"); // ImageProvider kullanıyoruz

final imageResolver = image1.resolve(ImageConfiguration.empty);
imageResolver.addListener(ImageStreamListener((info, synchronousCall) {
  final image = info.image;

 
  canvas.drawImage(image,  Offset(center.dx + radius * cos(startAngle + sweepAngle)-6, center.dy -10+ radius * sin(startAngle + sweepAngle)) , Paint()); // Resmi çizdirme işlemi
  
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
