import 'package:flutter/material.dart';
import 'package:tez2/models/ilan.dart';

class PropertyCard extends StatelessWidget {
  final Ilan property;
  const PropertyCard({required this.property, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: property.fotoUrls.isNotEmpty
            ? Image.network(property.fotoUrls[0], width: 80, fit: BoxFit.cover)
            : null,
        title: Text(property.baslik),
        subtitle: Text('${property.fiyat} ₺'),
        onTap: () {
          Navigator.pushNamed(context, '/ilanDetay', arguments: property);
        },
      ),
    );
  }
}
