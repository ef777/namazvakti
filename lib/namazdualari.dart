
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

List<Map<String, String>> dualar = [
 
  {  
    'icon': "pusula.png",
    'title': 'Subhaneke', 
    'aciklama' :'duaların en bereketlisi',
    'd_id': '1'
  }, {  
    'icon': "pusula.png",
    'title': 'Ettehiyyatü', 
    'aciklama' :'duaların en bereketlisi',
    'd_id': '2'
  }, {  
    'basicon': "pusula.png",
    'sonicon' : "pusula.png",
    'title': 'Allahümme Salli', 
    'aciklama' :'duaların en bereketlisi',
    'd_id': '3'
  }];

 // It is assumed that all messages contain a data field with the key 'type'
   late TabController tabController;

 class NamazDua extends StatefulWidget {
    NamazDua({super.key});

  @override
  State<NamazDua> createState() => _NamazDuaState();
}

class _NamazDuaState extends State<NamazDua> with TickerProviderStateMixin {
 @override
  
  List<Color> _colors = [ /*   Color(0xFF21367F).withOpacity(0.5), */
 /* Color(0xFF194D91).withOpacity(0.5), */
   Color(0xFF1590C1).withOpacity(0.5),
   Color(0xFF0298CA).withOpacity(0.5),
]; 


  void initState() {
    super.initState();
      tabController = TabController(length: 3, vsync: this, initialIndex: 0);

   
  }

