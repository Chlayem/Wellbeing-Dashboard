
import 'package:wellbeing/src/elements/chart_data.dart';

import 'consultation.dart';

class Employee {
  String? firstName ;
  String? lastName;
  int? cin;
  String? email;
  String? job;
  int? workHours;
  DateTime? birthDate;
  DateTime? recDate;
  int? num;
  String? department ;
  List<ChartData> stress;
  List<ChartData> anxiety;
  List<ChartData> fatigue;
  List<Consultation>? csl;
  Employee({this.firstName, this.lastName,this.cin, this.department, this.stress=const[], this.anxiety=const[], this.fatigue=const[],
    this.email, this.job,this.workHours,this.birthDate,this.recDate,this.num,this.csl});
}