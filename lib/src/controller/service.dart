import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/model/user.dart';

final FirebaseFirestore app = FirebaseFirestore.instance;
final CollectionReference _collectionReference = app.collection('users');

class ApiService {
Stream<List<UserModel>> getAllUsers() {
  return _collectionReference.snapshots().map((snapshot) {
    var result = snapshot.docs.map((e) => UserModel()..name=e['name']..age=e['age']).toList();
    return result;
  } );
}

void writeUser(UserModel user) async {
  Map<String, dynamic> data = {
    "name": user.name,
    "age": user.age,
  };

  await _collectionReference.add(data);
}

void deleteUser(String username) async {
 var data = await _collectionReference.where('name',isEqualTo: username).get();
  data.docs[0].reference.delete();
}

void updateUser(UserModel user) async {
  log("Update Called");
  var data = await _collectionReference.where('name',isEqualTo: user.name).get();
Map<String, dynamic> updatedData = {
    "name": user.name,
    "age": user.age,
  };
  data.docs[0].reference.update(updatedData);
}
}

var apiProvider = Provider<ApiService>((ref) => ApiService());