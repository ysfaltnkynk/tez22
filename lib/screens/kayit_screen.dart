import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class KayitScreen extends StatefulWidget {
  @override
  State<KayitScreen> createState() => _KayitScreenState();
}

class _KayitScreenState extends State<KayitScreen> {
  String email = '', sifre = '', kullaniciAdi = '';
  final _formKey = GlobalKey<FormState>();
  String? hata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kayıt Ol')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (hata != null)
                Text(hata!, style: TextStyle(color: Colors.red)),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-posta'),
                onChanged: (v) => email = v,
                validator: (v) => v!.isEmpty ? 'E-posta gerekli' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                onChanged: (v) => sifre = v,
                validator: (v) => v!.isEmpty ? 'Şifre gerekli' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
                onChanged: (v) => kullaniciAdi = v,
                validator: (v) => v!.isEmpty ? 'Kullanıcı adı gerekli' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result =
                        await AuthService().signUp(email, sifre, kullaniciAdi);
                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Kayıt başarılı! Lütfen e-postanızı doğrulayın.')));
                      Navigator.pushReplacementNamed(context, '/giris');
                    } else {
                      setState(() => hata = 'Kayıt başarısız');
                    }
                  }
                },
                child: Text('Kaydol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
