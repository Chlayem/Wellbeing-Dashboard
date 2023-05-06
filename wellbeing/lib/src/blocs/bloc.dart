import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wellbeing/src/elements/consultation.dart';
import 'package:wellbeing/src/elements/employee.dart';

import '../elements/chart_data.dart';
import '../elements/department.dart';
import '../elements/incident.dart';
import '../elements/period.dart';

class Bloc extends Object {

  List<Consultation> currentCsl = [/*Consultation(date:DateTime(2020,5,9),bilan: "Lorem ")*/];//[Consultation(date:DateTime(2020,5,9),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2021,9,18),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2022,8,26),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")];
  //List<bool> currentExpand = [false,false,false];
  int currentIndex = 0;
  Employee currentEmployee = Employee();
  List<Employee> currentList=[] ;
  Period currentPeriod = Period(departments: [],daysOff: [],incidents: []);


  final _cslController = BehaviorSubject<List<Consultation>>.seeded([]);//[Consultation(date:DateTime(2020,5,9),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2021,9,18),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2022,8,26),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")]);
  //final _expandedController = BehaviorSubject<List<bool>>.seeded([]);
  final _screenController = BehaviorSubject<int>.seeded(0);
  final _employeeController = BehaviorSubject<Employee>.seeded(Employee());
  final _listController = BehaviorSubject<List<Employee>>.seeded([]);
  final _periodController = BehaviorSubject<Period>.seeded(Period(departments:[], incidents:[], daysOff:[]));


  //Stream<List<bool>> get expandeds => _expandedController.stream;
  Stream<int> get screens => _screenController.stream;
  Stream<Employee> get employees => _employeeController.stream;
  Stream<List<Employee>> get lists => _listController.stream;
  Stream<Period> get periods => _periodController.stream;
  Stream<List<Consultation>> get consultations => _cslController.stream;

  void navigateToScreen(int index,) {
    currentIndex = index;
    _screenController.sink.add(currentIndex);
  }
  void pushEmployee(Employee e){
    currentList.add(e);
    _listController.sink.add(currentList);
  }
  void popEmployee(Employee e){
    currentList.remove(e);
    _listController.sink.add(currentList);
  }
  void selectEmployee(Employee employee,) {
    currentEmployee = employee;
    _employeeController.sink.add(currentEmployee);
  }
  void pushList(List<Employee> empList,) {
    currentList = empList;
    for (Employee e in currentList){
      if(e.csl == null) continue;
      for(Consultation c in e.csl!){
        c.isExpanded =false;
      }
    }
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





