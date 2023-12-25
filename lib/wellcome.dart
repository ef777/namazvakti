import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:namazvakti/konumsec.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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
    var gizlilik ;
 void initState() {

 loadsozlesmejson().then((value) => gizlilik = value);
    super.initState();

}


static   Future loadsozlesme() async {
var a=  await rootBundle.loadString('assets/json/sozlesme.json');
    return a; 

}
 checkInternetConnection() async{
  try {
    // Google'ın DNS sunucularına bir istek gönderir.
    var response = await http.get(Uri.parse("https://www.google.com"));

    // İstek başarılı olursa, internet bağlantısı vardır.
    if (response.statusCode == 200) {
      return 1;
      // İnternet bağlantısı var.
    } else {
      // İnternet bağlantısı yok.

      // Kullanıcıya internete bağlanmasını söyler.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("İnternet bağlantısı yok"),
            content: Text("Lütfen internete bağlanın ve tekrar deneyin."),
            actions: [
              TextButton(
                child: Text("Tamam"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
            return 0;

    }
  } catch (e) {
    // İstek başarısız olursa, internet bağlantısı yoktur.

    // Kullanıcıya internete bağlanmasını söyler.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("İnternet bağlantısı yok"),
          content: Text("Lütfen internete bağlanın ve tekrar deneyin."),
          actions: [
            TextButton(
              child: Text("Tamam"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );            return 0;

  }
  
}
static Future <String> loadsozlesmejson() async {
  String jsonString = await loadsozlesme();
  final jsonResponse = json.decode(jsonString);
  print("jsonResponse" + jsonResponse .toString());
  var cevap =  jsonResponse[0]["text"];
  return   cevap.toString();


}

static sozlesmegoster(context,gizlilik) async {
  showModalBottomSheet(      isScrollControlled: true, // Set to true to make it take up the entire screen
context: context,  builder: (BuildContext context) {
               
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.fromLTRB(
                        10, 10, 10, 10),
                        
                    height: 800,
                    child: Center(
                      child: Center(
                                          child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Html(
                                          style: {
                                            '*': Style(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                            ),
                                            'body': Style(
                                                fontFamily: 'Montserrat',
                                                color: Colors
                                                    .black), // Tüm metni beyaz renkte göstermek için
                                            'p': Style(
                                                fontFamily: 'Montserrat',
                                                color: Colors
                                                    .black), // Paragrafları beyaz renkte göstermek için
                                            // Diğer etiketler ve stiller buraya eklenebilir
                                          },
                                          data: gizlilik.toString(),
                                        ),
                                      )),
                                    
                      ),
                    );
                  
                });
}
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
    return Scaffold(
     
      body:Container(
                height: height,

        
        child:
      
      Stack(children: [

 Positioned(
                top: -300.0, // Üstten boşluk
                left: -35,
                right:  -35,
             // Soldan boşluk
                child:

UpwardSlopedCircularContainer(
  height: 700,
  width : 900,
            angle: 50, // Eğim açısı (derece cinsinden)
         
          
 )) ,

 Positioned(
               // Üstten boşluk
                left: -35,
                right:  -35,
                bottom: -700,
             // Soldan boşluk
                child:

UpwardSlopedCircularContainer(
  height: 1600,
  width : 1000,
            angle: 50, // Eğim açısı (derece cinsinden)
          
          
 )) ,
  
       Center(
        child: CustomScrollView(
          shrinkWrap: true,

  slivers: [

   SliverToBoxAdapter(
    
      child:   Container( height: 15, )),
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
         padding: EdgeInsets.all(4.0),
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
         padding: EdgeInsets.all(4.0),
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
            ,style: TextStyle(fontSize: 24.0, color: 
            
                            Color(0xFF004eff),

             fontWeight: FontWeight.bold),), 
            
            
            
            
            )
,          SizedBox(height: 10,),
            Container(child: 
            Text ("Ezan Vakti'ne hoşgeldiniz",
            
            textAlign: TextAlign.center
            ,
            
            style: TextStyle(fontSize: 14.0, 
            ), 
            ))
            
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
          child:   SizedBox(
            child : GestureDetector (
              onTap: () {

sozlesmegoster(context,gizlilik)  ;            },
           
            child:  
           
           
             SvgPicture.asset("assets/eye.svg",color: 
             Colors.blue,fit: BoxFit.scaleDown // Görüntüyü mevcut boyut sınırlarına sığdır
             , height: 15,width: 15,)),
          )
          ),
          
          /*   Container(child: 
            Image.asset("assets/ok.png")) */
  


             SizedBox(
            child : GestureDetector (
              onTap: () {

sozlesmegoster(context,gizlilik)  ;            },
           
            child:  Container(child: 
Text("Gizlilik Sözleşmesi"),            
            ))
            ),  
           Row(   
            children: [
           SizedBox(
            child : GestureDetector (
              onTap: () {

sozlesmegoster(context,gizlilik)  ;            },
           
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
  fontSize: 12.0,
  letterSpacing: 0.0,
  decoration: TextDecoration.underline,
  fontFamily: "Gilroy",
  
      
    )))],) 



  ),
    SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.09,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
          child:
          
          GestureDetector(
            onTap: () async{
             // Navigator.pushNamed(context, '/login');
int a =await checkInternetConnection();
             if(_isChecked == true && a == 1){
              Get.to(() => KonumSec());

             }
              else {
                if(a == 0)
                Get.snackbar("Hata", "Lütfen internet bağlantınızı kontrol ediniz");
                else
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
   
  ]),
      ),    ],)
      )  );
   
  }
}
