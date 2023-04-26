import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wellbeing/src/elements/employee.dart';

class Bloc extends Object {
  int currentIndex = 0;

  final _screenController = BehaviorSubject<int>.seeded(0);

  Stream<int> get currentScreen => _screenController.stream;
  void navigateToScreen(int index,) {
    currentIndex = index;
    _screenController.sink.add(currentIndex);
  }

  void dispose() {
    _screenController.close();
  }
}





