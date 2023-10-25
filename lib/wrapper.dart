
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/home.dart';
import 'package:namazvakti/wellcome.dart';
   final controller = Get.put(AppConfig()); 

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  final box = GetStorage();

 // ilk kezz giris kontrol

giristum()async{

var giris = await controller.ilkgirismi();
if (giris==true) {
print("hop ilk kez giriyor");
    return true ;

}
else{
  await controller.okuid();
        AppConfig.login=true;

  print("hop ilk kez değil");
  return false;

}}


 // eğer giris yapılmışsa ve şehir info yoksa şehir seçim sayfasına yönlendir
 
// ardından uyarı vakitleri aç kapa yapılacak




  @override
  Widget build(BuildContext context) {
   
      return FutureBuilder(future: 
   giristum(),
      
       
      builder: 
      (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data==false) {
            return HomePage();
          }
          else{
            return WellcomePage();
          }

        } else {
          return Scaffold(
            body: Center(
              child:   Container(
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
      )
            ),
          )
          ;
        }
      },
    );
  }
}
      
       
  