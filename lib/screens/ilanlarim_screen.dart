import 'package:flutter/material.dart';

import '../services/ilan_service.dart';
import '../widgets/ilan_kart.dart';

class IlanlarimScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İlanlarım')),
      body: FutureBuilder(
        future: IlanService().getMyIlanlar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final ilanlar = snapshot.data!;
          if (ilanlar.isEmpty)
            return Center(child: Text('Henüz ilanınız yok.'));
          return ListView.builder(
            itemCount: ilanlar.length,
            itemBuilder: (context, idx) =>
                IlanKart(ilan: ilanlar[idx], kendiIlanim: true),
          );
        },
      ),
    );
  }
}
