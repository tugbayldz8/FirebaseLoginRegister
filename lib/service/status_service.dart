import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ogin/model/status.dart';
import 'package:firebase_ogin/service/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = '';

  Future<Status> addStatus(String tarif, XFile pickedFile, String name) async {
    var ref = _firestore.collection("Status");

    mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));

    var documentRef = await ref.add({
      'tarif': tarif,
      'image': mediaUrl,
      'name': name,
    });
    return Status(
        id: documentRef.id, tarif: tarif, image: mediaUrl, name: name);
  }

  //status göstermek için
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Status").snapshots();

    return ref;
  }

  // status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Status").doc(docId).delete();

    return ref;
  }
}
