import 'package:flutter/material.dart';

class ProfilHeader extends StatelessWidget {
  final String? fotoUrl;
  final String kullaniciAdi;
  final String email;

  ProfilHeader({this.fotoUrl, required this.kullaniciAdi, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: fotoUrl != null ? NetworkImage(fotoUrl!) : null,
          child: fotoUrl == null ? Icon(Icons.person, size: 48) : null,
        ),
        SizedBox(height: 8),
        Text(kullaniciAdi, style: TextStyle(fontSize: 20)),
        Text(email),
      ],
    );
  }
}
