import 'package:flutter/material.dart';

import '../models/ilan.dart';

class IlanKart extends StatelessWidget {
  final Ilan ilan;
  final bool kendiIlanim;
  IlanKart({required this.ilan, this.kendiIlanim = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: ilan.fotoUrls.isNotEmpty
            ? Image.network(ilan.fotoUrls[0],
                width: 60, height: 60, fit: BoxFit.cover)
            : Icon(Icons.home, size: 60),
        title: Text(ilan.baslik),
        subtitle: Text('${ilan.fiyat} ₺\n${ilan.tur} -}'),
        isThreeLine: true,
        trailing: kendiIlanim
            ? IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Silme işlemi için servis çağrısı yapılabilir
                },
              )
            : null,
        onTap: () {
          Navigator.pushNamed(context, '/ilan_detay', arguments: ilan);
        },
      ),
    );
  }
}
