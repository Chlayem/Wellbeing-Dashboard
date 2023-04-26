import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/elements/period.dart';

import '../elements/department.dart';
import '../elements/incident.dart';

class PBloc extends Object {


  Period currentIndex = Period(departments: [
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

  final _screenController = BehaviorSubject<Period>.seeded(Period(departments: [
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

  Stream<Period> get currentScreen => _screenController.stream;
  void navigateToScreen(Period index,) {
    currentIndex = index;
    _screenController.sink.add(currentIndex);
  }

  void dispose() {
    _screenController.close();
  }
}
