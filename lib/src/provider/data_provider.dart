import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/controller/service.dart';

var userDataProvider = StreamProvider((ref) {
  return ref.read(apiProvider).getAllUsers();
} );

var uploadUserProvider = Provider((ref) => ref.read(apiProvider));