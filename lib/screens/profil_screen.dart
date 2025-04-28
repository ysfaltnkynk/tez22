import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));

        // Kullanıcı yoksa giriş ekranına yönlendir
        if (!snapshot.hasData) {
          // Build sırasında tekrar tekrar yönlendirme olmaması için:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/giris');
          });
          return SizedBox.shrink();
        }

        final user = snapshot.data!;
        // Profil ekranını göster
        return Scaffold(
          appBar: AppBar(title: Text('Profilim')),
          body: ListView(
            children: [
              SizedBox(height: 32),
              CircleAvatar(
                radius: 48,
                backgroundImage: user.profilFotoUrl != null
                    ? NetworkImage(user.profilFotoUrl!)
                    : null,
                child: user.profilFotoUrl == null
                    ? Icon(Icons.person, size: 48)
                    : null,
              ),
              SizedBox(height: 16),
              Center(
                  child:
                      Text(user.kullaniciAdi, style: TextStyle(fontSize: 20))),
              Center(child: Text(user.email)),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Hesap Ayarları'),
                onTap: () => Navigator.pushNamed(context, '/hesap_ayar'),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('İlanlarım'),
                onTap: () => Navigator.pushNamed(context, '/ilanlarim'),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorilerim'),
                onTap: () => Navigator.pushNamed(context, '/favorilerim'),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Çıkış Yap'),
                onTap: () async {
                  await AuthService().signOut();
                  Navigator.pushReplacementNamed(context, '/giris');
                },
              ),
            ],
          ),
          bottomNavigationBar:
              BottomNavBar(currentIndex: 3), // Profil sekmesi için 3
        );
      },
    );
  }
}
