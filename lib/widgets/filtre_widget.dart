import 'package:flutter/material.dart';

class FiltreWidget extends StatefulWidget {
  final Function(String, String, int?, int?) onChanged;
  FiltreWidget({required this.onChanged});

  @override
  State<FiltreWidget> createState() => _FiltreWidgetState();
}

class _FiltreWidgetState extends State<FiltreWidget> {
  String tur = 'Hepsi';
  String evTipi = 'Hepsi';
  int? minYas, maxYas;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: tur,
          items: ['Hepsi', 'Satılık', 'Kiralık']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            setState(() => tur = v!);
            widget.onChanged(tur, evTipi, minYas, maxYas);
          },
        ),
        SizedBox(width: 8),
        DropdownButton<String>(
          value: evTipi,
          items: ['Hepsi', 'Daire', 'Villa', 'Müstakil', 'Diğer']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            setState(() => evTipi = v!);
            widget.onChanged(tur, evTipi, minYas, maxYas);
          },
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 40,
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Min', contentPadding: EdgeInsets.all(4)),
            keyboardType: TextInputType.number,
            onChanged: (v) {
              minYas = int.tryParse(v);
              widget.onChanged(tur, evTipi, minYas, maxYas);
            },
          ),
        ),
        SizedBox(width: 4),
        SizedBox(
          width: 40,
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Max', contentPadding: EdgeInsets.all(4)),
            keyboardType: TextInputType.number,
            onChanged: (v) {
              maxYas = int.tryParse(v);
              widget.onChanged(tur, evTipi, minYas, maxYas);
            },
          ),
        ),
      ],
    );
  }
}
