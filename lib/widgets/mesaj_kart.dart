import 'package:flutter/material.dart';

class MesajKart extends StatelessWidget {
  final Map<String, dynamic> sohbet;
  MesajKart({required this.sohbet});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.person)),
      title: Text(sohbet['ad'] ?? ''),
      subtitle: Text(sohbet['sonMesaj'] ?? ''),
      trailing: Text(sohbet['zaman'] ?? ''),
      onTap: () {
        Navigator.pushNamed(context, '/mesaj', arguments: sohbet['ilan']);
      },
    );
  }
}
