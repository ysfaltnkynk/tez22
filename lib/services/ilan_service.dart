import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ilan.dart';
import '../services/auth_service.dart';

class IlanService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Ilan>> getFavorites(String userId) async* {
    final userDoc = _firestore.collection('users').doc(userId);

    await for (var snapshot in userDoc.snapshots()) {
      final data = snapshot.data();
      if (data == null) {
        yield [];
        continue;
      }
      final favoriler = List<String>.from(data['favoriler'] ?? []);
      if (favoriler.isEmpty) {
        yield [];
        continue;
      }
      final ilanlar = await getIlanlarByIds(favoriler);
      yield ilanlar;
    }
  }

  Future<List<Ilan>> getIlanlar({
    String? tur,
    String? evTipi,
    int? minYas,
    int? maxYas,
    String? arama,
  }) async {
    Query q = _firestore.collection('ilanlar');
    if (tur != null && tur != 'Hepsi') q = q.where('tur', isEqualTo: tur);
    if (evTipi != null && evTipi != 'Hepsi')
      q = q.where('evTipi', isEqualTo: evTipi);
    if (arama != null && arama.isNotEmpty)
      q = q
          .where('baslik', isGreaterThanOrEqualTo: arama)
          .where('baslik', isLessThanOrEqualTo: '$arama\uf8ff');
    final snap = await q.get();
    List<Ilan> ilanlar = snap.docs
        .map((d) => Ilan.fromMap(d.data() as Map<String, dynamic>))
        .toList();
    if (minYas != null)
      ilanlar = ilanlar.where((i) => i.binaYasi >= minYas).toList();
    if (maxYas != null)
      ilanlar = ilanlar.where((i) => i.binaYasi <= maxYas).toList();
    return ilanlar;
  }

  Future<List<Ilan>> getIlanlarByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final snap = await _firestore
        .collection('ilanlar')
        .where(FieldPath.documentId, whereIn: ids)
        .get();
    return snap.docs.map((d) => Ilan.fromMap(d.data())).toList();
  }

  Future<List<Ilan>> getMyIlanlar() async {
    final uid = AuthService().currentUser?.uid;
    if (uid == null) return [];
    final snap = await _firestore
        .collection('ilanlar')
        .where('kullaniciId', isEqualTo: uid)
        .get();
    return snap.docs.map((d) => Ilan.fromMap(d.data())).toList();
  }

  Future<void> ilanEkle({
    required String baslik,
    required String aciklama,
    required double fiyat,
    required String tur,
    required String evTipi,
    required int binaYasi,
    required List<String> fotoUrls,
  }) async {
    final uid = AuthService().currentUser?.uid;
    final doc = _firestore.collection('ilanlar').doc();
    await doc.set({
      'id': doc.id,
      'baslik': baslik,
      'aciklama': aciklama,
      'fiyat': fiyat,
      'tur': tur,
      'evTipi': evTipi,
      'binaYasi': binaYasi,
      'fotoUrls': fotoUrls,
      'kullaniciId': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
