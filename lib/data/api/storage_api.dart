import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class StorageApi {
  Future<String> addToStorage(Uint8List uint8list, String foldName) async {
    DateTime currentDate = await NTP.now();
    final String imgName = '${currentDate.toUtc()}.png';
    final storageRef = FirebaseStorage.instance.ref();
    String downloadUrl = '';
    final bannersRef = storageRef.child('$foldName/$imgName');

    try {
      TaskSnapshot uploadTask = await bannersRef.putData(uint8list);
      downloadUrl = await uploadTask.ref.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    }

    return downloadUrl;
  }
}
