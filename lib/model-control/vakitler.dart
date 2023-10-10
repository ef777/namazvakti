import 'dart:convert';
import 'package:http/http.dart' as http;

class NamazVakitleri {
  List<Vakit> vakitler;

  NamazVakitleri(this.vakitler);

  factory NamazVakitleri.fromJson(List<dynamic> json) {
    List<Vakit> vakitler = json.map((e) => Vakit.fromJson(e)).toList();
    return NamazVakitleri(vakitler);
  }

}

class Vakit {
  String miladiTarihKisa;
  String miladiTarihUzun;
  String hicriTarihKisa;
  String hicriTarihUzun;
  String imsak;
  String gunes;
  String ogle;
  String ikindi;
  String aksam;
  String yatsi;
  String kibleAcisi;
  String kibleSaati;
  
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
    this.kibleSaati
  );

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
    );
  }

}

// JSON string'ini ayrıştır
Future<NamazVakitleri> getNamazVakitleri(String ilceId) async {

  final response = await http.get(Uri.parse("http://vakitlerapix.namazvaktipro.com/vakitler?ilce=$ilceId"));

  if (response.statusCode == 200) {

    // JSON çözümle 
    List<dynamic> jsonList = jsonDecode(response.body);

    // Nesneye çevir
    return NamazVakitleri.fromJson(jsonList);

  } else {

    // Hata durumunda
    throw Exception('Veri yüklenemedi');
  
  }

}