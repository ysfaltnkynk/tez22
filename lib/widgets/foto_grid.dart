import 'package:flutter/material.dart';

class FotoGrid extends StatelessWidget {
  final List<String> fotoUrls;
  FotoGrid({required this.fotoUrls});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: fotoUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, idx) =>
          Image.network(fotoUrls[idx], fit: BoxFit.cover),
    );
  }
}
