import 'dart:developer';
import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
        Catcher2Options debugOptions =
      Catcher2Options(DialogReportMode(), [ConsoleHandler()]);
      
  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  Catcher2Options releaseOptions = Catcher2Options(DialogReportMode(), [
    EmailManualHandler(["support@email.com"])
  ]);
  Catcher2(rootWidget: ProviderScope(child: MyApp()), debugConfig: debugOptions, releaseConfig: releaseOptions);

  // runApp(
  //   ProviderScope(child: MyApp())
  // );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}