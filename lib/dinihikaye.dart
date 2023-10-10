
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

List<Map<String, String>> hikaye = [
 
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
 
 class DiniHikaye extends StatefulWidget {
    DiniHikaye({super.key});

  @override
  State<DiniHikaye> createState() => _DiniHikayeState();
}

class _DiniHikayeState extends State<DiniHikaye> {
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
List<Widget> DiniHikayewidgets = [];
   @override
   Widget build(BuildContext context) {
    // Hesaplamalar
   var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
DiniHikayewidgets=[];
for (int i = 0; i < hikaye.length; i++) {
      DiniHikayewidgets.add(
        
                DiniHikayeTile( 
                  aciklama : hikaye[i]['aciklama'].toString(),
                  id: hikaye[i]['d_id'].toString(),
                   icon : hikaye[i]['icon'].toString(),
                    title : hikaye[i]['title'].toString(),

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
     
        child: Text("Dini Hikaye", style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        ),

    )  )),

SliverToBoxAdapter(
      child: GridView.count(
          padding: EdgeInsets.all(5.0),
           crossAxisSpacing: 10,
           mainAxisSpacing: 10,
        childAspectRatio: 2,
          crossAxisCount: 2, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.vertical,

          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: DiniHikayewidgets,  
        
          )
      ), 
  ] ),
      )
      ;
    }
  }

    

    class DiniHikayeTile extends StatefulWidget {
final String icon;
final String title;
final String id;
final String aciklama;

      DiniHikayeTile({Key? key,  required this.icon,
    required this.title,
    required this.aciklama,
    required this.id,
    }) : super(key: key);
    
      @override
      _DiniHikayeTileState createState() => _DiniHikayeTileState();
    }
      
    class _DiniHikayeTileState extends State<DiniHikayeTile> {
      @override
      Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;

        return
        
        GestureDetector(
          onTap: () {
            hikayegoster(context,widget.id);
          
          
        
          
          },

          child:
         Container(

height: size.height * 0.08,
width: size.width*0.25,
decoration: BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(10)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.001, size.width * 0.01, size.width * 0.01, size.width * 0.001),
child:
Stack(children: [


Align(
 alignment: Alignment.center,
  
  child:
Container(
  decoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.1),
     border:  Border.all(
      
    color: Colors.blue,
    width: 1,
  ),
  borderRadius: BorderRadius.circular(10)
),
  child:
 Row(children:[ 

  Expanded(
    flex: 1,
    child: Container(
      
    
  decoration: BoxDecoration(
    
    color: Colors.transparent,
 
   
  ),

      height: size.height * 0.10,
      width: size.width*0.15,

      child:Image.asset(
            'assets/menuicons/dinihikaye.png', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 100, // Genişlik
            height: 100,
            fit: 
            BoxFit.scaleDown,
            color: Colors.black
            , // Yükseklik
          ),
    ),



  ),
Expanded(
  flex: 3,
    child: Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.fromLTRB(size.width*0.0 
      , size.height*0.018 , size.width*0.05 , size.height*0.018 ),
          decoration: BoxDecoration(
  color: Colors.transparent,
   
 borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
),
      height: size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
                            padding: EdgeInsets.fromLTRB(1, 4, 1, 1),

          child:Text("${widget.title}",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ))),
      
        
            
            

    ],),
    ),



  )


  ]))
      
      
  ) 
])));
      }
    }

hikayegoster(context,id){
  var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
  bool _lights = false;

var secilidua =
hikaye.where((element) => element['d_id'] == id);
  return showModalBottomSheet(
     isScrollControlled: true, // Bu parametre alt sayfanın tam ekranı kaplamasını sağlar
  useRootNavigator: true,
  context: context,
  builder: (context) {

    return StatefulBuilder(
      builder: (context, setState) {
 



        return  Container(
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
            color: Colors.transparent,
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
         padding: EdgeInsets.all(4.0),
          height: size.height * 1,
          width: size.width * 1,
   margin: EdgeInsets.fromLTRB(
              size.width * 0.00, size.width * 0.1, size.width * 0.00, size.width * 0.00),
       child:   CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              iconTheme: IconThemeData(color: Colors.black), // Geri düğmesi rengi
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    color: Colors.black, // Geri düğmesi rengi
    onPressed: () {
      // Geri düğmesine tıklandığında yapılacak işlemler
    },
  ),
            centerTitle: true,
            backgroundColor: Colors.white,
            floating: false,
            pinned: true,
            expandedHeight: 250.0, // Başlık bölümünün yüksekliği
            flexibleSpace: FlexibleSpaceBar(
             centerTitle: true,
             title: Container(
              padding: EdgeInsets.all(20.0),
              child:
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                SizedBox(height: 25,),
  Container(
    
    margin: EdgeInsets.fromLTRB(width*0.05 , height * 0.010, width*0.05, height * 0.010),
    child:Text('${secilidua.first['title']}',style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
                 ))
  ), 
                 
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [  


 RoundIconButton(
  size: 25,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  
  iconAsset: 'assets/share.svg' 
),
SizedBox(width: 2,),


                 RoundIconButton(
  size: 25,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  iconAsset: null, text: "A+",
), SizedBox(width: 3,),
  RoundIconButton(
  size: 25,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  iconAsset: null, text: "A-",
), 
               ],
             ) 
                   
               ]))

            ),
          ),
SliverToBoxAdapter(child:  Container(
 height: height * 0.7,
   margin: EdgeInsets.all(20), // Dış kenar boşluğunu ayarlar
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15), // Kenarları yumuşatır
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Gölge rengi
        spreadRadius: 5, // Gölge yayılma yarıçapı
        blurRadius: 7, // Gölge bulanıklık yarıçapı
        offset: Offset(0, 3), // Gölge konumu
      ),
    ],
  ),
  child:  Center(child: Text('Bu 1. Sayfa'))))

        ]));});});}
            
               
             
             
             


            
             
     
