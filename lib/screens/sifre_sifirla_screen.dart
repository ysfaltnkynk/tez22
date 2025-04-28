import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class SifreSifirlaScreen extends StatefulWidget {
  @override
  State<SifreSifirlaScreen> createState() => _SifreSifirlaScreenState();
}

class _SifreSifirlaScreenState extends State<SifreSifirlaScreen> {
  String email = '';
  String? mesaj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Şifre Sıfırla')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (mesaj != null)
              Text(mesaj!, style: TextStyle(color: Colors.green)),
            TextField(
              decoration: InputDecoration(labelText: 'E-posta'),
              onChanged: (v) => email = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final sonuc = await AuthService().resetPassword(email);
                setState(() {
                  mesaj = sonuc
                      ? "Şifre sıfırlama e-postası gönderildi."
                      : "Bir hata oluştu.";
                });
              },
              child: Text('Sıfırla'),
            ),
          ],
        ),
      ),
    );
  }
}
