import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tez2/models/user.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<bool> isFavorite(String ilanId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;
    final doc = await _firestore.collection('users').doc(userId).get();
    final favoriler = List<String>.from(doc['favoriler'] ?? []);
    return favoriler.contains(ilanId);
  }

  Future<void> toggleFavorite(String ilanId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    final docRef = _firestore.collection('users').doc(userId);
    final doc = await docRef.get();
    final favoriler = List<String>.from(doc['favoriler'] ?? []);
    if (favoriler.contains(ilanId)) {
      favoriler.remove(ilanId);
    } else {
      favoriler.add(ilanId);
    }
    await docRef.update({'favoriler': favoriler});
  }

  Future<List<String>> getFavoriler() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];
    final doc = await _firestore.collection('users').doc(userId).get();
    return List<String>.from(doc['favoriler'] ?? []);
  }

  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(doc.data()!);
  }

  Future<void> updateProfile(String kullaniciAdi, String? telefon) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore.collection('users').doc(user.uid).update({
      'kullaniciAdi': kullaniciAdi,
      'telefon': telefon,
    });
  }

  Future<void> createUserIfNotExists(User firebaseUser) async {
    final docRef = _firestore.collection('users').doc(firebaseUser.uid);
    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'kullaniciAdi': firebaseUser.displayName ?? '',
        'email': firebaseUser.email ?? '',
        'profilFotoUrl': firebaseUser.photoURL,
        'favoriler': [],
      });
    }
  }
}
