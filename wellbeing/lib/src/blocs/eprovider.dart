import 'package:flutter/material.dart';
import 'ebloc.dart';

class EProvider extends InheritedWidget {
  final bloc = EBloc();

  EProvider({Key? key, Widget? child})
      :super(key:key,child:child ?? SizedBox());

  bool updateShouldNotify(_) => true;

  static EBloc of (BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<EProvider>() as EProvider).bloc;
  }
}
