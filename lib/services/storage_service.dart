import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();

  Future<String?> pickAndUploadImage() async {
    final picked =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return null;
    final file = File(picked.path);
    final ref = _storage
        .ref()
        .child('ilan_fotolari')
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
