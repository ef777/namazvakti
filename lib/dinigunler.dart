
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


     final controller = Get.put(AppConfig()); //<---

 class DiniGunlerView extends StatefulWidget {
    DiniGunlerView({super.key});

  @override
  State<DiniGunlerView> createState() => _DiniGunlerViewState();
}

class _DiniGunlerViewState extends State<DiniGunlerView> {
 @override
 
List<Widget> ozelgunlerwidgets = [];

List<Map<String,String>> ozelgunler = [

{

 "d_id" : "1",
 "m_tarih_ay" : "şubat" ,
  "m_tarih_gun" : "02" ,
 "m_tarih_yil" : "2023" ,
 "m_tarih_hafta" : "sali" ,

 "h_tarih_yil" : "1443" ,
  "h_tarih_gun" : "01" ,
 "h_tarih_isim" : "receb" ,

 "aciklama": "aciklama"
},
{

 "d_id" : "2",
 "m_tarih_ay" : "şubat" ,
  "m_tarih_gun" : "02" ,
 "m_tarih_yil" : "2023" ,
 "m_tarih_hafta" : "sali" ,

 "h_tarih_yil" : "1443" ,
  "h_tarih_gun" : "01" ,
 "h_tarih_isim" : "receb" ,

 "aciklama": "aciklama"
},


];

  void initState() {
    super.initState();
  
   
  }

  @override
  void dispose() {
    super.dispose();
  }
   @override
   Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
   ozelgunlerwidgets=[];
 for (int i = 0; i < ozelgunler.length; i++) {
      ozelgunlerwidgets.add(
        
             Obx(
  () =>   OzelGunTile( 
                  secili : controller.selecteddinigun == int.parse (ozelgunler[i]['d_id'].toString()) ? true : false,
                  m_tarih_ay: ozelgunler[i]['m_tarih_ay'].toString(),
                  m_tarih_gun: ozelgunler[i]['m_tarih_gun'].toString(),
                  m_tarih_hafta: ozelgunler[i]['m_tarih_hafta'].toString(),
                  m_tarih_yil: ozelgunler[i]['m_tarih_yil'].toString(),
                  h_tarih_yil: ozelgunler[i]['h_tarih_yil'].toString(),
                  h_tarih_gun: ozelgunler[i]['h_tarih_gun'].toString(),
                  h_tarih_isim: ozelgunler[i]['h_tarih_isim'].toString(),
                  aciklama : ozelgunler[i]['aciklama'].toString(),
                  idim: ozelgunler[i]['d_id'].toString(),
               

                )

      
    ));
    } 
     return 
     
      Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 237, 240),

            appBar: AppBar(
    
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Get.toNamed('/'),
          ),
        ],
        centerTitle: false,
        title: 
        
     Center(child:  Image.asset("assets/baslik.png",)) 
      
     ),
         
         body:   CustomScrollView(
          shrinkWrap: true,

  slivers: [
    


  SliverToBoxAdapter(
      child:Center(child: Container(
        color: Colors.transparent,
           padding: EdgeInsets.all(2.0),
         /*  height: size.height * 0.11,
          width: size.width * 0.8, */
          margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.01, size.width * 0.02, size.width * 0.01),
     
        child: Text("Dini Günler Ve Geceler", style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        ),

    )  )),
 SliverToBoxAdapter(  
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
      child: GridView.count(
          padding: EdgeInsets.all(5.0),
           crossAxisSpacing: 10,
           mainAxisSpacing: 10,
        childAspectRatio: 3.2,
          crossAxisCount: 1, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.vertical,

          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: ozelgunlerwidgets,  
        
          )
      ), 
  ] ),
      )
      ;
    }
  }

    class AyGunleriWidget extends StatefulWidget {
  @override
  State<AyGunleriWidget> createState() => _AyGunleriWidgetState();
}

class _AyGunleriWidgetState extends State<AyGunleriWidget> {
var gunlerwidgets;

