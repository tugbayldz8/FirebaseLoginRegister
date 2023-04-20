import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ogin/model/status.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // StorageService _storageService = StorageService();

  Future<Status> addStatus(String tarif, String image, String name) async {
    var ref = _firestore.collection("Status");

    image = "image boş";

    var documentRef = await ref.add({
      'tarif': tarif,
      'image': image,
      'name': name,
    });
    return Status(id: documentRef.id, tarif: tarif, image: image, name: name);
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
