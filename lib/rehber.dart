
 import 'dart:math';
import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';

 import 'wrapper.dart';

 import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tarih biçimlendirme için

List<Map<String, String>> Rehberlist = [
 
  {  
    'icon': "pusula.png",
    'title': 'Kurban Rehberi ', 
    'aciklama' :'Sabah Ve Akşam Rehberı.',
    'd_id': '1'
  }, {  
    'icon': "pusula.png",
    'title': 'Namaz Duaları', 
    'aciklama' :'Lorem İpsum',
    'd_id': '2'
  }, ];

List<Map<String, String>> icRehberlist = [
 
  {  
    'icon': "pusula.png",
    'title': 'Kurban Çeşitleri', 
    'aciklama' :'Sabah Ve Akşam Rehberı.',
    'd_id': '1'
  }, {  
    'icon': "pusula.png",
    'title': 'Kurban rehberi', 
    'aciklama' :'Lorem İpsum',
    'd_id': '2'
  }, ];
 // It is assumed that all messages contain a data field with the key 'type'
 
 class Rehber extends StatefulWidget {
    Rehber({super.key});

  @override
  State<Rehber> createState() => _RehberState();
}

class _RehberState extends State<Rehber> {
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
List<Widget> Rehberwidgets = [];
   @override
   Widget build(BuildContext context) {
    // Hesaplamalar
   var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
Rehberwidgets=[];
for (int i = 0; i < Rehberlist.length; i++) {
      Rehberwidgets.add(
        
                RehberTile( 
                  tip: "dış",
                  aciklama : Rehberlist[i]['aciklama'].toString(),
                  id: Rehberlist[i]['d_id'].toString(),
                   icon : Rehberlist[i]['icon'].toString(),
                    title : Rehberlist[i]['title'].toString(),

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
     
        child: Text("Dini Rehber", style: TextStyle(
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
        childAspectRatio: 1,
          crossAxisCount: 2, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.vertical,

          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: Rehberwidgets,  
        
          )
      ), 
  ] ),
      )
      ;
    }
  }

     class icRehber extends StatefulWidget {
final String id;
    icRehber({super.key
    , required this.id
    });

  @override
  State<icRehber> createState() => ic_RehberState();
}

class ic_RehberState extends State<icRehber> {
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
List<Widget> Rehberwidgets = [];
   @override
   Widget build(BuildContext context) {
    // Hesaplamalar
   var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
Rehberwidgets=[];
for (int i = 0; i < icRehberlist.length; i++) {
      Rehberwidgets.add(
        
                RehberTile( 
                  aciklama : icRehberlist[i]['aciklama'].toString(),
                  id: icRehberlist[i]['d_id'].toString(),
                   icon : icRehberlist[i]['icon'].toString(),
                    title : icRehberlist[i]['title'].toString(), tip: 'ic',

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
     
        child: Text("Tüm Rehber", style: TextStyle(
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
        childAspectRatio: 3.5,
          crossAxisCount: 1, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
                     scrollDirection: Axis.vertical,

          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: Rehberwidgets,  
        
          )
      ), 
  ] ),
      )
      ;
    }
  }

    

    class RehberTile extends StatefulWidget {
final String tip; 
final String icon;
final String title;
final String id;
final String aciklama;

      RehberTile({Key? key,  required this.icon,
    required this.title,
    required this.aciklama,
    required this.id,
    required this.tip,
    }) : super(key: key);
    
      @override
      _RehberTileState createState() => _RehberTileState();
    }
      
    class _RehberTileState extends State<RehberTile> {
      @override
      Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;

        return
        
        GestureDetector(
          onTap: () {
            if (widget.tip == 'ic'){
            nduagoster(context,widget.id);
          }
          
          if (widget.tip == 'dış'){
            menugoster(context,widget.id);
          }
          
          },

          child:
        Container(

height: size.height * 0.1,
width: size.width * 0.3, 

decoration: BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(20)
),
padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.01, size.width * 0.05, size.width * 0.001),
child:
Stack(children: [


Align(
 alignment: Alignment.center,
  
  child:
Container(
  decoration: BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(20)
),
  child:
 Row(children:[ 
 

Expanded(
  flex: 3,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(size.width*0.0 
      , size.height*0.018 , size.width*0.05 , size.height*0.018 ),
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
   Radius.circular(10),
)),
      height: size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            
            children: [
 widget.tip=="ic" ?
         Image .asset("assets/aicon.png")
          
          : Container()
          ,   Container(
                            padding: EdgeInsets.fromLTRB(1, 4, 1, 1),

          child:Text("${widget.title}",
          textAlign: TextAlign.center,
          style: TextStyle(
          fontSize:  widget.title.length > 12 ? 12 : 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ))),
          ],)
     
       
        
            
            

    ],),
    ),



  )


  ]))
      
      
  ) 

])));
      }
    }

nduagoster(context,id){
  var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
  bool _lights = false;

var secilidua =
Rehberlist.where((element) => element['d_id'] == id);
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
                 ))),    
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
            
               
             
             
             


            
             
     



menugoster(context,id){
  var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
  bool _lights = false;

var secilidua =
Rehberlist.where((element) => element['d_id'] == id);
  return showModalBottomSheet(
     isScrollControlled: true, // Bu parametre alt sayfanın tam ekranı kaplamasını sağlar
  useRootNavigator: true,
  context: context,
  builder: (context) {

    return StatefulBuilder(
      builder: (context, setState) {
 



        return  Container(
child:icRehber(id:id),
        

        ); } ) ; } ); }


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
      padding: EdgeInsets.all(1),
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
          width: 13,
          height: 13,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}Widget _buildCustomTab(String label, IconData icon,) {
  return Tab(
    height: 130,
    child: Container(
      height: 120,
width: 120,
      padding: EdgeInsets.all(3)
      ,margin: EdgeInsets.fromLTRB(
        
        10
        , 7, 10, 7),
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
        borderRadius: BorderRadius.circular(10),
      ),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white), // İkon
          SizedBox(width: 1), // İkon ile metin arasındaki boşluk
          Text(label, style: TextStyle(color: Colors.white)), // Metin
        ],
      ),
    ),
  );
}