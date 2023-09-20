import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Kazalar extends StatefulWidget {
  @override
  State<Kazalar> createState() => _KazalarState();
}

class _KazalarState extends State<Kazalar> {
  @override

List<Map<String, String>> Kazalarim = [
  {  
    'tip': "sabah",
        'title': "Sabah Namazı",

    'tarih': '${DateTime(2023, 1, 21, 5, 34)}',
    'kaza_id' : '1',
    'kid' : '1'
  },
    {  
    'tip': "sabah",
    
        'title': "Sabah Namazı",
    'tarih': '${DateTime(2023, 3, 21, 5, 34)}',
'kaza_id' : '1',
    'kid' : '1'
  },
    {  
      
    'tip': "oglen",
    
        'title': "Öğlen Namazı",
    'tarih': '${DateTime(2023, 1, 28, 5, 34)}',
 'kaza_id' : '1',
    'kid' : '1'
  }, 
  {  
    'tip': "ikindi",
            'title': "İkindi Namazı",

    'tarih': '${DateTime(2023, 1, 28, 5, 34)}',
 'kaza_id' : '1',
    'kid' : '1'
  }, {  
    'tip': "aksam",
            'title': "Akşam Namazı",

    'tarih': '${DateTime(2023, 3, 28, 5, 34)}',
    'kaza_id' : '1',
    'kid' : '1'
  },
  {  
    'tip': "yatsi",
            'title': "Yatsı Namazı",

    'tarih': '${DateTime(2023, 3, 28, 5, 34)}',
    'kaza_id' : '1',
    'kid' : '1'
  },{  
    'tip': "imsak",
            'title': "İmsak Namazı",

    'tarih': '${DateTime(2023, 3, 28, 5, 34)}',
    'kaza_id' : '1',
    'kid' : '1'
  },

];

List<Map<String, String>> KazalarList = [
  {  
    'icon': "sabah_vakit.png",
    'title': 'Sabah Namazı', 
    'page': '/kaza',
    'kaza' : '1',
    'tip' : 'sabah'
  },
  {
    'icon': "oglen_vakit.png",
    'title': 'Öğle Namazı',
    'page': '' ,
        'kaza' : '1'
  ,
    'tip' : 'oglen'
  },
  {
    'icon': "ikindi_vakit.png",
    'title': 'İkindi Namazı',
    'page': 'ProductsPage'
    ,
        'kaza' : '1'
        ,
    'tip' : 'ikindi'

  } ,
   {
    'icon': "aksam_vakit.png",
    'title': 'Akşam Namazı',
    'page': 'ProductsPage'
    ,
        'kaza' : '1'
        ,
    'tip' : 'aksam'
  } ,
   {
    'icon': "yatsi_vakit.png",
    'title': 'Yatsı Namazı',
    'page': 'ProductsPage'
    ,
        'kaza' : '1'
        ,
    'tip' : 'yatsi'
  } , {
    'icon': "imsak_vakit.png",
    'title': 'imsak Namazı',
    'page': 'ProductsPage'
    ,
        'kaza' : '1',
    'tip' : 'imsak'
  } 
];

    List<Widget> Kazalarlistwidgets = [];
 basfonk(
 ){}
    
    @override
  void initState() {
    basfonk();
    // TODO: implement initState
    super.initState();
  }
  int selected_index=0;

  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;

 

Kazalarlistwidgets=[];
for (int i = 0; i < KazalarList.length; i++) {
      Kazalarlistwidgets.add(
       SizedBox(
     /*      height: size.height * 0.1,
          width: size.width * 0.05,
         */
        child:  GestureDetector(
                onTap: () {
                setState(() {
                  selected_index=i;
                });
                                kazagoster(context,Kazalarim,KazalarList[i]['tip']);

                },
                child: 
                
                  Container(
          
       
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(15, 25, 15, 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            boxShadow: [
                 BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ), 
              ],
            gradient:
            i != selected_index ?
               LinearGradient(
              colors: [
                Color(0xFF21367F).withOpacity(0.1),
                Color(0xFF194D91).withOpacity(0.2),
                
                Color(0xFF1590C1).withOpacity(0.4),
                Color(0xFF0298CA).withOpacity(0.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ):   LinearGradient(
              colors: [
                Color(0xFF21367F).withOpacity(0.6),
                Color(0xFF194D91).withOpacity(0.7),
                
                Color(0xFF1590C1).withOpacity(0.8),
                Color(0xFF0298CA).withOpacity(0.9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          
            borderRadius: BorderRadius.circular(10),
          ),
          child:
          
          
          
           Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
          height: size.height * 0.030,
          width: size.width * 0.070,
          padding: EdgeInsets.all(1),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(

           color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          

          ),child: 
          
          Image.asset("assets/${KazalarList[i]['icon']}",width: 25,height: 25,),
          ),
             Text( 
                 "Kaza Sayısı: " +'  ${KazalarList[i]['kaza']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  
                  color: Colors.white,
                ),
              ),
              Text(
                '${KazalarList[i]['title']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  
                  color: Colors.white,
                ),
              ),
                
            ],
          ),
        ),
      
        )  ));
    }


    return Scaffold(
     
      body: Center(
        child: CustomScrollView(

  slivers: [

   SliverToBoxAdapter(
    
      child: Center(child:  Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
        height: 100,

        child: Text("Kazalar",style: 
        TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
        ),

   ))),
   SliverToBoxAdapter(
    
      child:   Container(
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
   
          child:GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(3),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          crossAxisCount: 2, 
                     scrollDirection: Axis.vertical,

          children: Kazalarlistwidgets,  
        
          )

        
          
          
          
      ),
  ),
  
 ]),
      ),
    );
   
  }
}

kazagoster(context,kazalarim,tip){
  var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
  bool _lights = false;

  return showModalBottomSheet(
    
  context: context,
  builder: (context) {
List<Map<String, dynamic>> getSabahNamazlari(List<Map<String, dynamic>> kazalar ,String tip) {
  
  return kazalar.where((kaza) {
    return kaza['tip'] == '${tip}'; 
  }).toList();
}
    return StatefulBuilder(
      builder: (context, setState) {
  var sonuc = getSabahNamazlari(kazalarim , tip);
  print("gelensonuc");
  print(sonuc);
 List<Widget> butunwidget=[];
  for (int i = 0; i < sonuc.length; i++) {
   butunwidget.add(  
 Container(
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.2),
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
          height: size.height * 0.01,
          width: size.width * 0.08,
   margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.02, size.width * 0.05, size.width * 0.02),
       child: 
       Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
 Text(
                    '${sonuc[i]['title']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),


     
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    '${sonuc[i]['tarih'].substring(0, 13)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color:  Color(0xFF168ec0),
                    ),
                  ),
    IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                   //   kazalarim.removeAt(i);
                    });
                  },)
                  ],
                ),  ],),
             ))
            ;
  }


        return GridView.count(
          
          padding: EdgeInsets.all(3),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 3.2,
          crossAxisCount: 
        1,
        children: 
butunwidget
        
        );
      }
    );
  }
);


}