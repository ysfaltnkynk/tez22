import 'package:flutter/material.dart';

import '../models/ilan.dart';
import '../services/ilan_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/filtre_widget.dart';
import '../widgets/ilan_kart.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String seciliTur = 'Hepsi';
  String seciliEvTipi = 'Hepsi';
  int? minYas, maxYas;
  String aramaKelimesi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camelot')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'İlan ara...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (deger) {
                setState(() {
                  aramaKelimesi = deger.trim();
                });
              },
            ),
          ),
          FiltreWidget(
            onChanged: (tur, evTipi, minY, maxY) {
              setState(() {
                seciliTur = tur;
                seciliEvTipi = evTipi;
                minYas = minY;
                maxYas = maxY;
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<Ilan>>(
              future: IlanService().getIlanlar(
                tur: seciliTur,
                evTipi: seciliEvTipi,
                minYas: minYas,
                maxYas: maxYas,
                arama: aramaKelimesi,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasError)
                  return Center(child: Text('Hata: ${snapshot.error}'));
                if (!snapshot.hasData)
                  return Center(child: Text('İlan bulunamadı.'));
                final ilanlar = snapshot.data!;
                if (ilanlar.isEmpty)
                  return Center(child: Text('İlan bulunamadı.'));
                return ListView.builder(
                  itemCount: ilanlar.length,
                  itemBuilder: (context, idx) => IlanKart(ilan: ilanlar[idx]),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ilan_ekle');
        },
        child: Icon(Icons.add),
        tooltip: 'İlan Ekle',
      ),
    );
  }
}
