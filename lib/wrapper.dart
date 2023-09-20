
import 'package:flutter/material.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/home.dart';
import 'package:namazvakti/wellcome.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
 

 giriskont(){
 if (AppConfig.login==false) {
   return WellcomePage();


 }
  else{
    return HomePage();
  }}



  @override
  void initState() {
    super.initState();
  
    
  }

  @override
  Widget build(BuildContext context) {
    if (1!=1) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConfig.col2,
              AppConfig.col1,
            ],
          ),
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

    return giriskont();
  }
}
