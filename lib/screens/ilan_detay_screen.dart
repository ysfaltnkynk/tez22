import 'package:flutter/material.dart';

import '../models/ilan.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class IlanDetayScreen extends StatefulWidget {
  final Ilan ilan;
  IlanDetayScreen({required this.ilan});

  @override
  State<IlanDetayScreen> createState() => _IlanDetayScreenState();
}

class _IlanDetayScreenState extends State<IlanDetayScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  void _checkFavorite() async {
    final fav = await UserService().isFavorite(widget.ilan.ilanid);
    setState(() {
      isFavorite = fav;
    });
  }

  void _toggleFavorite() async {
    await UserService().toggleFavorite(widget.ilan.ilanid);
    _checkFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final ilan = widget.ilan;
    return Scaffold(
      appBar: AppBar(
        title: Text('İlan Detayı'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fotoğraf galerisi
            SizedBox(
              height: 220,
              child: PageView(
                children: ilan.fotoUrls
                    .map((url) => Image.network(url, fit: BoxFit.cover))
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ilan.baslik,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('${ilan.fiyat} ₺',
                      style: TextStyle(fontSize: 20, color: Colors.green)),
                  SizedBox(height: 8),
                  Text('Tür: ${ilan.tur}'),
                  Text('Bina Yaşı: ${ilan.binaYasi}'),
                  SizedBox(height: 8),
                  Text(ilan.aciklama),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (!AuthService().isLoggedIn) {
                        Navigator.pushNamed(context, '/giris');
                      } else {
                        Navigator.pushNamed(context, '/mesaj', arguments: ilan);
                      }
                    },
                    child: Text('Mesaj Gönder'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
