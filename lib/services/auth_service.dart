import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  final _firestore = FirebaseFirestore.instance;

  bool get isLoggedIn => _auth.currentUser != null;

  Future<User?> signIn(String email, String sifre) async {
    try {
      final result =
          await _auth.signInWithEmailAndPassword(email: email, password: sifre);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signUp(String email, String sifre, String kullaniciAdi) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: sifre);
      await _firestore.collection('users').doc(result.user!.uid).set({
        'id': result.user!.uid,
        'email': email,
        'kullaniciAdi': kullaniciAdi,
        'favoriler': [],
      });
      await result.user!.sendEmailVerification();
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Firestore'a kullanıcıyı ekle (ilk girişse)
    await UserService().createUserIfNotExists(credential.user!);
  }
}
