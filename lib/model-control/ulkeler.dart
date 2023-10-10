import 'dart:convert';
import 'package:http/http.dart' as http;

class Ulke {
  String? ulkeAdi;
  String? ulkeAdiEn;
  String? ulkeID;

  Ulke({this.ulkeAdi, this.ulkeAdiEn, this.ulkeID});

  Ulke.fromJson(Map<String, dynamic> json) {
    ulkeAdi = json['UlkeAdi'];
    ulkeAdiEn = json['UlkeAdiEn'];
    ulkeID = json['UlkeID'];
  }
}

// Kullanım:

List<Ulke> parseUlkeListesi(String jsonString) {
  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Ulke>((json) => Ulke.fromJson(json)).toList();
}

// Fetch ile kullanımı: 

Future<List<Ulke>> fetchUlkeListesi() async {
  final response = await http.get(Uri.parse("http://vakitlerapix.namazvaktipro.com/ulkeler"));
  
  if(response.statusCode == 200) {
    return parseUlkeListesi(response.body); 
  } else {
    throw Exception('Failed to load ulkeler');
  }
}