import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (idx) {
        if (idx == 0) Navigator.pushReplacementNamed(context, '/');
        if (idx == 1) Navigator.pushReplacementNamed(context, '/favorilerim');
        if (idx == 2) Navigator.pushReplacementNamed(context, '/mesajlar');
        if (idx == 3) Navigator.pushReplacementNamed(context, '/profil');
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black), label: 'İlanlar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black),
            label: 'Favoriler'),
        BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.black), label: 'Mesajlar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black), label: 'Profil'),
      ],
    );
  }
}
