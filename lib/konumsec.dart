import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/home.dart';
import 'package:namazvakti/girisalarm.dart';
import 'package:namazvakti/model-control/ilceler.dart';
import 'package:namazvakti/model-control/sehirler.dart';
import 'package:namazvakti/model-control/ulkeler.dart';



   final controller = Get.put(AppConfig()); 


class KonumSec extends StatefulWidget {
  @override
  State<KonumSec> createState() => _KonumSecState();
}

class _KonumSecState extends State<KonumSec> {
  @override

  final box = GetStorage();

var _isLoading = false;
  
    bool _isChecked = false;
List<Sehir> sehirListesi = [];
List<Ulke> ulkeListesi = [];
List<Ilce> ilceListesi = [];

Ulke ?selectedUlke ;
Sehir ?selectedSehir;
Ilce ?selectedIlce;
@override
  void initState() {

  
    // TODO: implement initState
    super.initState();
  }

 Future <List<dynamic >> Konumveri(ulke,sehir) async {
print("future fonk başladı");
   var  ulkeler   = await Ulke.fetchUlkeListesi();

   var sehirler = null;
    var ilceler = null;
    if(ulke == null && sehir == null){
    sehirler = await Sehir.getSehirler(ulkeler.first.ulkeID!);
    ilceler = await Ilce.getIlceler(sehirler.first.sehirID!);
    return [ulkeler,sehirler,ilceler];
    }
else if ( ulke != null && sehir == null) {
   sehirler = await Sehir.getSehirler(ulke);
    ilceler = await Ilce.getIlceler(sehirler.first.sehirID!);
    return [ulkeler,sehirler,ilceler];

}
else if (ulke != null && sehir != null) {
     sehirler = await Sehir.getSehirler(ulke);

    ilceler = await Ilce.getIlceler(sehir);
    return [ulkeler,sehirler,ilceler];
}



  
 

   
 


  else {
        print("hata");

   return [null,null,null];
  }
 }

saveid(Ulke ulke,Sehir sehir, Ilce ilce) async {

  await box.write('ulkeid', ulke.ulkeID);
  await box.write('ulkename', ulke.ulkeAdi);
  await box.write('sehirid', sehir.sehirID);
  await box.write('sehirname', sehir.sehirAdi);
  await box.write('ilceid', ilce.ilceID);
  await box.write('ilcename', ilce.ilceAdi);
   await box.write('ilgiris', true);
  AppConfig.ulkeid = ulke.ulkeID ?? "";
  AppConfig.ulkename = ulke.ulkeAdi ?? "";
  AppConfig.sehirid = sehir.sehirID ?? "";
  AppConfig.sehirname = sehir.sehirAdi ?? "";
  AppConfig.ilceid = ilce.ilceID ?? "";
  AppConfig.ilcename = ilce.ilceAdi ?? "";
  AppConfig.login = true;
    controller.ilkgiriskayit();

  
  print("idler kaydedildi");

}


  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
    return  Scaffold(
     
      body: FutureBuilder<List<dynamic>>(
        future:Konumveri (selectedUlke?.ulkeID ?? null ,selectedSehir?.sehirID ?? null),
        

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } 
          
        
          
          if (snapshot.hasData) {
            ulkeListesi = snapshot.data![0];
            sehirListesi = snapshot.data![1];
            ilceListesi = snapshot.data![2];
             return 
       Center(
        child: CustomScrollView(
          shrinkWrap: true,

  slivers: [
SliverToBoxAdapter(
  child: Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(1.0),
        height: size.height * 0.35,
        width: size.width * 1,
        child: Image.asset(
          "assets/asilcami.png",
          fit: BoxFit.cover,
          height: size.height * 0.35,
          width: size.width * 1,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.8),
            ],
            stops: [0, 0, 0.5, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(1.0),
        height: size.height * 0.35,
        width: size.width * 1,
      ),
      Align(
        alignment: Alignment.bottomCenter,
child:Container(
        alignment: Alignment.center,
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.15,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.55, size.width * 0.05, size.width * 0.00),
          child: Column 
          
          
          (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children:
          
          [
          Text("Konum seçin",style: TextStyle(fontSize: 18 ,
          
          fontWeight: FontWeight.bold,
          ),), 

          Text("Sırasıyla konumunuzu etkinleştirmeniz gerekiyor",
          
          style: TextStyle(fontSize: 14 ,
          color:
                      Color(0xFFb7b7b7)),
          )

          ]),
      )
      )
    ],
  ),
),
SliverToBoxAdapter( 
  child: DropdownBottomSheetWidget(
        secilen: selectedUlke?.ulkeAdi ?? "",
        tip: "1",
        items: ulkeListesi.map((e) => e.ulkeAdi!).toList(),
        id : ulkeListesi.map((e) => e.ulkeID!).toList(),
        onSelected: (selected) async{
        selectedSehir = null;
        setState(() {
                    selectedUlke =   ulkeListesi.firstWhere((element) => element.ulkeAdi == selected);             
        selectedSehir = null;
selectedIlce = null;
        });
           
          print(selected);
        },
      ),),
 
 
 SliverToBoxAdapter( 
  child: FutureBuilder(
  future: Future.delayed(Duration(seconds: 2)),
  builder: (context, snapshot) {
    if (!_isLoading) {
      return
      
  AbsorbPointer(
    
  absorbing: selectedUlke == null, child: DropdownBottomSheetWidget(
        secilen: selectedSehir?.sehirAdi ?? "",
  tip: "2",
  id: sehirListesi.map((e) => e.sehirID!).toList(), 
  items: sehirListesi.map((e) => e.sehirAdi!).toList(),
  onSelected: (selected) async {
     if (selectedUlke == null) {
            Get.snackbar("Hata", "Lütfen önce şehir seçin");
            selectedSehir = null;
            selected = "";
          }
          else {
    setState(() {
      _isLoading = true; 
    });
    await Future.delayed(Duration(seconds: 3));
    setState(() {
          selectedSehir =  sehirListesi.firstWhere((element) => element.sehirAdi == selected);
      selectedIlce = null;
      _isLoading = false; 
    });
    
    print(selected);
  }},
  ));

    }
    else {
      return Center(child: CircularProgressIndicator());
    }
  },

)),
 SliverToBoxAdapter( 
  child: AbsorbPointer(
    
  absorbing: selectedSehir == null, child:  DropdownBottomSheetWidget(
    secilen: selectedIlce?.ilceAdi ?? "",
        tip: "3",
                id: ilceListesi.map((e) => e.ilceID!).toList(),

        items: ilceListesi.map((e) => e.ilceAdi!).toList(),
        onSelected: (selected)  {
          if (selectedSehir == null) {
            Get.snackbar("Hata", "Lütfen önce şehir seçin");
            selectedIlce = null;
          }
          else {
            setState(() {
          selectedIlce =  ilceListesi.firstWhere((element) => element.ilceAdi == selected);
          print(selected);
            });}
        },
      ),))
 ,
    SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.10,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
          child: GestureDetector(
      onTap: () async {
        print(selectedIlce.toString());
        print(selectedSehir);
if( selectedUlke.toString() != "null"  && selectedSehir.toString() != "null" && selectedIlce .toString() != "null"){
       await saveid(selectedUlke!, selectedSehir!, selectedIlce!);
      print("idler kaydedildi");
      AppConfig.login = true;
  
      
              Get.offAll(ImsakVakti());

}
else{
  Get.snackbar("Hata", "Lütfen tüm alanları doldurun");
  print("boş");
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
       ) ),
  ),

      SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.05,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.02, size.width * 0.05, size.width * 0.02),
      ),
  ),
  ]),
      );
            
          } else {
            return Center(child: CircularProgressIndicator());
          }
       
        },

      ),
    );

  }
}

