import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String id;
  String tarif;
  String image;
  String name;

  Status(
      {required this.id,
      required this.tarif,
      required this.image,
      required this.name});

  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
      id: snapshot.id,
      tarif: snapshot["status"],
      image: snapshot["image"],
      name: snapshot["name"],
    );
  }
}
