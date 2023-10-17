import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/controller/service.dart';
import 'package:river_pod_poc/src/model/model.dart';

final userDataProvider = FutureProvider<List<UserModel>>(
  (ref) async {
    return ref.read(apiProvider).getUsers();
  } 
);