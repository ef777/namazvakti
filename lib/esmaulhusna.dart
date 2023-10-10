
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


 
 class EsmaUl extends StatefulWidget {
    EsmaUl({super.key});

  @override
  State<EsmaUl> createState() => _EsmaUlState();
}

class _EsmaUlState extends State<EsmaUl> {
 @override
List<Widget> Esmawidgets = [];
  
List<Map<String,String>> Esma = [

{


 "id" : "1" ,
  "title" : "El-Kuddûs" ,
 "sesurl" : "sesurl" ,
 "i_url" : "esmaul.svg" ,

 "aciklama": "Her türlü çirkinlik ve ayıplardan uzak,tertemiz"
},

{

 "i_url" : "esmaul.svg" ,
 "id" : "2" ,
  "title" : "El-Kuddûs" ,
 "sesurl" : "sesurl" ,

 "aciklama": "Her türlü çirkinlik ve ayıplardan uzak,tertemiz"
},


];
     final controller = Get.put(AppConfig()); //<---

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
Esmawidgets = [];
 for (int i = 0; i < Esma.length; i++) {
      Esmawidgets.add(
        
                Esma_Tile( 
                  i_url: Esma[i]['i_url'].toString(),
                  sesurl: Esma[i]['sesurl'].toString(),
                  title: Esma[i]['title'].toString(),
                  aciklama : Esma[i]['aciklama'].toString(),
                  id: Esma[i]['id'].toString(),
               

                )

      
    );
    } 
     return Scaffold(
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
     
        child: Text("Esma-Ül Hüsna", style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        ),

    )  )),
 
SliverToBoxAdapter(
      child:  GridView.count(
          padding: EdgeInsets.all(5.0),
           crossAxisSpacing: 10,
           mainAxisSpacing: 10,
        childAspectRatio: 3.5,
          crossAxisCount: 1, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.vertical,

          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: Esmawidgets,  
        
          ))
       
  ] ),
      )
      ;
    }
  }

  
class Esma_Tile extends StatefulWidget {

final String id;
final title;
final aciklama;
final sesurl;
final i_url;


      Esma_Tile({Key? key,  
required this.i_url,
 required this.aciklama,
 required this.title,
 required this.sesurl,
    required this.id,
    }) : super(key: key);
     
      @override
      _Esma_TileState createState() => _Esma_TileState();
    }
      
    class _Esma_TileState extends State<Esma_Tile> {
   
          var controller = Get.put(AppConfig()); //<---
      @override
      Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;
  // controller.selectedesmaulhusna.value == int.parse(widget.id) ? true : false;
        return
        
     GestureDetector(
          onTap: () {
           controller.esmaulhusnaidDegistir( int.parse(widget.id));
                       
  Future.delayed(const Duration(milliseconds: 500), () {
             
                          
             Future.delayed(const Duration(milliseconds: 1000), () {
              controller.esmaulhusna_play_Degistir( int.parse(widget.id));
             });
             });
       },

          
          
          child:   Obx(() =>   Container(child: 
    

Align(
 alignment: Alignment.center,
  
  child:(controller.selectedesmaulhusna_player.value == int.parse(widget.id) ? true : false)
 ? Container(
  padding: EdgeInsets.all(10.0),
  margin: EdgeInsets.fromLTRB(size.width*0.05 , size.height*0.01 , size.width*0.05 , size.height*0.01 ),
  decoration: BoxDecoration(
    
     boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 19.5,
      )
    ],
     
     gradient: (controller.selectedesmaulhusna.value == int.parse(widget.id) ? true : false) ? LinearGradient(
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
    ):    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(1, 0),
      colors: [
        Color(0xFFD1E8FF),
        Color(0xFFE5E5E5),
      ]
    )  ,
  color: Colors.white,
  borderRadius: BorderRadius.circular(20)
),
  child:
 Row(children:[ 
Expanded(
  flex: 1,
    child: 
  Container(
          height: size.height * 0.09,
          width: size.width * 0.09,
          
  padding: EdgeInsets.all(7),
  margin: EdgeInsets.fromLTRB(5, 5,5, 5),
          decoration: BoxDecoration(
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
                shape: BoxShape.circle
,
          color: Colors.white
          ),
          child: Center(child:
Container(
  
        
  
  child:

Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30,)


))), 
       

 ),
       
            
        
    
    



  


  Expanded(
    flex: 3,
    child: Container(
      
    
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
   
  ),

      height: size.height * 0.10,

      child:  Column(
        children: [

          Text(widget.title
+ " " ,
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          )          
          ),
            Text("sesi dinlemek için tıklayın"
         , style: TextStyle(
          fontSize: 10,
          color: Colors.white,
          )          
          ),
          Row(
            children: [
              Container(child:
           LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
               ) ),
  ])
        ],
      )
    ),



  ),

  ]))
    :
Container(
  padding: EdgeInsets.all(10.0),
  margin: EdgeInsets.fromLTRB(size.width*0.05 , size.height*0.01 , size.width*0.05 , size.height*0.01 ),
  decoration: BoxDecoration(
    
     boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 19.5,
      )
    ],
     
     gradient: (controller.selectedesmaulhusna.value == int.parse(widget.id) ? true : false) ? LinearGradient(
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
    ):    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(1, 0),
      colors: [
        Color(0xFFD1E8FF),
        Color(0xFFE5E5E5),
      ]
    )  ,
  color: Colors.white,
  borderRadius: BorderRadius.circular(20)
),
  child:
 Row(children:[ 

Expanded(
  flex: 1,
    child: Container(
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.fromLTRB(size.width*0.02
      , size.height*0.012 , size.width*0.02 , size.height*0.012 ),
          decoration: BoxDecoration(
  color: Colors.transparent,
 borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
),
      height: size.height * 0.25,
      width: size.width * 0.25,
      child:
       
 SvgPicture.asset(
  "assets/${widget.i_url}",
  semanticsLabel: 'Acme Logo',
  width: 60,
  height: 60,
  color: Colors.black,
 )

 ),
       
            
            

    
    



  ),


  Expanded(
    flex: 3,
    child: Container(
      
    
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
   
  ),

      height: size.height * 0.10,

      child:  Column(
        children: [ 

          Text(widget.title
+ " " ,
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color:   (controller.selectedesmaulhusna.value == int.parse(widget.id) ? true : false) ? Colors.white :Colors.black,
          )          
          )
          ,Text(widget.aciklama ,     style: TextStyle(
          fontSize: 12,
          color:  (controller.selectedesmaulhusna.value == int.parse(widget.id) ? true : false) ? Colors.white :Colors.black,
          )           
          ),
        
          
        ],
      )
    ),



  ),

  ]))
      
      
  ) ,




  
           
          )
));
      }
    }
