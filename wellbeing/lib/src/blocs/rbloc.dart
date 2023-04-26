import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wellbeing/src/elements/employee.dart';

class RBloc extends Object {
  List<Employee> currentIndex = [];

  final _screenController = BehaviorSubject<List<Employee>>.seeded([]);

  Stream<List<Employee>> get currentScreen => _screenController.stream;

  void navigateToScreen(List<Employee> empp,) {
    currentIndex = empp;
    _screenController.sink.add(currentIndex);
  }

  void dispose() {
    _screenController.close();
  }
}