  @override
  Widget build(BuildContext context) {
           var size = MediaQuery.of(context).size;

    DateTime now = DateTime.now();
        int YilSayisi = 10;

    int yil = now.year;
    List<int> yillistesayi=[];
    for(var i=0; i<=YilSayisi; i++)  {
      
      yillistesayi.add(yil+i);
      
      
    }

    List<Widget> yilListesi = [];

    for (int i = 0; i <= YilSayisi; i++) {
      yilListesi.add(
       
       
       GestureDetector(
        
        
        onTap:  () {

      AppConfig.selecteddiniyil=    yillistesayi[i];
      setState(() {
        
      });
        },
        child: Container(
          height: size.height * 0.050,
          width: size.width * 0.050,
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            gradient:
            
             AppConfig.selecteddiniyil ==yillistesayi[i] ?
             LinearGradient(
              colors: [
                Color(0xFF21367F),
                Color(0xFF194D91),
                Color(0xFF1590C1),
                Color(0xFF0298CA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ):  LinearGradient(
              colors: [
               Colors.white,
                Colors.white,
               
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             
             
              Text(
                '${yillistesayi[i]}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:   AppConfig.selecteddiniyil ==yillistesayi[i] ?  Colors.white : Colors.blue,
                ),
              ),
            
            ],
          ),
        ),
      ));
    }
// burasıda normak tile

gunlerwidgets=[];

return   GridView.count(
          crossAxisCount: 1, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.horizontal,

          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: yilListesi,
     
    );
  }
}

class OzelGunTile extends StatefulWidget {

final String idim;
final String m_tarih_ay;
final String m_tarih_gun;
final String m_tarih_hafta;
final String m_tarih_yil;
final String aciklama;
final String h_tarih_yil;
final String h_tarih_gun;
final String h_tarih_isim;
final bool secili;


      OzelGunTile({Key? key,  
      required this.secili,
    required this.m_tarih_ay,
        required this.m_tarih_gun,
    required this.m_tarih_hafta,
    required this.m_tarih_yil,

    required this.h_tarih_yil,
    required this.h_tarih_gun,
    required this.h_tarih_isim,

    required this.aciklama,
    required this.idim,
    }) : super(key: key);
     
      @override
      _OzelGunTileState createState() => _OzelGunTileState();
    }
      
