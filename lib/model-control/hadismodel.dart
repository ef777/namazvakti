class HadisModel {
  String? imsakHadisi;
  String? imsakMuctehidi;
  String? sabahHadisi;
  String? sabahMuctehidi;
  String? oglenHadisi;
  String? oglenMuctehidi;
  String? ikindiHadisi;
  String? ikindiMuctehidi;
  String? aksamHadisi;
  String? aksamMuctehidi; 
  String? yatsiHadisi;
  String? yatsiMuctehidi;

  HadisModel({
    this.imsakHadisi,
    this.imsakMuctehidi,
    this.sabahHadisi,
    this.sabahMuctehidi,
    this.oglenHadisi,
    this.oglenMuctehidi,
    this.ikindiHadisi,
    this.ikindiMuctehidi,
    this.aksamHadisi,
    this.aksamMuctehidi,
    this.yatsiHadisi,
    this.yatsiMuctehidi
  });

  factory HadisModel.fromJson(Map<String, dynamic> json) {
    return HadisModel(
      imsakHadisi: json['imsak_hadisi'],
      imsakMuctehidi: json['imsak_muctehidi'],
      sabahHadisi: json['sabah_hadisi'],
      sabahMuctehidi: json['sabah_muctehidi'],
      oglenHadisi: json['oglen_hadisi'],
      oglenMuctehidi: json['oglen_muctehidi'],
      ikindiHadisi: json['ikindi_hadisi'],
      ikindiMuctehidi: json['ikindi_muctehidi'],
      aksamHadisi: json['aksam_hadisi'],
      aksamMuctehidi: json['aksam_muctehidi'],
      yatsiHadisi: json['yatsi_hadisi'],
      yatsiMuctehidi: json['yatsi_muctehidi'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imsak_hadisi'] = imsakHadisi;
    data['imsak_muctehidi'] = imsakMuctehidi;
    data['sabah_hadisi'] = sabahHadisi;
    data['sabah_muctehidi'] = sabahMuctehidi;
    data['oglen_hadisi'] = oglenHadisi;
    data['oglen_muctehidi'] = oglenMuctehidi;
    data['ikindi_hadisi'] = ikindiHadisi;
    data['ikindi_muctehidi'] = ikindiMuctehidi;  
    data['aksam_hadisi'] = aksamHadisi;
    data['aksam_muctehidi'] = aksamMuctehidi;
    data['yatsi_hadisi'] = yatsiHadisi;
    data['yatsi_muctehidi'] = yatsiMuctehidi;
    return data;
  }
}