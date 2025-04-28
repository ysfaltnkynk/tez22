import 'package:cloud_firestore/cloud_firestore.dart';

class Ilan {
  String ilanid;
  String baslik;
  String aciklama;
  double fiyat;
  String tur;
  int binaYasi;
  List<String> fotoUrls;
  String kullaniciId;
  DateTime createdAt;
  String lokasyon;
  int oda;

  Ilan({
    required this.ilanid,
    required this.baslik,
    required this.aciklama,
    required this.fiyat,
    required this.tur,
    required this.binaYasi,
    required this.fotoUrls,
    required this.kullaniciId,
    required this.createdAt,
    required this.lokasyon,
    required this.oda,
  });

  factory Ilan.fromMap(Map<String, dynamic> map) => Ilan(
        ilanid: map['id'],
        baslik: map['baslik'],
        aciklama: map['aciklama'],
        fiyat: (map['fiyat'] as num).toDouble(),
        tur: map['tur'],
        binaYasi: map['binaYasi'] is int
            ? map['binaYasi']
            : int.tryParse(map['binaYasi'].toString()) ?? 0,
        fotoUrls: map['fotoğraf'],
        kullaniciId: map['kullaniciId'],
        createdAt: (map['createdAt'] as Timestamp).toDate(),
        lokasyon: map['lokasyon'],
        oda: map['oda sayısı'],
      );
}
