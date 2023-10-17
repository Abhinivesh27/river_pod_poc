import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/model/model.dart';
import 'package:http/http.dart' as http;
class ApiService {
  final String endpoint = "https://reqres.in/api/users?page=2";

  Future<List<UserModel>> getUsers() async {
    var response = await http.get(Uri.parse(endpoint));

    final List result = jsonDecode(response.body)['data'];

    return result.map((e) => UserModel.fromJson(e)).toList();
  }
}

final apiProvider = Provider<ApiService>((ref) => ApiService());