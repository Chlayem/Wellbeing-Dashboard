import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wellbeing/src/th.dart';
//import 'package:wellbeing/src/th.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'src/blocs/provider.dart';

Future<void> main() async {

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Provider(
    child: MediaQuery(data: MediaQueryData(),child: App()),
  ));
}
