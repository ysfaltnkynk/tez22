class AppUser {
  String id;
  String email;
  String kullaniciAdi;
  String? profilFotoUrl;
  String? telefon;
  List<String> favoriler;

  AppUser({
    required this.id,
    required this.email,
    required this.kullaniciAdi,
    this.profilFotoUrl,
    this.telefon,
    this.favoriler = const [],
  });

  factory AppUser.fromMap(Map<String, dynamic> map) => AppUser(
        id: map['id'],
        email: map['email'],
        kullaniciAdi: map['kullaniciAdi'],
        profilFotoUrl: map['profilFotoUrl'],
        telefon: map['telefon'],
        favoriler: List<String>.from(map['favoriler'] ?? []),
      );
}
