import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Sehir {
  String? sehirID;
  String? sehirAdi;
  String? sehirAdiEn;

  Sehir({
    this.sehirID,
    this.sehirAdi,
    this.sehirAdiEn,
  });

  factory Sehir.fromJson(Map<String, dynamic> json) {
    return Sehir(
      sehirID: json['sehirID'] as String,
sehirAdi: (utf8.decode(json["sehirAdi"].toString().codeUnits)) as String,
      sehirAdiEn: json['sehirAdiEn'] as String,
    );
  }


static List<Sehir> parseSehirListesi(String cevap) {
  final parsed = json.decode(cevap,  
  ).cast<Map<String, dynamic>>();
var  sehirler = <Sehir>[];
  for (var item in parsed) {
    sehirler.add(Sehir.fromJson(item));
  }
  print("dönen şehirler");
  print(sehirler);

  return sehirler;
}

static Future<List<Sehir>> getSehirler(String id) async {
  final url = Uri.parse("http://vakitlerapix.namazvaktipro.com/sehirler?ulke=$id" );
  final response = await http.get(url,headers: {
  "Content-Type": "application/json; charset=utf-8",}  );
  if (response.statusCode == 200) {
    return parseSehirListesi(response.body);
  } else {
    throw Exception('Failed to load sehirler');
  }
}}