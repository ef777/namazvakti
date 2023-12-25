import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override

List<Map<String, String>> menuList = [
  {  
    'icon': "menuicons/duakardes.png",
    'title': 'Kazalar', 
    'page': '/kaza',
    'aktif' : '0'
  },
   {
    'icon': "menuicons/dualar.png",
    'title': 'Namaz Duaları',
    'page': '/namazdua'
    ,
    'aktif' : '0'
  } ,
    {
    'icon': "menuicons/dinigunler.png",
    'title': 'Dini Günler Ve Geceler',
    'page': '/dinigunler'
    ,
    'aktif' : '0'
  } ,
 {
    'icon': "menuicons/esmaulhusna.png",
    'title': 'Esma\'ül Hüsna',
    'page': '/esma'
    ,
    'aktif' : '0'
  } ,
  {
    'icon': "menuicons/dualar.png",
    'title': 'Dualar',
    'page': '/dualar'
    ,
    'aktif' : '1'
  } ,
  
  {
    'icon': "menuicons/dinihikaye.png",
    'title': 'Dini Hikayeler',
    'page': '/hikaye' 
    ,
    'aktif' : '0'
  }, {  
    'icon': "pusula.png",
    'title': 'Kıble Pusulası', 
    'page': 'KıblePusulası'
    ,
    'aktif' : '0'
  },

   
   {
    'icon': "menuicons/dinirehber.png",
    'title': 'Dini Rehber',
    'page': '/rehber'
    ,
    'aktif' : '0'
  } , {
    'icon': "menuicons/diniradyo.png",
    'title': 'Dini Radyolar',
    'page': '/radyolar'
    ,
    'aktif' : '0'
  } ,
   {  
    'icon': "menuicons/yakindacami.png",
    'title': 'Yakındaki Camiler', 
    'page': '/'
    ,
    'aktif' : '0'
  },
   {  
    'icon': "menuicons/kabecanli.png",
    'title': 'Kabe Canlı', 
    'page': '/'
    ,
    'aktif' : '0'
  }, {  
    'icon': "menuicons/hikmetname.png",
    'title': 'Hikmetname', 
    'page': '/'
    ,
    'aktif' : '0'
  },{  
    'icon': "menuicons/hikmetname.png",
    'title': 'Hikmetname', 
    'page': '/'
    ,
    'aktif' : '0'
  },
  {  
    'icon': "menuicons/duakardes.png",
    'title': 'Dua', 
    'page': '/'
    ,
    'aktif' : '0'
  }, {  
    'icon': "menuicons/kur'an.png",
    'title': 'Kur\'an ', 
    'page': '/'
    ,
    'aktif' : '0'
  },
   {  
    'icon': "menuicons/zikirler.png",
    'title': 'Zikir', 
    'page': '/'
    ,
    'aktif' : '0'
  },   {  
    'icon': "menuicons/tebrik.png",
    'title': 'Tebrik Kartları', 
    'page': '/'
    ,
    'aktif' : '0'
  }, {  
    'icon': "menuicons/tesbihat.png",
    'title': 'Tesbihat', 
    'page': '/'
    ,
    'aktif' : '0'
  },
];

    List<Widget> menulistwidgets = [  ];
 
    @override
  void initState() {
    super.initState();
  }
  int selected_index=0;

  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
menulistwidgets=[];
for (int i = 0; i < menuList.length; i++) {
      menulistwidgets.add(
         GestureDetector(
                onTap: () {
                  if (menuList[i]['aktif'] == '1'){
                  Get.toNamed(menuList[i]['page']!);

                  }
                  else {
                    Get.snackbar("Uyarı", "Bu özellik henüz aktif değil");}
                },    
                child:   Container(
          
          
          padding: EdgeInsets.all(9),
          margin: EdgeInsets.fromLTRB(8, 3, 8, 3),
          decoration: BoxDecoration(
            boxShadow: [
                 BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ), 
              ],
                gradient:
            
        menuList[i]['aktif'] == '1' ?   LinearGradient(
              colors:  [
                
                Color(0xFF21367F),
                Color(0xFF194D91),
                Color(0xFF1590C1),
                Color(0xFF0298CA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ) 
          
           : LinearGradient(
              colors: [
                Color.fromARGB(255, 112, 115, 126),
                Color.fromARGB(255, 140, 147, 155),
                Color.fromARGB(255, 196, 203, 206),
               
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          
          
            borderRadius: BorderRadius.circular(20),
          ),
          child:
          
          
          
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Container(
          height: size.height * 0.040,
          width: size.width * 0.080,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(

           color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          

          ),child: 
          
          Image.asset("assets/${menuList[i]['icon']}",width: 16,height: 16,fit: BoxFit.contain 
          ,),
          ),
          SizedBox(height: 5,),
              Center(child: Container(
                
                child: Center ( child: Text(
              
               
                '${menuList[i]['title']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: menuList[i]['title']!.length > 18 ?10 : 12, 
                  
                  color: Colors.white,
                ),
               )) )),
                
            ],
          ),
        ),
      
    ));
    }


    return Scaffold(
     
      body: CustomScrollView(
            physics: ScrollPhysics(),


  slivers: [

   SliverToBoxAdapter(
           
      child:   Container(
        
        height: size.height * 1,
        
         padding: EdgeInsets.all(5.0),
         

        margin: EdgeInsets.fromLTRB(size.width * 0.05, size.width * 0.02, size.width * 0.05, size.width * 0.05),
        decoration: BoxDecoration(
          border: 
          Border.all(
            
            color: Colors.white.withOpacity(0.5),
            width: 2,
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
       /*   padding: EdgeInsets.all(10.0),
          height: size.height * 0.18,
          width: size.width * 0.1,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.3, size.width * 0.04, size.width * 0.3, size.width * 0.02), */
         child: GridView.count(  
          crossAxisCount: 3, // Her satırda 7 kutu olacak şekilde ayarlayabilirsiniz
physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true, // GridView'ın  içeriği sığdırılabilir
          children: menulistwidgets,  
        
          )

        
          
          
          
      ),
  ),
  
   SliverToBoxAdapter(
     child: SizedBox(height: 100,),      
   ),
  
 ]),
      
    );
   
  }
}
