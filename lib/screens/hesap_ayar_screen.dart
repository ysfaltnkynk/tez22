import 'package:flutter/material.dart';

import '../services/user_service.dart';

class HesapAyarScreen extends StatefulWidget {
  @override
  State<HesapAyarScreen> createState() => _HesapAyarScreenState();
}

class _HesapAyarScreenState extends State<HesapAyarScreen> {
  String? kullaniciAdi, telefon;
  final _formKey = GlobalKey<FormState>();
  String? mesaj;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getCurrentUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        final user = snapshot.data!;
        kullaniciAdi ??= user.kullaniciAdi;
        telefon ??= user.telefon;
        return Scaffold(
          appBar: AppBar(title: Text('Hesap Ayarları')),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (mesaj != null)
                    Text(mesaj!, style: TextStyle(color: Colors.green)),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
                    initialValue: kullaniciAdi,
                    onChanged: (v) => kullaniciAdi = v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Telefon'),
                    initialValue: telefon,
                    onChanged: (v) => telefon = v,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await UserService().updateProfile(kullaniciAdi!, telefon);
                      setState(() => mesaj = "Profil güncellendi!");
                    },
                    child: Text('Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
