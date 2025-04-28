import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';

class MessageService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> mesajGonder(String ilanId, String icerik) async {
    final user = AuthService().currentUser;
    if (user == null) return;
    final doc = _firestore.collection('mesajlar').doc();
    await doc.set({
      'id': doc.id,
      'ilanId': ilanId,
      'gonderenId': user.uid,
      'aliciId': '', // ilan sahibinin user id'si eklenmeli
      'icerik': icerik,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Sohbet listesini getir (örnek, sadeleştirilmiş)
  Stream<List<Map<String, dynamic>>> getChatStream(String ilanId) {
    final uid = AuthService().currentUser?.uid;
    return _firestore
        .collection('mesajlar')
        .where('ilanId', isEqualTo: ilanId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              return {
                'icerik': data['icerik'],
                'benim': data['gonderenId'] == uid,
              };
            }).toList());
  }

  // Kullanıcının tüm sohbetlerinin kısa listesi (örnek)
  Future<List<Map<String, dynamic>>> getMyChats() async {
    final uid = AuthService().currentUser?.uid;
    if (uid == null) return [];
    final snap = await _firestore
        .collection('mesajlar')
        .where('gonderenId', isEqualTo: uid)
        .get();
    // Burada daha gelişmiş bir sohbet listesi üretilebilir.
    return snap.docs.map((d) => d.data()).toList();
  }
}
