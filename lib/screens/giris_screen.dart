import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/bottom_nav_bar.dart';

class GirisScreen extends StatefulWidget {
  @override
  State<GirisScreen> createState() => _GirisScreenState();
}

class _GirisScreenState extends State<GirisScreen> {
  String email = '', sifre = '';
  String? hata;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result = await AuthService().signIn(email, sifre);
                    if (result != null) {
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      setState(() => hata = 'Giriş başarısız');
                    }
                  }
                },
                child: Text('Giriş Yap'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/kayit'),
                child: Text('Kaydol'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/sifre_sifirla'),
                child: Text('Şifremi unuttum'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }
}
