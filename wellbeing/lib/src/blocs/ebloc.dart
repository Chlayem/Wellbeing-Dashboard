import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wellbeing/src/elements/employee.dart';

class EBloc extends Object {


  Employee currentIndex = Employee(name: "James Rodriguez", department: "Production", stress: 0, anxiety: 1, fatigue: 0,num: 286544452,
      email: "james.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23));

  final _screenController = BehaviorSubject<Employee>.seeded(Employee(name: "James Rodriguez", department: "Production", stress: 0, anxiety: 1, fatigue: 0,num: 286544452,
      email: "james.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23)));

  Stream<Employee> get currentScreen => _screenController.stream;
  void navigateToScreen(Employee employee,) {
    currentIndex = employee;
    _screenController.sink.add(currentIndex);
  }

  void dispose() {
    _screenController.close();
  }
}
