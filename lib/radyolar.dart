
 import 'dart:math';
import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:namazvakti/dualar.dart';
import 'dart:math';

 import 'wrapper.dart';

 import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tarih biçimlendirme için




class RoundIconButton extends StatelessWidget {

  final double size;
  final VoidCallback onPressed;
  final String ?iconAsset;
  final String ?text; // zorunlu

   RoundIconButton({
    required this.size,
    required this.onPressed,
    this.iconAsset,
    this.text,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
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
        shape: BoxShape.circle,
      ),
      child: 
      
      iconAsset == null ?  Center (child: Text(text!,
      
      textAlign: TextAlign.center,
       style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),)) :
      IconButton(
        icon: SvgPicture.asset(
          iconAsset!,
          width: 21,
          height: 21,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
List<Map<String, String>> radyolistesi = [
 
  {  
    'icon': "pusula.png",
    'title': 'lorem ipsum', 
    'aciklama' :'lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum.',
    'd_id': '1'
  }, {  
    'icon': "pusula.png",
    'title': 'lorem ipsum2', 
    'aciklama' :'Lorem İpsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum',
    'd_id': '2'
  }, ];


 // It is assumed that all messages contain a data field with the key 'type'
 
 class Radyolar extends StatefulWidget {
    Radyolar({super.key});

  @override
  State<Radyolar> createState() => _RadyolarState();
}

class _RadyolarState extends State<Radyolar> {
 @override
  
  List<Color> _colors = [ /*   Color(0xFF21367F).withOpacity(0.5), */
 /* Color(0xFF194D91).withOpacity(0.5), */
   Color(0xFF1590C1).withOpacity(0.5),
   Color(0xFF0298CA).withOpacity(0.5),
]; 

  void initState() {
    super.initState();
  
   
  }

  @override
  void dispose() {
 // Cancel the timer when the widget is disposed
    super.dispose();
  }
List<Widget> Radyolarwidgets = [];
   @override
   Widget build(BuildContext context) {
    // Hesaplamalar
   var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
Radyolarwidgets=[];


   
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
     
        child: Text("Dini Radyolar", style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        ),

    )  )),

  SliverToBoxAdapter(
      child:Center(child: 
 Container(

height: size.height * 0.12,
width: size.width * 0.85, 

decoration: BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(25)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.01, size.width * 0.03, size.width * 0.001),
child:  Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(size.width*0.0 
      , size.height*0.018 , size.width*0.0 , size.height*0.018 ),
          decoration: BoxDecoration(
             gradient: LinearGradient(
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
    ),
  color: Colors.white,
 borderRadius: BorderRadius.all( 
   Radius.circular(25),
)),
      height: size.height * 0.2,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            
            children: [
         Image .asset("assets/aicon.png")
          
     
          ,   Container(
                            padding: EdgeInsets.fromLTRB(1, 1, 1, 1),

          child:Text("Berat fm",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ))),
          ],)
     
       
        
            
            

    ],),
    ),)))

,
    SliverToBoxAdapter(child: 
    
    SvgPicture.asset(
            'assets/radyo.svg', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 400, // Genişlik
            height:400,
            fit: 
            BoxFit.scaleDown,
      
          ))

          ,SliverToBoxAdapter(child:
         RoundIconButton(
  size: 80,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  iconAsset: 'assets/play.svg' 
),)
  ] ),
      )
      ;
    }
  }

    
