import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namazvakti/konumsec.dart';

import 'arkaplanwidget.dart';

class WellcomePage extends StatefulWidget {
  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage> {
/*   final counterController = Get.put(CounterController());
 */
  @override
    bool _isChecked = false;

  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
    return Scaffold(
     
      body:Container(child:
      
      Stack(children: [

 Positioned(
                top: -300.0, // Üstten boşluk
                left: -35,
                right:  -35,
             // Soldan boşluk
                child:

UpwardSlopedCircularContainer(
  height: 600,
  width : 900,
            angle: 45, // Eğim açısı (derece cinsinden)
         
          
 )) ,

 Positioned(
               // Üstten boşluk
                left: -35,
                right:  -35,
                bottom: -500,
             // Soldan boşluk
                child:

UpwardSlopedCircularContainer(
  height: 1200,
  width : 1200,
            angle: 20, // Eğim açısı (derece cinsinden)
          
          
 )) ,
  
       Center(
        child: CustomScrollView(
          shrinkWrap: true,

  slivers: [

   SliverToBoxAdapter(
    
      child:   Container(
        decoration: BoxDecoration(
          border: 
          Border.all(
            
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
            borderRadius: BorderRadius.circular(20),
          
            gradient: LinearGradient(
              colors: [
            //    Color(0xFF21367F),
              Colors.white.withOpacity(0.2),
                             Colors.white.withOpacity(0.2),

              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.18,
          width: size.width * 0.1,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.3, size.width * 0.09, size.width * 0.3, size.width * 0.02),
          child: Image.asset("assets/loginlogo.png",
          fit: BoxFit.scaleDown,
          height: 
          size.height * 0.09,
          width: size.width * 0.1,
          ),
          
          
          
      ),
  ),
   
    SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(8.0),
/*           height: size.height * 0.18,
          width: size.width * 0.8, */
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.01, size.width * 0.05, size.width * 0.02),
          child: Column(children:[ 
            
          

           Container(child: 
            Image.asset("assets/namaz.png",))
            
           ,   Container(child: Column(children:[

            Container(child: 
            Text ("Selamun Aleyküm"
            ,style: TextStyle(fontSize: 29.0, color: 
            
                            Color(0xFF004eff),

             fontWeight: FontWeight.bold),), 
            
            
            
            
            )
,
            Container(child: 
            Text ("Lorem ipsum dolor sit amet, conse cadipiscing elit,Lorem ipsum"), 
            
            )
           ])),
            ]),
      ),
  )
  ,
    SliverToBoxAdapter(
      child: Column(children: [ Container(
         decoration: BoxDecoration(
          border: Border.all(
            
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
            borderRadius: BorderRadius.circular(20),
         gradient: LinearGradient(
              colors: [
                Colors.transparent,
                                Colors.transparent,

            /*     Color(0xFF21367F),
                Color(0xFF194D91),
                Color(0xFF1590C1),
                Color(0xFF0298CA), */
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
           
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.10,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
          child: Center(child: 
          
          Row( 
            
            mainAxisAlignment: 
            MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           Container(
          height: size.height * 0.06,
          width: size.width * 0.10,
          
  padding: EdgeInsets.all(2),
  margin: EdgeInsets.fromLTRB(0, 6,6, 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
            //    Color(0xFF21367F),
            Color(0xFF004eff).withOpacity(0.2),
            Color(0xFF004eff).withOpacity(0.1)

              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
           
           
             SvgPicture.asset("assets/eye.svg",color: 
             Colors.blue,fit: BoxFit.scaleDown // Görüntüyü mevcut boyut sınırlarına sığdır
             , height: 15,width: 15,)),
          /*   Container(child: 
            Image.asset("assets/ok.png")) */
             Container(child: 
Text("Gizlilik Sözleşmesi"),            
            
            ),  
           Row(   
            children: [
           SizedBox(
            child : GestureDetector (
              onTap: () {
                showModalBottomSheet(context: context,  builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Text("Gizlilik Sözleşmesi"
                      
                    ,  style: TextStyle(
  color:  Color.fromRGBO(0, 0, 0, 0.502).withOpacity(0.53),
  fontWeight: FontWeight.bold,
  fontSize: 14.0,
  letterSpacing: 0.0,
  decoration: TextDecoration.underline,
  fontFamily: "Gilroy",
  
),
                      ),
                    ),
                  );
                });
              },
           
            child:  SvgPicture.asset("assets/sozlesme.svg",color: 
             Colors.black,height: 15 , width: 15, fit: BoxFit.scaleDown, // Görüntüyü mevcut boyut sınırlarına sığdır
  alignment: Alignment.center
             ,))),
          /*   Container(child: 
            Image.asset("assets/ok.png")) */
            


          
     SizedBox(child: 
  Checkbox(
              value: _isChecked,
              onChanged: ( newValue) {
                setState(() {
                  _isChecked = newValue!;
                });
              },
            ),
 )
 
 ],
           )
 
 ]),
          ) 
      ),
      
      
      Container(child: Text("Gizlilik Sözleşmesini okudum ve kabul ediyorum"
      ,style: TextStyle(
  color:  Color.fromRGBO(0, 0, 0, 0.502).withOpacity(0.53),
  fontWeight: FontWeight.bold,
  fontSize: 14.0,
  letterSpacing: 0.0,
  decoration: TextDecoration.underline,
  fontFamily: "Gilroy",
  
      
    )))],) 



  ),
    SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.10,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
          child:
          
          GestureDetector(
            onTap: () {
             // Navigator.pushNamed(context, '/login');

             if(_isChecked){
              Get.to(() => KonumSec());

             }
              else {
                Get.snackbar("Hata", "Lütfen Gizlilik Sözleşmesini okuyup kabul ediniz");
              }   
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
      ),
  ),
    ),
      SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.05,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
      ),
  ),
  ]),
      ),    ],)
      )  );
   
  }
}
