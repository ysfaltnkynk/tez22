import 'package:flutter/material.dart';

import '../models/ilan.dart';
import '../services/ilan_service.dart';
import '../services/user_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/ilan_kart.dart';

class FavorilerimScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorilerim')),
      body: FutureBuilder<List<String>>(
        future: UserService().getFavoriler(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final favoriIdler = snapshot.data!;
          if (favoriIdler.isEmpty)
            return Center(child: Text('Favori ilanınız yok.'));
          return FutureBuilder<List<Ilan>>(
            future: IlanService().getIlanlarByIds(favoriIdler),
            builder: (context, snap) {
              if (!snap.hasData)
                return Center(child: CircularProgressIndicator());
              final ilanlar = snap.data!;
              return ListView.builder(
                itemCount: ilanlar.length,
                itemBuilder: (context, idx) => IlanKart(ilan: ilanlar[idx]),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
