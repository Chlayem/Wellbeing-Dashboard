import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wellbeing/src/elements/employee.dart';

class RBloc extends Object {

  List<Employee> currentIndex = [
    Employee(name: "Jhon",department: "Marketing",stress:1,anxiety: 2,fatigue: 0),
    Employee(name: "Kevin",department: "Production",stress: 0,anxiety: 0,fatigue: 1),
    Employee(name: "Emma",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "James",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Fred",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Selena",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Adam",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
  ];

  final _screenController = BehaviorSubject<List<Employee>>.seeded([
    Employee(name: "Jhon",department: "Marketing",stress:1,anxiety: 2,fatigue: 0),
    Employee(name: "Kevin",department: "Production",stress: 0,anxiety: 0,fatigue: 1),
    Employee(name: "Emma",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "James",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Fred",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Selena",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Adam",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
  ]);


  Stream<List<Employee>> get currentScreen => _screenController.stream;

  void navigateToScreen(List<Employee> empp,) {
    currentIndex = empp;
    _screenController.sink.add(currentIndex);
  }

  void dispose() {
    _screenController.close();
  }
}