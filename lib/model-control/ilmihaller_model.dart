class IlmihalBilgi {
  String? baslik;
  String? konu;

  IlmihalBilgi({this.baslik, this.konu});

  factory IlmihalBilgi.fromJson(Map<String, dynamic> json) {
    return IlmihalBilgi(
      baslik: json['baslik'],
      konu: json['konu'],
    );
  }

  Map<String, dynamic> toJson() => {
        'baslik': baslik,
        'konu': konu,
      };
}