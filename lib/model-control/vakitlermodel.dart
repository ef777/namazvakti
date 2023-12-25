import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NamazVakitleri {
  List<Vakit> vakitler;

  NamazVakitleri(this.vakitler);

  factory NamazVakitleri.fromJson(List<dynamic> json) {
    List<Vakit> vakitler = json.map((e) => Vakit.fromJson(e)).toList();
    return NamazVakitleri(vakitler);
  }

// JSON string'ini ayrıştır
static  Future<NamazVakitleri> getNamazVakitleri(String ilceId) async {
    final box = await GetStorage();

print("istek gitti");
print("ilce id : $ilceId ");
  try {
      final response = await http.get(Uri.parse("http://vakitlerapix.namazvaktipro.com/vakitler?ilce=$ilceId"));

  if (response.statusCode == 200) {
      await  box.write('namazvakitlericache', response.body);

    List<dynamic> jsonList = jsonDecode(response.body);
     var sonuc = NamazVakitleri.fromJson(jsonList);
    // Nesneye çevir
    return sonuc;
  } 
  else {
    print("ahanda hata catche düşmedi");
    var namazvakitler= await box.read('namazvakitlericache');
 List<dynamic> jsonList = jsonDecode(namazvakitler);
     var sonuc = NamazVakitleri.fromJson(jsonList);
     return sonuc;
  }
  }
  catch (e) {

    print("ahanda hata catche düştü");
 var namazvakitler= await box.read('namazvakitlericache');
 List<dynamic> jsonList = jsonDecode(namazvakitler);
     var sonuc = NamazVakitleri.fromJson(jsonList);
    // Nesneye çevir
    return sonuc;

  }

     
    // JSON çözümle 
    



  } 

}


class Vakit {
  String miladiTarihKisa;
  String miladiTarihUzun;
  String hicriTarihKisa;
  String hicriTarihUzun;
  String imsak;
  DateTime imsakdate;
  String gunes;
  DateTime gunesdate;
  String ogle;
  DateTime ogledate;
  String ikindi;
  DateTime ikindidate;
  String aksam;
  DateTime aksamdate;
  String yatsi;
  DateTime yatsidate;
  String kibleAcisi;
  String kibleSaati;
  DateTime vakitTarih;
  
  Vakit(
    this.miladiTarihKisa, 
    this.miladiTarihUzun,
    this.hicriTarihKisa,
    this.hicriTarihUzun, 
    this.imsak,
    this.gunes,
    this.ogle,
    this.ikindi,
    this.aksam,
    this.yatsi,
    this.kibleAcisi,
    this.kibleSaati,
    this.vakitTarih,
    this.imsakdate,
    this.gunesdate,
    this.ogledate,
    this.ikindidate,
    this.aksamdate,
    this.yatsidate,

  );

 static parsetime1(String tarihStr){
 //= '28.10.2023';
List<String> parcalar = tarihStr.split('.');

int gun = int.parse(parcalar[0]);
int ay = int.parse(parcalar[1]);  
int yil = int.parse(parcalar[2]);

DateTime tarih = DateTime(yil, ay, gun);
return tarih;
  }

static DateTime tarihSaatOlustur(String tarihStr, String saatStr) {

  List<String> tarihParcalari = tarihStr.split('.');
  int gun = int.parse(tarihParcalari[0]);
  int ay = int.parse(tarihParcalari[1]);  
  int yil = int.parse(tarihParcalari[2]);

  List<String> saatParcalari = saatStr.split(':');
  int saat = int.parse(saatParcalari[0]);
  int dakika = int.parse(saatParcalari[1]);

  return DateTime(yil, ay, gun, saat, dakika);

}
  factory Vakit.fromJson(Map<String, dynamic> json) {
    return Vakit(
      json['MiladiTarihKisa'],
      json['MiladiTarihUzun'],  
      json['HicriTarihKisa'],
      json['HicriTarihUzun'],
      json['Imsak'],

      json['Gunes'],
      json['Ogle'],
      json['Ikindi'],
      json['Aksam'],
      json['Yatsi'],
      json['KibleAcisi'],
      json['KibleSaati']  
      ,parsetime1(json['MiladiTarihKisa'])
      ,tarihSaatOlustur(json['MiladiTarihKisa'], json['Imsak'])
      ,tarihSaatOlustur(json['MiladiTarihKisa'], json['Gunes'])
      ,tarihSaatOlustur(json['MiladiTarihKisa'], json['Ogle'])
      ,tarihSaatOlustur(json['MiladiTarihKisa'], json['Ikindi'])
      ,tarihSaatOlustur(json['MiladiTarihKisa'], json['Aksam'])
      ,tarihSaatOlustur(json['MiladiTarihKisa'], json['Yatsi'])
      


    );
  }

}
