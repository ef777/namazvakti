import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImsakVakti extends StatefulWidget {
  @override
  State<ImsakVakti> createState() => _ImsakVaktiState();
}

class _ImsakVaktiState extends State<ImsakVakti> {
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
 Image.asset("assets/imsak_vakit.png",width: 25,height: 25
          ,fit: BoxFit.contain,
          ),
Text("imsak vakti"),
VakitTile(valuel: true, title: "Vaktinde", id: 1,),
VakitTile(valuel: true, title: "Vaktinden Önce", id: 2,),
VakitTile(valuel: true, title: "Güneşe", id: 3,),



],)

  
  ),
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
   bool valuel;
  var title ;
  var id ;
  
  // Parametreleri constructor'da alıyoruz
   VakitTile({
    required this.valuel,
    required this.title,
    required this.id,
  });

  @override
  _VakitTileState createState() => _VakitTileState();

}

// State
class _VakitTileState extends State<VakitTile> {

  @override
  Widget build(BuildContext context) {
 var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
   // Ana container 
    return   Container(
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
              size.width * 0.05, size.width * 0.02, size.width * 0.05, size.width * 0.05),
       child: 
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
                children: [
Switch(
  value: widget.valuel, 
  onChanged: (bool value) {
    setState(() {
      value = value;
    });
  },
),


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
    setState(() {
       widget.valuel = ! widget.valuel;
    });
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
    setState(() {
       widget.valuel = ! widget.valuel;
    });
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
