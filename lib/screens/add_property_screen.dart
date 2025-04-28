import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tez2/models/ilan.dart';
import 'package:tez2/services/ilan_service.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);
  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String imageUrl = '';
  String location = '';
  double price = 0;
  int rooms = 1;
  bool loading = false;
  String id = '';
  String explanation = '';
  String type = '';
  int buildingAge = 0;
  DateTime olusturmaTrh = DateTime(DateTime.monthsPerYear);

  final List<String> cities = [
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Ankara",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bartın",
    "Batman",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkari",
    "Hatay",
    "Iğdır",
    "Isparta",
    "İstanbul",
    "İzmir",
    "Kahramanmaraş",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kilis",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Mardin",
    "Mersin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Şanlıurfa",
    "Siirt",
    "Sinop",
    "Şırnak",
    "Sivas",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak"
  ];

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => loading = true);

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final property = Ilan(
      ilanid: id,
      baslik: title,
      fotoUrls: [imageUrl],
      lokasyon: location,
      fiyat: price,
      oda: rooms,
      kullaniciId: userId,
      aciklama: explanation,
      tur: type,
      binaYasi: buildingAge,
      createdAt: olusturmaTrh,
    );
    try {
      await IlanService().ilanEkle(
        baslik: title,
        aciklama: explanation,
        fiyat: price,
        tur: type,
        evTipi: '', // Eğer evTipi alanın yoksa boş bırakabilirsin veya ekle
        binaYasi: (buildingAge) ?? 0,
        fotoUrls: [
          imageUrl
        ], // Eğer birden fazla foto ekleyeceksen burayı güncelle
      );
      if (mounted) {
        setState(() => loading = false);
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt sırasında hata oluştu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("İlan Ekle")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Başlık"),
                      onSaved: (v) => title = v ?? '',
                      validator: (v) => v!.isEmpty ? "Boş olamaz" : null,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Görsel URL"),
                      onSaved: (v) => imageUrl = v ?? '',
                      validator: (v) => v!.isEmpty ? "Boş olamaz" : null,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: "Şehir"),
                      items: cities
                          .map((city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => location = v ?? ''),
                      onSaved: (v) => location = v ?? '',
                      validator: (v) =>
                          v == null || v.isEmpty ? "Şehir seçin" : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Fiyat"),
                      keyboardType: TextInputType.number,
                      onSaved: (v) => price = double.tryParse(v ?? '') ?? 0,
                      validator: (v) => v!.isEmpty ? "Boş olamaz" : null,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Oda Sayısı"),
                      keyboardType: TextInputType.number,
                      onSaved: (v) => rooms = int.tryParse(v ?? '') ?? 1,
                      validator: (v) => v!.isEmpty ? "Boş olamaz" : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loading ? null : _save,
                      child: const Text("Kaydet"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