  @override
  void dispose() {
 // Cancel the timer when the widget is disposed
    super.dispose();
  }
List<Widget> dualarwidgets = [];
   @override
   Widget build(BuildContext context) {
    // Hesaplamalar
   var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
dualarwidgets=[];
for (int i = 0; i < dualar.length; i++) {
      dualarwidgets.add(
        
                NamazDuaTile( 
                  aciklama : dualar[i]['aciklama'].toString(),
                  id: dualar[i]['d_id'].toString(),
                   icon : dualar[i]['icon'].toString(),
                    title : dualar[i]['title'].toString(),

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
     
        child: Text("Namaz Duaları", style: TextStyle(
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
  ] ),
      )
      ;
    }
  }

    

    class NamazDuaTile extends StatefulWidget {

final String icon;
final String title;
final String id;
final String aciklama;  

      NamazDuaTile({Key? key,  required this.icon,
    required this.title,
    required this.aciklama,
    required this.id,
    }) : super(key: key);
    
      @override
      _NamazDuaTileState createState() => _NamazDuaTileState();
    }
      
    class _NamazDuaTileState extends State<NamazDuaTile> {
      @override
      Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;

        return
        
        GestureDetector(
          onTap: () {
            nduagoster(context,widget.id);
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
    color:Colors.red,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
    ),
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
  ),

      height: size.height * 0.10,

      child:SvgPicture.asset(
            'assets/dua.svg', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 20, // Genişlik
            height: 20,
            fit: 
            BoxFit.scaleDown,
            color: Colors.white
            , // Yükseklik
          ),
    ),



  ),
Expanded(
  flex: 3,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(size.width*0.0 
      , size.height*0.013 , size.width*0.04 , size.height*0.013 ),
          decoration: BoxDecoration(
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

          child:Text("${widget.title}",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ))),
        Container(
                            padding: EdgeInsets.fromLTRB(1, 2, 1, 1),
child:
       SizedBox(
        height: size.height * 0.02,
        child: SingleChildScrollView(
          child: Text("${widget.aciklama}",style: TextStyle(
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
          ),
          child: Center(child:
Container(child:

SvgPicture.asset(
            'assets/eye.svg', // SVG dosyanızın yolunu doğru şekilde belirtin
            width: 30, // Genişlik
            height: 30,
            fit: 
            BoxFit.scaleDown,
            color: Colors.white
            , // Yükseklik
          ),

))),
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
dualar.where((element) => element['d_id'] == id);
  return showModalBottomSheet(
     isScrollControlled: true, // Bu parametre alt sayfanın tam ekranı kaplamasını sağlar
  useRootNavigator: true,
  context: context,
  builder: (context) {

    return StatefulBuilder(
      builder: (context, setState) {  return  Container(
        
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
       child:  DefaultTabController(
  length: 3, // Tab sayısı
  child:  CustomScrollView(
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
              padding: EdgeInsets.all(15.0),
              child:
            Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                SizedBox(height: 25,),
           Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [  

         RoundIconButton(
  size: 25,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  iconAsset: 'assets/play.svg' 
),
SizedBox(width: 2,),

 RoundIconButton(
  size: 25,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  
  iconAsset: 'assets/share.svg' 
),
SizedBox(width: 2,),

 Container(
    
    margin: EdgeInsets.fromLTRB(width*0.01 , height * 0.010, width*0.01, height * 0.010),
    child:Text('${secilidua.first['title']}',style: TextStyle(
          fontSize: secilidua.first['title']!.length > 10 ?  10 : 13,
          fontWeight: FontWeight.bold,
          color: Colors.black,
                 ))),   
SizedBox(width: 3,),

                 RoundIconButton(
  size: 25,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  iconAsset: null, text: "A+"
  ,
), SizedBox(width: 3,),
  RoundIconButton(
  size: 25,
  onPressed: () {
    // düğmeye basıldığında çalışacak kod
  }, 
  iconAsset: null, text: "A-",
), 
               ],
             ) ],)
             
             )
             ,
             ),
           
            bottom: PreferredSize(
  preferredSize: Size.fromHeight(120.0), // Widget'ın yüksekliği
  child:Container(
 height: 90,
   margin: EdgeInsets.all(20), // Dış kenar boşluğunu ayarlar
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15  ), // Kenarları yumuşatır
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Gölge rengi
        spreadRadius: 5, // Gölge yayılma yarıçapı
        blurRadius: 7, // Gölge bulanıklık yarıçapı
        offset: Offset(0, 3), // Gölge konumu
      ),
    ],
  ),
  child:  TabBar(
    onTap: (index) {
        setState(() {
              // Burada istediğiniz işlemleri gerçekleştirebilirsiniz
            });
    },
controller: tabController,
    
  indicator:  BoxDecoration(
         
        gradient: LinearGradient(
          colors: [
            Color(0xFF21367F),
            Color(0xFF194D91),
            Color(0xFF1590C1),
            Color(0xFF0298CA),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ) ,
        borderRadius: tabController.index ==0 ? BorderRadius.only( topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
      : tabController.index ==1 ? BorderRadius.circular(10) : BorderRadius.only( topRight: Radius.circular(15),bottomRight: Radius.circular(15))
    
      ),

  
  labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
  labelColor: Colors.white,
  unselectedLabelColor: Colors.black,
   // Seçilmemiş etiket metin rengi
  
  labelStyle: TextStyle(fontSize: 16.0),
  unselectedLabelStyle: TextStyle(fontSize: 13.0, color: Colors.black), // Seçilmemiş etiket metin stilini özelleştirme
  indicatorWeight:15.0,
  indicatorPadding: EdgeInsets.all(2),
  padding: EdgeInsets.all(2),
   tabs: [
  Tab(
  
        text: "Okunuşu",
        icon:  SvgPicture.asset("assets/okunusu.svg",
          width: 18,
          height: 18,
          color: tabController.index == 0 ? Colors.white : Colors.black,
        ),

    height: 130,
     
  ),Tab(
   icon:  SvgPicture.asset("assets/meali.svg",
           width: 18,
          height: 18,
          color: tabController.index == 1 ? Colors.white : Colors.black,

        ),

    text: "Meali",
    height: 130, ),Tab(
            icon:  SvgPicture.asset("assets/arapca.svg",
         width: 18,
          height: 18,                color: tabController.index == 2 ? Colors.white : Colors.black,


        ),

    text: "Arapçası",
    height: 130,
    
    
  ),


  ],
            ),
            ))),
          SliverFillRemaining(
            child: TabBarView(
              children: [
                Container(
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
  child:  Center(child: Text('Bu 1. Sayfa')))
  ,
  Container(
 height: 100,
   margin: EdgeInsets.all(2), // Dış kenar boşluğunu ayarlar
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
  child:               Center(child: Text('Bu 2. Sayfa'))),
           Container(
 height: 100,
   margin: EdgeInsets.all(2), // Dış kenar boşluğunu ayarlar
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
  child:      Center(child: Text('Bu 3. Sayfa'))),
              ],
            ),
          ),
        ],
      )),
    );
  }

        );

                  },
                );
              }
                      
     




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
      
      iconAsset == null ?  Center (child: Text(text!
      ,
      textAlign: TextAlign.center,
       style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),)) :
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