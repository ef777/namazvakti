import 'dart:convert';

import 'package:http/http.dart' as http;

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
      sehirAdi: json['sehirAdi'] as String,
      sehirAdiEn: json['sehirAdiEn'] as String,
    );
  }
}

List<Sehir> parseSehirListesi(String cevap) {
  final parsed = json.decode(cevap).cast<Map<String, dynamic>>();
  return parsed.map<Sehir>((json) => Sehir.fromJson(json)).toList();
}

Future<List<Sehir>> getSehirler(String id) async {
  final url = Uri.https("http://vakitlerapix.namazvaktipro.com/sehirler?ulke=$id", );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return parseSehirListesi(response.body);
  } else {
    throw Exception('Failed to load sehirler');
  }
}