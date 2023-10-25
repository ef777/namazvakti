class SesModeli {
  String? name;
  String? dowlandUrl;

  SesModeli({this.name, this.dowlandUrl});

  factory SesModeli.fromJson(Map<String, dynamic> json) {
    return SesModeli(
      name: json['name'],
      dowlandUrl: json['dowlandUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['dowlandUrl'] = dowlandUrl;
    return data;
  }
}