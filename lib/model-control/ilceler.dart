import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Ilce {
  String? ilceAdi;
  String? ilceAdiEn;
  String? ilceID;

  Ilce({this.ilceAdi, this.ilceAdiEn, this.ilceID});

  factory Ilce.fromJson(Map<String, dynamic> json) {
    return Ilce(
      ilceAdi: json['IlceAdi'] as String,
      ilceAdiEn: json['IlceAdiEn'] as String,  
      ilceID: json['IlceID'] as String,
    );
  }
}

List<Ilce> parseIlceListesi(String cevap) {
  final parsed = json.decode(cevap).cast<Map<String, dynamic>>();
  return parsed.map<Ilce>((json) => Ilce.fromJson(json)).toList();
}

Future<List<Ilce>> getIlceler(String sehirid) async {
  final url = Uri.https("http://vakitlerapix.namazvaktipro.com/ilceler?sehir=$sehirid", );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return compute(parseIlceListesi, response.body);
  } else {
    throw Exception('Failed to load ilceler');
  }
}