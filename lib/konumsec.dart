import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namazvakti/home.dart';

class KonumSec extends StatefulWidget {
  @override
  State<KonumSec> createState() => _KonumSecState();
}

class _KonumSecState extends State<KonumSec> {
  @override
    bool _isChecked = false;
final ulkeler = ['Türkiye', 'Almanya', 'Fransa'];
final sehirler = ['Ankara', 'Konya', 'Bayburt'];
final ilceler = ['ilce1', 'ilce2', 'ilce3'];

  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
    return Scaffold(
     
      body: Center(
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
          height: size.height * 0.12,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.55, size.width * 0.05, size.width * 0.00),
          child: Column (children:
          
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
        tip: "1",
        items: ulkeler,
        onSelected: (selected) {
          print(selected);
        },
      ),),
   SliverToBoxAdapter( 
  child: DropdownBottomSheetWidget(
        tip: "2",
        items: sehirler,
        onSelected: (selected) {
          print(selected);
        },
      ),),
    SliverToBoxAdapter( 
  child: DropdownBottomSheetWidget(
        tip: "3",
        items: ilceler,
        onSelected: (selected) {
          print(selected);
        },
      ),)
 ,
    SliverToBoxAdapter(
      child: Container(
         padding: EdgeInsets.all(10.0),
          height: size.height * 0.10,
          width: size.width * 0.8,
         margin: EdgeInsets.fromLTRB(
              size.width * 0.05, size.width * 0.06, size.width * 0.05, size.width * 0.06),
          child: GestureDetector(
      onTap: () {
        Get.offAll(HomePage());
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
      ),
    );
   
  }
}

class DropdownBottomSheetWidget extends StatefulWidget {
  final String tip ; 
  final List<String> items;
  final ValueChanged<String> onSelected;

  const DropdownBottomSheetWidget({
    Key? key, 
    required this.items,
    required this.tip,
    required this.onSelected
  }) : super(key: key);

  @override
  _DropdownBottomSheetWidgetState createState() => _DropdownBottomSheetWidgetState();
}

class _DropdownBottomSheetWidgetState extends State<DropdownBottomSheetWidget> {

  String selectedItem = '';
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
Text("${selectedItem == '' ? 'Ülke' : selectedItem}",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ))
: widget.tip== "2" ? Text("${selectedItem == '' ? 'İl' : selectedItem}",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ))
: widget.tip== "3" ? Text("${selectedItem == '' ? 'İlçe' : selectedItem}",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ))
: Text( "",style: TextStyle(fontSize: 16,color: isColored ? Colors.white : Colors.black ),),
              )

              
            ]),

          /*   Container(child: 
            Image.asset("assets/ok.png")) */
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

    showModalBottomSheet(
      
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ara'  
                ),
              ),

              // Liste
              Expanded(
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];

                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        // Seçimi güncelle
                        setState(() {
                          selectedItem = item;
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
      }
    );
    Future.delayed(Duration(seconds: 2), () {
    setState(() {
      isColored = false;  
    });
  });
  }

}