class DropdownBottomSheetWidget extends StatefulWidget {
  final String tip ; 
  final List<String> items;
  final ValueChanged<String> onSelected;
  final List<String> id;
     String secilen;


   DropdownBottomSheetWidget({
    Key? key, 
    required this.items,
    required this.id,
    required this.tip,
    required this.onSelected,
    required this.secilen
  }) : super(key: key);

  @override
  _DropdownBottomSheetWidgetState createState() => _DropdownBottomSheetWidgetState();
}

class _DropdownBottomSheetWidgetState extends State<DropdownBottomSheetWidget> {

 var   isColored = false; 

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
    return GestureDetector(
      onTap: _showBottomSheet,
      child: Container(

       
         decoration: BoxDecoration(
          border: Border.all(
             
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
            borderRadius: BorderRadius.circular(10),
         gradient: 
         isColored? LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF21367f),
        Color(0xFF194d91),
        Color(0xFF1590c1),
        Color(0xFF0298ca),
        Color(0xFF0298ca),
      ],
      stops: [0.00, 0.2834, 0.8794, 0.9951, 1.0],
    
  ):
         
         LinearGradient(
              colors: [
           Colors.transparent,
                                Colors.transparent,

            /*     Color(0xFF21367F),
              */
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
          height: size.height * 0.08,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.025, size.width * 0.05, size.width * 0.025),
          child: Center(child: 
          Row(
            mainAxisAlignment: 
            MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Row(children: [
           Container(
          height: size.height * 0.1,
          width: size.width * 0.08,
          
  padding: EdgeInsets.all(1),
  margin: EdgeInsets.fromLTRB(0, 0,0, 0),
          decoration: BoxDecoration(
            gradient: 
            
             widget.tip== "1" ? LinearGradient(
              colors: [
             Color(0xFFFF4040).withOpacity(0.2),
              Color(0xFFFF4040).withOpacity(0.2)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ):
widget.tip == "2" ? LinearGradient(
              colors: [
                 Color(0xFFa659ff).withOpacity(0.2),
              Color(0xFFa659ff).withOpacity(0.2)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ):


            
            LinearGradient(
              colors: [
            //    Color(0xFF21367F),
            Colors.grey.withOpacity(0.3),
                        Colors.grey.withOpacity(0.3),

              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: 

        SizedBox(child:
                SvgPicture.asset("assets/pusu.svg",color:  widget.tip== "1" ? Colors.red : widget.tip== "2" ? 
          Color(0xFFa659ff):  Colors.blue,height: 15,width:15 , fit: BoxFit.scaleDown ,
             )),
                     
             ),
SizedBox(width: 25,),

              Container(child:
              widget.tip== "1" ?
Text("${widget.secilen == '' ? 'Ülke' : widget.secilen}",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ))
: widget.tip== "2" ? Text("${widget.secilen == '' ? 'İl' : widget.secilen}",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ))
: widget.tip== "3" ? Text("${widget.secilen == '' ? 'İlçe' : widget.secilen}",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ))
: Text( "",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ),),
              )

              
            ]),

            Container(
          height: size.height * 0.20,
          width: size.width * 0.20,
          
  padding: EdgeInsets.all(2),
  margin: EdgeInsets.fromLTRB(0, 1,1, 0),
         
          child:
             Row(children: [
              widget.tip== "1" ? 
            Text( "Ülke",style: TextStyle(fontSize: 16 ,color: isColored ? Colors.white :  Colors.grey.withOpacity(0.5)  ))
            : widget.tip== "2" ?             Text( "İl",style: TextStyle(fontSize: 16 ,color:isColored ? Colors.white :  Colors.grey.withOpacity(0.5) ))
            : widget.tip== "3" ?             Text( "İlçe",style: TextStyle(fontSize: 16 ,color: isColored ? Colors.white :  Colors.grey.withOpacity(0.5) ))
            : Text( "",style: TextStyle(fontSize: 16 ,color: isColored ? Colors.white :  Colors.grey.withOpacity(0.5) )),
    Icon(Icons.arrow_drop_down),

            ],)
            ),
          /*   Container(child: 
            Image.asset("assets/ok.png")) */
            

    ]),
          ) 
      )
    );
  }
