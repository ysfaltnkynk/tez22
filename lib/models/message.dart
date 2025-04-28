import 'package:cloud_firestore/cloud_firestore.dart';

class Mesaj {
  String id;
  String ilanId;
  String gonderenId;
  String aliciId;
  String icerik;
  DateTime createdAt;

  Mesaj({
    required this.id,
    required this.ilanId,
    required this.gonderenId,
    required this.aliciId,
    required this.icerik,
    required this.createdAt,
  });

  factory Mesaj.fromMap(Map<String, dynamic> map) => Mesaj(
        id: map['id'],
        ilanId: map['ilanId'],
        gonderenId: map['gonderenId'],
        aliciId: map['aliciId'],
        icerik: map['icerik'],
        createdAt: (map['createdAt'] as Timestamp).toDate(),
      );
}
