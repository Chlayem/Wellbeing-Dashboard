import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wellbeing/src/elements/consultation.dart';
import 'package:wellbeing/src/elements/employee.dart';

import '../elements/department.dart';
import '../elements/incident.dart';
import '../elements/period.dart';

class Bloc extends Object {

  List<Consultation> currentCsl = [Consultation(date:DateTime(2020,5,9),bilan: "Lorem ")];//[Consultation(date:DateTime(2020,5,9),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2021,9,18),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2022,8,26),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")];
  //List<bool> currentExpand = [false,false,false];
  int currentIndex = 0;
  Employee currentEmployee = Employee(name: "James Rodriguez", department: "Production", stress: 0, anxiety: 1, fatigue: 0,num: 286544452,
      email: "james.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23));
  List<Employee> currentList = [
    Employee(name: "Jhon",department: "Marketing",stress:1,anxiety: 2,fatigue: 0),
    Employee(name: "Kevin",department: "Production",stress: 0,anxiety: 0,fatigue: 1),
    Employee(name: "Emma",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "James",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Fred",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Selena",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Adam",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
  ];
  Period currentPeriod = Period(departments: [
    Department(stress: {"Flutter": 75}, anxiety: {"anxiety":15}, fatigue: {"fatigue":10}),
    Department(stress: {"Flutter": 4}, anxiety: {"anxiety":18}, fatigue: {"fatigue":2}),
    Department(stress: {"Flutter": 7}, anxiety: {"anxiety":20}, fatigue: {"fatigue":9})
  ], incidents: [
    Incident("faible", 10),
    Incident("Moyen", 20),
    Incident("Severe", 15),
    Incident("Critique", 2)
  ], daysOff: [
    Incident("Santé", 10),
    Incident("Emotionelle", 20),
    Incident("Incidents", 12)
  ]);


  final _cslController = BehaviorSubject<List<Consultation>>.seeded([Consultation(date:DateTime(2020,5,9),bilan: "Lorem ")]);//[Consultation(date:DateTime(2020,5,9),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2021,9,18),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2022,8,26),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")]);
  final _expandedController = BehaviorSubject<List<bool>>.seeded([false,false,false]);
  final _screenController = BehaviorSubject<int>.seeded(0);
  final _employeeController = BehaviorSubject<Employee>.seeded(Employee(name: "James Rodriguez", department: "Production", stress: 0, anxiety: 1, fatigue: 0,num: 286544452,
    email: "james.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23)));
  final _listController = BehaviorSubject<List<Employee>>.seeded([
    Employee(name: "Jhon",department: "Marketing",stress:1,anxiety: 2,fatigue: 0),
    Employee(name: "Kevin",department: "Production",stress: 0,anxiety: 0,fatigue: 1),
    Employee(name: "Emma",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "James",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Fred",department: "Finance",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Selena",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
    Employee(name: "Adam",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
  ]);
  final _periodController = BehaviorSubject<Period>.seeded(Period(departments: [
    Department(stress: {"Flutter": 75}, anxiety: {"anxiety":15}, fatigue: {"fatigue":10}),
    Department(stress: {"Flutter": 4}, anxiety: {"anxiety":18}, fatigue: {"fatigue":2}),
    Department(stress: {"Flutter": 7}, anxiety: {"anxiety":20}, fatigue: {"fatigue":9})
  ], incidents: [
    Incident("faible", 10),
    Incident("Moyen", 20),
    Incident("Severe", 15),
    Incident("Critique", 2)
  ], daysOff: [
    Incident("Santé", 10),
    Incident("Emotionelle", 20),
    Incident("Incidents", 12)
  ]));
  Stream<List<bool>> get expandeds => _expandedController.stream;
  Stream<int> get screens => _screenController.stream;
  Stream<Employee> get employees => _employeeController.stream;
  Stream<List<Employee>> get lists => _listController.stream;
  Stream<Period> get periods => _periodController.stream;
  Stream<List<Consultation>> get consultations => _cslController.stream;

  void navigateToScreen(int index,) {
    currentIndex = index;
    _screenController.sink.add(currentIndex);
  }
  void pushEmployee(Employee employee,) {
    currentEmployee = employee;
    _employeeController.sink.add(currentEmployee);
  }
  void pushList(List<Employee> empp,) {
    currentList = empp;
    _listController.sink.add(currentList);
  }
  void pushPeriod(Period period,) {
    currentPeriod = period;
    _periodController.sink.add(currentPeriod);
  }
  /*void pushExpand(List<bool> expanded){
    currentExpand =expanded;
    _expandedController.sink.add(currentExpand);
  }*/
  void addCsl(Consultation c){
    currentCsl.add(c);
    _cslController.add(currentCsl);
    currentEmployee.csl=currentCsl;
  }

  void pushCsl(List<Consultation> csl){
    currentCsl = csl;
    _cslController.sink.add(currentCsl);
  }
  void dispose() {
    _screenController.close();
    _employeeController.close();
    _listController.close();
    _periodController.close();
    _cslController.close();
  }
}





