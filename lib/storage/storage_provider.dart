
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProviderRemoteDataSource {
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadProfileImage(
      {required File file, Function(bool isUploading)? onComplete}) async {
    onComplete!(true);

    final ref = _storage.ref().child(
        "profile/${DateTime.now().millisecondsSinceEpoch}");

    final uploadTask = ref.putData(await file.readAsBytes(),  SettableMetadata(contentType: 'image/png'),);


    final imageUrl =
    (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    onComplete(false);
    return await imageUrl;
  }

  static Future<String> uploadStatus(
      {required File file, Function(bool isUploading)? onComplete}) async {
    onComplete!(true);

    final ref = _storage.ref().child(
        "status/${DateTime.now().millisecondsSinceEpoch}");

    final uploadTask = ref.putData(await file.readAsBytes(),  SettableMetadata(contentType: 'image/png'),);

    final imageUrl =
    (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    onComplete(false);
    return await imageUrl;
  }

  static Future<List<String>> uploadStatuses(
      {required List<File> files, Function(bool isUploading)? onComplete}) async {
    onComplete!(true);

    List<String> imageUrls = [];
    for (var i = 0; i < files.length; i++) {
      final ref = _storage.ref().child(
          "status/${DateTime.now().millisecondsSinceEpoch}${i + 1}");

      final uploadTask = ref.putData(await files[i].readAsBytes(), SettableMetadata(contentType: 'image/png'));

      final imageUrl =
      (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
      imageUrls.add(await imageUrl);
    }
    onComplete(false);
    return imageUrls;
  }

  static Future<String> uploadMessageFile(
      {required File file, Function(bool isUploading)? onComplete, String? uid, String? otherUid,String? type}) async {
    onComplete!(true);

    final ref = _storage.ref().child(
        "message/$type/$uid/$otherUid/${DateTime.now().millisecondsSinceEpoch}");

    final uploadTask = ref.putData(await file.readAsBytes(),  SettableMetadata(contentType: 'image/png'),);

    final imageUrl =
    (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    onComplete(false);
    return await imageUrl;
  }

}


