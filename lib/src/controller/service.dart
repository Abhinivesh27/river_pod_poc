import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/model/model.dart';
import 'package:http/http.dart' as http;



class ApiService {
  // final String endpoint = "https://jsonplaceholder.typicode.com/users";

  // Future<List<UserModel>> getUsers() async {
  //   var response = await http.get(Uri.parse(endpoint));

  //   final List result = jsonDecode(response.body);

  //   return result.map((e) => UserModel.fromJson(e)).toList();
  // }

  Stream<List<UserModel>> getUsersFromFirebase()  {
  final String collectionName = "users";
  final FirebaseFirestore app = FirebaseFirestore.instance;
  final CollectionReference _collectionReference = app.collection(collectionName);

  var users =  _collectionReference.snapshots();

  var stream = users.map((sanpshot) {
    var result = sanpshot.docs.map((e) => UserModel()..name=e['name']..age=e['age']);

    return result.toList();
  });
  return stream;
  }



}

final apiProvider = Provider<ApiService>((ref) => ApiService());