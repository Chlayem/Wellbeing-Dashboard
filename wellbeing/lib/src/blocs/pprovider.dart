import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/pbloc.dart';
import 'bloc.dart';

class PProvider extends InheritedWidget {
  final bloc = PBloc();

  PProvider({Key? key, Widget? child})
      :super(key:key,child:child ?? SizedBox());

  bool updateShouldNotify(_) => true;

  static PBloc of (BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<PProvider>() as PProvider).bloc;
  }
}
