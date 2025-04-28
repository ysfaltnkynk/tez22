import 'package:flutter/material.dart';

import '../services/message_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/mesaj_kart.dart';

class MesajlarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mesajlarım')),
      body: FutureBuilder(
        future: MessageService().getMyChats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final sohbetler = snapshot.data!;
          if (sohbetler.isEmpty)
            return Center(child: Text('Henüz mesajınız yok.'));
          return ListView.builder(
            itemCount: sohbetler.length,
            itemBuilder: (context, idx) => MesajKart(sohbet: sohbetler[idx]),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
