import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/favorilerim_screen.dart';
import 'screens/giris_screen.dart';
import 'screens/hesap_ayar_screen.dart';
import 'screens/home_screen.dart';
import 'screens/ilan_ekle_screen.dart';
import 'screens/ilanlarim_screen.dart';
import 'screens/kayit_screen.dart';
import 'screens/mesaj_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/sifre_sifirla_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camelot',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/giris': (context) => GirisScreen(),
        '/kayit': (context) => KayitScreen(),
        '/ilan_ekle': (context) => IlanEkleScreen(),
        '/profil': (context) => ProfilScreen(),
        '/mesajlar': (context) => MesajlarScreen(),
        '/favorilerim': (context) => FavorilerimScreen(),
        '/ilanlarim': (context) => IlanlarimScreen(),
        '/hesap_ayar': (context) => HesapAyarScreen(),
        '/sifre_sifirla': (context) => SifreSifirlaScreen(),
        // ilan detay ve mesaj ekranı route'ları için onGenerateRoute kullanılabilir.
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          // Kullanıcı giriş yapmış
          return HomeScreen();
        } else {
          // Kullanıcı giriş yapmamış
          return GirisScreen();
        }
      },
    );
  }
}
