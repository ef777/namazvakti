
 import 'dart:math';
import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:namazvakti/model-control/dualarmodel.dart';
import 'dart:math';

 import 'wrapper.dart';

 import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tarih biçimlendirme için

     final duac = Get.put(DuaKont());

 class Dualar extends StatefulWidget {
 final tip;
 final baslik;

// 3 tip var 1-genel baslik 2-alt baslit 3-dualar tile
//genel tip 1
      Dualar({Key? key,
                this.tip,
   
      this.baslik,
    
    }) : super(key: key);
    
  @override
  State<Dualar> createState() => _DualarState();
}

class _DualarState extends State<Dualar> {
 @override

  List<Color> _colors = [ /*   Color(0xFF21367F).withOpacity(0.5), */
 /* Color(0xFF194D91).withOpacity(0.5), */
   Color(0xFF1590C1).withOpacity(0.5),
   Color(0xFF0298CA).withOpacity(0.5),
]; 
List<DualarModel> dualar = [];
  void initState()  {
duac.loaddualar();
       super.initState();

  }

  @override
  void dispose() {
 // Cancel the timer when the widget is disposed
    super.dispose();
  }
List<Widget> dualarwidgets = [];
List<Widget> genelwidgets = [];
List<Widget> altwidgets = [];

   @override
   Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;


return    Scaffold(
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
         body:
        Container(
  height: height * 1,
    child: SingleChildScrollView (child:  Column(
      children: [
          if (widget.tip == "genel") ...[  
   FutureBuilder( 
    
     
    future:  duac.genelbasliklargetir(), builder: 
        (context, snapshot) {
          if (snapshot.hasData) {
          var a =  snapshot.data ;
             List <String> basliklar = snapshot.data! ;
            genelwidgets=[];

            
for (int i = 0; i < basliklar.length; i++) {
      genelwidgets.add(
        
                MenuTile( 
                  icon : "pusula.png",
                  tip:    "alt",
                  baslik:  basliklar[i],
                )

      
    ); } 
     
     
     return CustomScrollView(
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
     
        child: Text("Tüm Dualar", style: TextStyle(
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
          children: genelwidgets,  
        
          )
      ) 
  
  ] );
    }

     else {
            return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          
        
        );
          } 
   
        } )    
            
          
   
        
    ] else if (widget.tip == "alt") ...[


   FutureBuilder( future:  duac.altbaslik(widget.baslik), builder: 
        (context, snapshot) {
          if (snapshot.hasData) {
             List <String> basliklar = snapshot.data! ;
            altwidgets=[];

            
for (int i = 0; i < basliklar.length; i++) {
      altwidgets.add(
        
                MenuTile( 
                  icon : "pusula.png",
                  tip:    "dua",
                  baslik:  basliklar[i],
                )

      
    ); } 
     
     
    return    CustomScrollView(
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
     
        child: Text("Tüm Dualar", style: TextStyle(
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
          children: altwidgets,  
        
          )
      ), 
  ] 
      )
      ;
    }
   
    else {
            return  Container(
          decoration: BoxDecoration(
           
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        
            );      
            
          } 
   
        } )
    ] else  ...[

   
       FutureBuilder( future:  duac.dualarim(widget.baslik), builder: 
        (context, snapshot) {
          if (snapshot.hasData) {
            dualar = snapshot.data as List<DualarModel>;
            dualarwidgets=[];

            
for (int i = 0; i < dualar.length; i++) {
      dualarwidgets.add(
        
                DualarTile( 
                  icon : "pusula.png",
                  tip:    widget.tip,
                  id : "0",
                  genelBaslik : dualar[i].genelBaslik,
                  altBaslik : dualar[i].altBaslik,
                  arapcasi : dualar[i].arapcasi,
                  anlami : dualar[i].anlami,
                  soyleyen : dualar[i].soyleyen,
                

                )

      
    ); }
     
     
      return  CustomScrollView(
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
     
        child: Text("Tüm Dualar", style: TextStyle(
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
          children: dualarwidgets,  
        
          )
      ), 
  ]
      )
      ;
    }
   
    else {
            return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            )

          
            );
              
            
          }
        }
        )
    ]
      ],
    ),
  )));
    }
    }

    
   



  class MenuTile extends StatefulWidget {
    // hem alt baslik hem üst baslik

final String baslik ;
final String icon;
final String tip;
// dis
// ic
      MenuTile({Key? key,  required this.icon,
      required this.baslik,
      required this.tip,
   
    
    }) : super(key: key);
    
      @override
      _MenuTileState createState() => _MenuTileState();
    }
      
    class _MenuTileState extends State<MenuTile> {
      @override
      Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;

        return
        
        GestureDetector(
          onTap: () {
            menugoster(context,widget.baslik,widget.tip);
      
          
           
     
          
          },

          child:
         Container(

height: size.height * 0.10,
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
    flex: 1,
    child: Container(
      
    
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
    ),
   
  ),

      height: size.height * 0.10,

      child:SvgPicture.asset(
            'assets/duaicon.svg', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 20, // Genişlik
            height: 20,
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

          child:Text("${widget.baslik}",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ))),
       
        
            
            

    ],),
    ),



  )


  ]))
      
      
  ) ,Align(
 alignment: Alignment.centerRight,
  
  child:
  Container(
          height: size.height * 0.10,
          width: size.width * 0.10,
          
  padding: EdgeInsets.all(0),
  margin: EdgeInsets.fromLTRB(0, 0,0, 0),
          decoration: BoxDecoration(
                shape: BoxShape.circle
,
          color: Colors.white
          ),
          child: Center(child:
Container(child:

SvgPicture.asset(
            'assets/eye.svg', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 30, // Genişlik
            height: 30,
            fit: 
            BoxFit.scaleDown,
            color: Colors.black
            , // Yükseklik
          ),

))),
  )

])));
      }
    }
    class DualarTile extends StatefulWidget {
final String tip ;
final String id;
final String icon;
final String genelBaslik; 
final String altBaslik;
final String arapcasi;
final String anlami;
final String soyleyen;
      DualarTile({Key? key,  required this.icon,
      required this.id,
      required this.tip,
      required this.genelBaslik,
      required this.altBaslik,
      required this.arapcasi,
      required this.anlami,
      required this.soyleyen,
    
    }) : super(key: key);
    
      @override
      _DualarTileState createState() => _DualarTileState();
    }
      
    class _DualarTileState extends State<DualarTile> {
      @override
      Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;

        return
        
        GestureDetector(
          onTap: () {
        var a=  DualarModel (
                    
                     genelBaslik: widget.genelBaslik,
                     altBaslik: widget.altBaslik,
                     arapcasi: widget.arapcasi,
                     anlami: widget.anlami,
                     soyleyen: widget.soyleyen,
                   );
          
                   nduagoster(context,
                a
                   
                   );

          
          },

          child:
         Container(

height: size.height * 0.10,
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
    flex: 1,
    child: Container(
      
    
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
    ),
   
  ),

      height: size.height * 0.10,

      child:SvgPicture.asset(
            'assets/duaicon.svg', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 20, // Genişlik
            height: 20,
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

          child:Text("${widget.anlami.substring(0, 20)}",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ))),
        Container(
                            padding: EdgeInsets.fromLTRB(1, 2, 1, 1),
child:
       SizedBox(
        height: size.height * 0.02,
        child: SingleChildScrollView(
          child: Text("${widget.soyleyen}",style: TextStyle(
            color: Colors.white,
            fontSize: 14,)
            ),
        )
         ) ),
        
            
            

    ],),
    ),



  )


  ]))
      
      
  ) ,Align(
 alignment: Alignment.centerRight,
  
  child:
  Container(
          height: size.height * 0.10,
          width: size.width * 0.10,
          
  padding: EdgeInsets.all(0),
  margin: EdgeInsets.fromLTRB(0, 0,0, 0),
          decoration: BoxDecoration(
                shape: BoxShape.circle
,
          color: Colors.white
          ),
          child: Center(child:
Container(child:

SvgPicture.asset(
            'assets/eye.svg', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 30, // Genişlik
            height: 30,
            fit: 
            BoxFit.scaleDown,
            color: Colors.black
            , // Yükseklik
          ),

))),
  )

])));
      }
    }

nduagoster(context,DualarModel secilidua ){
  var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
  bool _lights = false;
  return showModalBottomSheet(
     isScrollControlled: true, // Bu parametre alt sayfanın tam ekranı kaplamasını sağlar
  useRootNavigator: true,
  context: context,
  builder: (context) {
// dua getiren fonksiyon
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
    child:Text('${secilidua.soyleyen}',style: TextStyle(
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
  child:  Center(child:
  
  SingleChildScrollView(child:
  Column (children: [
  Text('${secilidua.arapcasi}',style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
                 )),
  Text('${secilidua.anlami}',style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
                 ))
        ])
                 
        ))

        ) ) 
        ],
        
        ));
        
      },
    );
  },
);
}

            
               
             
             
             


            
             
     



menugoster(context,String baslik,String tip){
  var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
  bool _lights = false;

  return showModalBottomSheet(
     isScrollControlled: true, // Bu parametre alt sayfanın tam ekranı kaplamasını sağlar
  useRootNavigator: true,
  context: context,
  builder: (context) {

    return StatefulBuilder(
      builder: (context, setState) {
 



        return  Container(
child:Dualar(tip : tip, baslik:baslik  ),
        

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