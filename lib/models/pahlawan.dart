class Pahlawan {
  String? nama;
  String? nama2;
  String? kategori;
  String? asal;
  String? lahir;
  String? usia;
  String? gugur;
  String? lokasimakam;
  String? history;
  String? img;

  Pahlawan(
      {nama,
      nama2,
      kategori,
      asal,
      lahir,
      usia,
      gugur,
      lokasimakam,
      history,
      img});

  Pahlawan.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    nama2 = json['nama2'];
    kategori = json['kategori'];
    asal = json['asal'];
    lahir = json['lahir'];
    usia = json['usia'];
    gugur = json['gugur'];
    lokasimakam = json['lokasimakam'];
    history = json['history'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['nama2'] = nama2;
    data['kategori'] = kategori;
    data['asal'] = asal;
    data['lahir'] = lahir;
    data['usia'] = usia;
    data['gugur'] = gugur;
    data['lokasimakam'] = lokasimakam;
    data['history'] = history;
    data['img'] = img;
    return data;
  }
}
