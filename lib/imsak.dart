import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/home.dart';

class ImsakVakti extends StatefulWidget {
  @override
  State<ImsakVakti> createState() => _ImsakVaktiState();
}

class _ImsakVaktiState extends State<ImsakVakti> {
        final AppConfig conf = Get.put(AppConfig());

  @override
  bool _lights = false;

  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
  
    return Scaffold(
     backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: CustomScrollView(
          shrinkWrap: true,
  slivers: [
SliverToBoxAdapter(
  child: Container(
child:
Column(children: [
 Image.asset("assets/oglen_vakit.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
Text("imsak vakti"),
VakitTile(title: "Vaktinde", id: "imsak_vaktinde",),
VakitTile(title: "Vaktinden Önce", id: "imsak_once",),
VakitTile( title: "Güneşten Önce", id: "imsak_gunes",),



],)

  
  ),
),SliverToBoxAdapter(
  child: Container(
child:
Column(children: [
 Image.asset("assets/imsak_vakit.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
Text("Öğlen  vakti"),
VakitTile( title: "Vaktinde", id: "oglen_vaktinde",),
VakitTile( title: "Vaktinden Önce", id: "oglen_once",),



],)

  
  ),
), SliverToBoxAdapter(
  child: Container(
child:
Column(children: [
 Image.asset("assets/ikindi_vakit.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
Text("İkindin  vakti"),
VakitTile( title: "Vaktinde", id: "ikindin_vaktinde",),
VakitTile( title: "Vaktinden Önce", id: "ikindin_once",),



],)

  
  ),
),SliverToBoxAdapter(
  child: Container(
child:
Column(children: [
 Image.asset("assets/aksam_vakit.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
Text("Akşam  vakti"),
VakitTile( title: "Vaktinde", id: "aksam_vaktinde",),
VakitTile( title: "Vaktinden Önce", id: "aksam_once",),



],)

  
  ),
),SliverToBoxAdapter(
  child: Container(
child:
Column(children: [
 Image.asset("assets/yatsi_vakit.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
Text("Yatsı  vakti"),
VakitTile( title: "Vaktinde", id: "yatsi_vaktinde",),
VakitTile( title: "Vaktinden Önce", id: "yatsi_once",),



],)

  
  ),
), SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.10,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
          child: GestureDetector(
      onTap: () async {
       
      await conf.e_kaydet( AppConfig.ezanvaktibildirim);
              Get.offAll(HomePage());




      },
      child:
          
           Container(

      width: 320,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        gradient: LinearGradient(
          colors: [
            Color(0xFF21367F),
            Color(0xFF194D91),
            Color(0xFF1590C1),
            Color(0xFF0298CA),
            Color(0xFF0298CA),
          ],
          stops: [0, 0.28, 0.88, 1, 1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Center(
        child: Text(
          "Devam Et",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
       ) ),
  ),
   SliverToBoxAdapter(
  child: Container(
    
            ),
         ) ],
        ),
      ),

    );

         
         
      
         
   
 
   
  }
}

class VakitTile extends StatefulWidget {
  // İhtiyaç duyacağımız parametreler
   
  String title ;
  String id ;
  
  // Parametreleri constructor'da alıyoruz
   VakitTile({
 
    required this.title,
    required this.id,
  });

  @override
  _VakitTileState createState() => _VakitTileState();

}

// State
class _VakitTileState extends State<VakitTile> {
      final AppConfig conf = Get.put(AppConfig());

Widget _buildSwitch(String d1, String d2) {
  return Switch(
    value: conf.getSwitchValue(d1, d2),
    onChanged: (value) => conf.onSwitchChange(value, d1, d2),
  );
}
  @override
  Widget build(BuildContext context) {
     var split = widget.id.split('_');

  var d1 = split[0];
  var d2 = split[1];


 var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
   // Ana container 
    return   Container(

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
          width: size.width * 0.9,
   margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.013, size.width * 0.05, size.width * 0.013),
       child: 
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
                children: [
Obx(() => _buildSwitch(d1, d2))
,


   Text("${widget.title}"),

   Row( children: [
    Container(
          height: size.height * 0.080,
          width: size.width * 0.100,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
          color:    Color(0xFF00a3ff).withOpacity(0.2),
        gradient :  LinearGradient (
       
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
          stops: [0.1,0.9],
             colors: [
               Color(0xFF00A3FF),
               Color(0xFF004EFF),
             ],),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
   GestureDetector(
  onTap: (){
   
  },
  child:

          
          Image.asset("assets/saat.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
  ),
    ),
    SizedBox(width: 5,),
     Container(
          height: size.height * 0.080,
          width: size.width * 0.100,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
          color:    Color(0xFF00a3ff).withOpacity(0.2),
        gradient :  LinearGradient (
       
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
          stops: [0.1,0.9],
             colors: [
               Color(0xFF00A3FF),
               Color(0xFF004EFF),
             ],),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
   GestureDetector(
  onTap: (){
 
  },
  child:

          
          Image.asset("assets/ses.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
  ),
    ),
        ],)          ],
                ),
              );
            
          }
          
            } 
