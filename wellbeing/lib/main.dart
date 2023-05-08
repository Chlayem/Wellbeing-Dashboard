import 'package:flutter/material.dart';
import 'package:wellbeing/src/th.dart';
//import 'package:wellbeing/src/th.dart';
import 'src/app.dart';
import 'src/blocs/provider.dart';

void main() {
  runApp(Provider(
    child: MediaQuery(data: MediaQueryData(),child: Th()),
  ));
}
