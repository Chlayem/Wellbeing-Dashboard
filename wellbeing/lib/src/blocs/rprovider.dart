import 'rbloc.dart';
import 'package:flutter/material.dart';


class RProvider extends InheritedWidget {
  final rbloc = RBloc();

  RProvider({Key? key, Widget? child})
      :super(key:key,child:child ?? SizedBox());

  bool updateShouldNotify(_) => true;

  static RBloc of (BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<RProvider>() as RProvider).rbloc;
  }
}
