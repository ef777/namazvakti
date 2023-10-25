class IsimModeli {
  String? kizIsmi;
  String? kizIsmiManasi;
  String? erkekIsmi;
  String? erkekIsmiManasi;

  IsimModeli({
    this.kizIsmi,
    this.kizIsmiManasi,
    this.erkekIsmi,
    this.erkekIsmiManasi
  });

  factory IsimModeli.fromJson(Map<String, dynamic> json) {
    return IsimModeli(
      kizIsmi: json['kiz_ismi'],
      kizIsmiManasi: json['kiz_ismi_manasi'],
      erkekIsmi: json['erkek_ismi'],
      erkekIsmiManasi: json['erkek_ismi_manasi']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kiz_ismi'] = kizIsmi;
    data['kiz_ismi_manasi'] = kizIsmiManasi;
    data['erkek_ismi'] = erkekIsmi;
    data['erkek_ismi_manasi'] = erkekIsmiManasi;
    return data;
  }
}