    class _OzelGunTileState extends State<OzelGunTile> {
      @override
      Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;
void _showBottomSheet() {

  showModalBottomSheet(
    
    context: context,
    isScrollControlled: true, 
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 200,
          width:  400,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white.withOpacity(0)]
            )
          ),
          child: Stack(
            children: [
              // Arka plan
              Container(color: Colors.white.withOpacity(0.8)), 
              
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  
                    Text('Başlık'),
                    
                    SizedBox(height: 16),
                    
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Tamam'),
                    ),
                    
                  ],
                ),
              )
            ],  
          ),
        ),
      );
    },
  );
  
}
        return
        
        GestureDetector(
          onTap: () {
              controller.selecteddinigun.value =int.parse (widget.idim);
              print("özel hün serçildi");
              print(controller.selecteddinigun);
              _showBottomSheet();
//
          },
          child:Container(
           
            child: 
          Stack(children: [
Align(
  alignment: Alignment.centerLeft,

 child: Container(
  margin:   
  EdgeInsets.only(
    left: size.width*0.05,
   ),
  width: 1, 
  height: size.height * 0.34,
 color: Colors.grey.withOpacity(0.4),

 )

),
Align(
 alignment: Alignment.centerLeft,
  
  child:
  Container(
          height: size.height * 0.10,
          width: size.width * 0.10,
          
  padding: EdgeInsets.all(0),
  margin: EdgeInsets.fromLTRB(0, 0,0, 0),
          decoration: BoxDecoration(
                shape: BoxShape.circle
,
            gradient: 
            
                          controller.selecteddinigun ==int.parse (widget.idim) ?
            LinearGradient(
              colors: [
                Color(0xFF21367F),
                Color(0xFF194D91),
                Color(0xFF1590C1),
                Color(0xFF0298CA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ): LinearGradient(
              colors: [
               
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(child:
Container(child:

Text(widget.idim,style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color:  controller.selecteddinigun ==int.parse (widget.idim) ? Colors.white : Colors.white
        ), )

))),
  ),


        
         Container(

height: size.height * 0.20,
 
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(10),
              color: controller.selecteddinigun ==int.parse (widget.idim) ?  Colors.transparent : Colors.black.withOpacity(0.1),
              border: Border.all(
                color: controller.selecteddinigun ==int.parse (widget.idim) ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),

        margin: EdgeInsets.fromLTRB(
              size.width * 0.135, size.width * 0.05, size.width * 0.05, size.width * 0.005),
child:
Stack(children: [


Align(
 alignment: Alignment.center,
  
  child:
Container(
  margin: EdgeInsets.all(0),
  decoration: BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(20)
),
  child:
 Row(children:[ 

Expanded(
  flex: 1,
    child: Container(
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.fromLTRB(size.width*0.05 
      , size.height*0.010 , size.width*0.05 , size.height*0.010 ),
          decoration: BoxDecoration(
  color: Colors.transparent,
 borderRadius: BorderRadius.only(
     
    ),
),
      height: size.height * 0.22,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
                            padding: EdgeInsets.fromLTRB(1, 4, 1, 1),

          child:Text("${widget.h_tarih_gun + " "+ widget.h_tarih_isim + " "  + widget.h_tarih_yil } ",style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        color:  controller.selecteddinigun ==int.parse (widget.idim) ? Colors.black : Colors.black,
        ))),
       
       Container(
                                    padding: EdgeInsets.fromLTRB(1, 2, 1, 1),

        height: size.height * 0.03,
        child: SingleChildScrollView(
          child: Text("${widget.aciklama}",style: TextStyle(
            color: controller.selecteddinigun ==int.parse (widget.idim) ? Colors.black : Colors.black,
            fontSize: 14,)
            ),
        )
          ),
        
            
            

    ],),
    ),



  ),Align(
  alignment: Alignment.center,

 child: Container(
  margin: 
  EdgeInsets.fromLTRB(size.width*0.01, size.height*0.01, size.width*0.0, size.height*0.01),
  width: 1, 
  height: size.height*0.04,
 color: controller.selecteddinigun ==int.parse (widget.idim) ? Colors.white.withOpacity(0.2) : Colors.black,

 )

),

  Expanded(
    flex: 1,
    child: Container(
      
    
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
    gradient:  controller.selecteddinigun ==int.parse (widget.idim) ? LinearGradient(
      begin: Alignment(0.00, 0.00),
      end: Alignment(1.00, 0.00),
      colors: [
        const Color(0xFF21367F),
        const Color(0xFF194D91),
        const Color(0xFF1590C1),
        const Color(0xFF0298CA),
        const Color(0xFF0298CA),
      ],
      stops: [0.00, 0.2834, 0.8794, 0.9951, 1.00],
    ):LinearGradient(
      begin: Alignment(0.00, 0.00),
      end: Alignment(1.00, 0.00),
      colors: [
        Colors.transparent,
         Colors.transparent,
      
     
      ],
      stops: [0.00, 0.2834],
    ),
  ),

      height: size.height * 0.20,

      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(widget.m_tarih_gun 
+ " " + widget.m_tarih_ay,
          style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color:  controller.selecteddinigun ==int.parse (widget.idim) ? Colors.white : Colors.black,
          )          
          )
          ,Text(widget.m_tarih_yil +" " +widget.m_tarih_hafta,     style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color:  controller.selecteddinigun ==int.parse (widget.idim) ? Colors.white : Colors.black,
          )           
          ),
          Icon(

            Icons.info,
            color:  controller.selecteddinigun ==int.parse (widget.idim) ? Colors.white : Colors.black,
            size: 17,
          )
          
        ],
      )
    ),



  ),

  ]))
      
      
  ) ,

]))


  ])
           
          ,)
);
      }
    }
