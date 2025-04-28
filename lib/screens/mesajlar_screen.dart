import 'package:flutter/material.dart';

import '../models/ilan.dart';
import '../services/message_service.dart';
import '../widgets/bottom_nav_bar.dart';

class MesajScreen extends StatefulWidget {
  final Ilan ilan;
  MesajScreen({required this.ilan});

  @override
  State<MesajScreen> createState() => _MesajScreenState();
}

class _MesajScreenState extends State<MesajScreen> {
  final _controller = TextEditingController();
  bool yukleniyor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mesajlaşma')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: MessageService().getChatStream(widget.ilan.ilanid),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                final mesajlar = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: mesajlar.length,
                  itemBuilder: (context, idx) {
                    final m = mesajlar[mesajlar.length - 1 - idx];
                    return Align(
                      alignment: m['benim']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        color: m['benim'] ? Colors.blue[100] : Colors.grey[200],
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(m['icerik']),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Mesaj yaz...'),
                  ),
                ),
                IconButton(
                  icon: yukleniyor
                      ? CircularProgressIndicator()
                      : Icon(Icons.send),
                  onPressed: yukleniyor
                      ? null
                      : () async {
                          if (_controller.text.trim().isNotEmpty) {
                            setState(() => yukleniyor = true);
                            await MessageService().mesajGonder(
                                widget.ilan.ilanid, _controller.text.trim());
                            _controller.clear();
                            setState(() => yukleniyor = false);
                          }
                        },
                ),
              ],
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