void _showBottomSheet() {
    setState(() {
    // Rengi değiştirmek için bir state ekleyebilirsiniz
    isColored = true; 
  });
List<String> _searchList = [];
  List<String> _defaultList = widget.items;
  _searchList= _defaultList;
 var _debounce;

    showModalBottomSheet(
      
      context: context,
      builder: (context) {
           return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        
        return Container(
          height: 500,
          child: Column(
            children: [
              TextField(              onChanged: (value) {
                
if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
  

      _searchList = value.isEmpty
        ? _defaultList
        : widget.items
                    .where((item) => 
                      item.toLowerCase().contains(value.toLowerCase()))
                    .toList();

      setState(() {});
    }); },

                decoration: InputDecoration(
                  hintText: 'Ara'  
                ),
              ),

              // Liste
              Expanded(
                child: ListView.builder(
                  itemCount: _searchList.length,
                  itemBuilder: (context, index) {
                    final item = _searchList[index];

                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        // Seçimi güncelle
                        setState(() {
                          widget.secilen = item;
                        });
                        
                        // Callback'i çağır
                        widget.onSelected(item);

                        // Sayfayı kapat
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      });}
    ); 

    
    Future.delayed(Duration(seconds: 2), () {
    setState(() {
      isColored = false;  
    });
  });
  
}
}
