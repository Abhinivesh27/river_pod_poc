import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/model/model.dart';

class WriteService {
  void writeUserToFirebase(UserModel user) async {
  final String collectionName = "users";
  final FirebaseFirestore app = FirebaseFirestore.instance;
  final CollectionReference _collectionReference = app.collection(collectionName);

  Map<String, dynamic> data = {
    "name": user.name,
    "age": user.age,
  };

  await _collectionReference.add(data);
  }
}

final writeProvider = Provider<WriteService>((ref) => WriteService());