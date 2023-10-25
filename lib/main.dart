import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:namazvakti/dinigunler.dart';
import 'package:namazvakti/dinihikaye.dart';
import 'package:namazvakti/dualar.dart';
import 'package:namazvakti/esmaulhusna.dart';
import 'package:namazvakti/home.dart';
import 'package:namazvakti/kaza.dart';
import 'package:namazvakti/namazdualari.dart';
import 'package:namazvakti/radyolar.dart';
import 'package:namazvakti/rehber.dart';
import 'wrapper.dart';

import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting();
  await GetStorage.init();


  runApp( MyApp());
}

// It is assumed that all messages contain a data field with the key 'type'

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // İngilizce
        const Locale('tr', ''), // Türkçe
        // Diğer desteklenen dilleri buraya ekleyin
      ],
 title: 'Uygulama',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/dinigunler', page: () => DiniGunlerView()   ),
        GetPage(name: '/', page: () => Wrapper()),
                GetPage(name: '/acilis', page: () => Wrapper()),
         GetPage(name: '/namazdua', page: () => NamazDua()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/kaza', page: () => Kazalar()),
          GetPage(name: '/esma', page: () => EsmaUl()),
          GetPage(name: '/dualar', page: () => Dualar()),
          GetPage(name: '/hikaye', page: () => DiniHikaye()),
          GetPage(name: '/rehber', page: () => Rehber()),
          GetPage(name: '/radyolar', page: () => Radyolar())
        
      ],

     /*    initialRoute: '/', routes: {
/*       '/': (context) => WellcomePage(),
 */   
        } */
   /*   localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('tr', ''), // Turkish
          // Eğer başka diller de desteklemek isterseniz onları da buraya ekleyebilirsiniz.
          // Örneğin İngilizce için: const Locale('en', ''),
        ], */
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(fontFamily: 'MDSans'),
            bodyText2: TextStyle(fontFamily: 'MDSans'),
          ),

          bottomAppBarColor: Colors.transparent,
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)))),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF2B2B40),
          ),
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),

          primaryColor:
              Color.fromARGB(255, 255, 255, 255), // butonlar için ana renk
          // butonlar için ikincil renk
        ),
        home: Align(
            alignment: Alignment.center,
            child:Wrapper()
            ));
  }
}
