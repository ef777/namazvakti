import 'package:flutter_html/flutter_html.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:namazvakti/anaekran.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/counter_view/counter_view.dart';
import 'package:namazvakti/imsak.dart';
import 'package:namazvakti/konumsec.dart';
import 'package:namazvakti/yenipusula.dart';

import 'menu.dart';
import 'wellcome.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 2.obs;
  static late TabController tabController;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomeController controller = Get.put(HomeController());
  
  @override
  void initState() {
    super.initState();
  
  }
  int _selectedIndex = 2;

 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
   var  height = size.height;
   var width = size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
    
        backgroundColor: Colors.white,
        actions: [],
        centerTitle: false,
        title: 
        
     Center(child:  Image.asset("assets/baslik.png",)) 
      
     ),
/*  body: _pages[_selectedIndex],
  */

  body: Container(child: Stack(
        children: [
          buildPage(_selectedIndex), // Replace with your page content
    
        ],
    )  ),


   bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
 
    );
 
 
  }
}
Widget buildPage(int index) {
    // Replace with your page content based on the selected index
    if(index==0){

return QiblahView() ;
   
    }
    if(index==1){
      return ImsakVakti();
    }
    if(index==2){
      return AnaEk();
      
    }
    if(index==3){
      return   CounterView();
    }

    if(index==4){

      return
                  Menu();

        
        

      
      
    }
    return Center(
      child: Text("Page $index Conten8t"),
    );
  }

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         
          buildNavItem( "assets/pusula.png", "Pusula", 0),
          buildNavItem("assets/kuraan.png", "Kur'an", 1),
          buildNavItem("assets/ayyildiz.png", "Vakitler", 2),
          buildNavItem("assets/zikir.png", "Zikir", 3),
          buildNavItem("assets/ve.png", "Vs", 4),
        ],
      ),
    );
  }

  Widget buildNavItem(String icon, String label, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == selectedIndex ? Colors.blue : Colors.transparent,
            ),
            padding: EdgeInsets.all(5),
            child: Stack(
              alignment: Alignment.center,
              children: [
               

                  Image(
                    height: selectedIndex == index ? 60 : 30,
                    width: selectedIndex == index ? 60 : 30,
            image: AssetImage(icon),
            color: selectedIndex == index ? Colors.white : Colors.grey,
                  )
                  ,
              
              ],
            ),
          ),
          SizedBox(height:  selectedIndex == index? 10 : 0),
          selectedIndex == index ?  Text(
            label,
            style: TextStyle(

              color: index == selectedIndex ? Colors.blue : Colors.transparent,
            ),
          ): Container()
        ],
      ),
    );
  }
}