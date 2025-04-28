import 'package:flutter/material.dart';

import '../services/ilan_service.dart';
import '../services/storage_service.dart';

class IlanEkleScreen extends StatefulWidget {
  @override
  State<IlanEkleScreen> createState() => _IlanEkleScreenState();
}

class _IlanEkleScreenState extends State<IlanEkleScreen> {
  final _formKey = GlobalKey<FormState>();
  String baslik = '', aciklama = '', tur = 'Satılık', evTipi = 'Daire';
  double fiyat = 0;
  int binaYasi = 0;
  List<String> fotoUrls = [];
  bool yukleniyor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İlan Ekle')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'İlan Başlığı'),
                onChanged: (v) => baslik = v,
                validator: (v) => v!.isEmpty ? 'Başlık gerekli' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'İlan açıklaması'),
                onChanged: (v) => aciklama = v,
                validator: (v) => v!.isEmpty ? 'Açıklama gerekli' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fiyat'),
                keyboardType: TextInputType.number,
                onChanged: (v) => fiyat = double.tryParse(v) ?? 0,
                validator: (v) =>
                    (double.tryParse(v!) ?? 0) <= 0 ? 'Fiyat gerekli' : null,
              ),
              DropdownButtonFormField(
                value: tur,
                decoration: InputDecoration(labelText: 'Tür'),
                items: ['Satılık', 'Kiralık']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => tur = v as String),
              ),
              DropdownButtonFormField(
                value: evTipi,
                decoration: InputDecoration(labelText: 'Ev Tipi'),
                items: ['Daire', 'Villa', 'Müstakil', 'Diğer']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => evTipi = v as String),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bina Yaşı'),
                keyboardType: TextInputType.number,
                onChanged: (v) => binaYasi = int.tryParse(v) ?? 0,
                validator: (v) =>
                    (int.tryParse(v!) ?? 0) < 0 ? 'Geçersiz yaş' : null,
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                icon: Icon(Icons.photo),
                label: Text('Fotoğraf Ekle'),
                onPressed: () async {
                  final url = await StorageService().pickAndUploadImage();
                  if (url != null) setState(() => fotoUrls.add(url));
                },
              ),
              SizedBox(height: 8),
              fotoUrls.isEmpty
                  ? Text('Henüz fotoğraf seçilmedi.')
                  : SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: fotoUrls
                            .map((url) => Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Image.network(url,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover),
                                ))
                            .toList(),
                      ),
                    ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: yukleniyor
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => yukleniyor = true);
                          await IlanService().ilanEkle(
                            baslik: baslik,
                            aciklama: aciklama,
                            fiyat: fiyat,
                            tur: tur,
                            evTipi: evTipi,
                            binaYasi: binaYasi,
                            fotoUrls: fotoUrls,
                          );
                          setState(() => yukleniyor = false);
                          Navigator.pop(context);
                        }
                      },
                child: yukleniyor ? CircularProgressIndicator() : Text('Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
