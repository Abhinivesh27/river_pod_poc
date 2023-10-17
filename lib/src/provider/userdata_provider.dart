import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/controller/service.dart';
import 'package:river_pod_poc/src/controller/write_service.dart';
import 'package:river_pod_poc/src/model/model.dart';

final userDataProvider = StreamProvider((ref) => ref.read(apiProvider).getUsersFromFirebase());

