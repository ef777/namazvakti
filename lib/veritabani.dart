import 'package:intl/intl.dart';
import 'package:namazvakti/alarm.dart';
import 'package:namazvakti/config.dart';
import 'package:namazvakti/model-control/vakitlermodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VeritabaniYardimcisi {

  static final String veritabaniAdi = "namaz_vakitleri.db";

  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(), veritabaniAdi);

    Database db = await openDatabase(veritabaniYolu, version: 1, 
    
    //onCreate: _onCreate
    );
    return db;
  }
  Future<void> veriEkle(Vakit vakit) async {

  Database db = await VeritabaniYardimcisi.veritabaniErisim();
 
  await db.insert(
    'namaz_vakitleri', 
    {
      "tarih": vakit.miladiTarihKisa,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

 /* static Future<void> _onCreate(Database db, int version) async {
    print("veritabanı.dartta on create çalıştı");
    await db.execute(
      "CREATE TABLE namaz_vakitleri("
      "tarih TEXT"  
      ")"
    );
  } */

  static Future<List<Map<String, dynamic>>> tumNamazVakitleriniOku() async {
    Database db = await veritabaniErisim();
   
     List<Map<String, dynamic>> a =await db.query("namaz_vakitleri");
      print("veri tabanından okundu");
      print(a.toString());
     print(a.length.toString() + " adet veri okundu" );

    return await a;

  }

  Future<void> veritabaniolustur() async {
  Database db = await veritabaniErisim();

  var tableExists = await db
      .query("sqlite_master", where: "type = 'table' AND name = 'namaz_vakitleri'")
      .then((value) => value.isNotEmpty);
 print("veritabani işte burada $tableExists");
  if (!tableExists) {
    // Tablo yok, oluştur
    await db.execute(
      "CREATE TABLE namaz_vakitleri("  
        "tarih TEXT"    
      ")"
    );
    print("olusturuldu");
  } else {
    print("Tablo zaten var");  
  }
}

  veritabanisil()async{
    Database db = await veritabaniErisim();

      await db.execute('DROP TABLE namaz_vakitleri');
    print("silindi");
  }
   namazvakital()async{
  NamazVakitleri a= await NamazVakitleri.getNamazVakitleri(AppConfig.ilceid);
  print("namaz vakitleri alındı");
  // burada günümüzden öncesindeki verileri silmemiz gerekiyor



  return a;
  }

  namazvakitfiltre(List<Vakit>  vakitler){
  List<Vakit> yenivakits= [];
 DateTime suan= DateTime.now();
  print("ilk vakit uzunlugu : " + vakitler.length.toString());
  print(vakitler[0].miladiTarihKisa);

 for (var item in vakitler) 
  { print("tarih kontrol ediliyor");
  String formatlanmisTarihStr = DateFormat('dd.MM.yyyy').parse(item.miladiTarihKisa).toString(); 
    if(DateTime.parse(formatlanmisTarihStr).isAfter(suan) ){
      yenivakits.add(item);
      print("bu tarih gelecek");
    }
    else{
      print("bu tarih geçmiş");
      print(item.miladiTarihKisa);

    }

   print(item.miladiTarihKisa);
 }


print("filtrelenmiş vakit uzunlugu : " + yenivakits.length.toString());

 return yenivakits;
  }
  Future<void> tarihicontrolEt() async {
    print("vakit alarm kontrol ediliyor");
NamazVakitleri gelennamaz= await namazvakital();
print( gelennamaz.vakitler.length.toString() + " adet namaz vakiti alındı" );
  List<Vakit> vakits= await gelennamaz.vakitler;
    vakits =   namazvakitfiltre(vakits);



for (var i = 0 ; i <vakits.length; i ++){
  var db = await VeritabaniYardimcisi.veritabaniErisim();

  var result = await db.query('namaz_vakitleri', where: 'tarih = ?', whereArgs: [vakits[i].miladiTarihKisa]);
if(result.isEmpty ){
  print("sorgu yapıldi ve ilgili günde alarm bulunamadı");
print("alarm kurulu değil");
  print("kur");
  var eklensin_mi=0;
 if( AppConfig.ezanvaktibildirim["imsak"]!["vaktinde"]![0] =="1");
 {
 eklensin_mi=1;
  bildirimkur(vakits[i] , vakits[i].imsakdate.toString());
  
   }
   
    if (AppConfig.ezanvaktibildirim["oglen"]!["vaktinde"]![0] =="1");

    { eklensin_mi=1;
        bildirimkur(vakits[i] , vakits[i].ogledate.toString());

    }

    if (AppConfig.ezanvaktibildirim["ikindin"]!["vaktinde"]![0] =="1");

    { eklensin_mi=1;
        bildirimkur(vakits[i] , vakits[i].ikindidate.toString());

    }
    if (AppConfig.ezanvaktibildirim["aksam"]!["vaktinde"]![0] =="1");
    {
 eklensin_mi=1;
        bildirimkur(vakits[i] , vakits[i].aksamdate.toString());
    }
       if ( AppConfig.ezanvaktibildirim["yatsi"]!["vaktinde"]![0] =="1");
       { eklensin_mi=1;
  bildirimkur(vakits[i] , vakits[i].yatsidate.toString());
       }
if(eklensin_mi==1){
  veriEkle(vakits[i]);
 print("veri tabanina ilgili gün eklendi");
}   
}
else{
  print("alarm kurulu");

}

}
print("döngü bitti");
 List<Map<String, dynamic>>  a = await tumNamazVakitleriniOku();
print(a.toString());

  }

bildirimkur(Vakit vakit,String Kurulan_tarih) async {
  print("bildirim kuruluyor");
  print(Kurulan_tarih.toString() + " tarihli bildirim kuruluyor");
     
  NotificationService.bildirimayarla(  
      '${Kurulan_tarih}', 
 "${AppConfig.bildirim_title}",
      "${AppConfig.bildirim_content}",
   '${AppConfig.sehirname}',
    '0',
    '${vakit.imsakdate.hour}:${vakit.imsakdate.minute} ',
    '${vakit.gunesdate.hour}:${vakit.gunesdate.minute} ',
    '${vakit.ogledate.hour}:${vakit.ogledate.minute} ',
    '${vakit.ikindidate.hour}:${vakit.ikindidate.minute} ',
        '${vakit.aksamdate.hour}:${vakit.aksamdate.minute} ',
                '${vakit.yatsidate.hour}:${vakit.yatsidate.minute}'
);
}


}