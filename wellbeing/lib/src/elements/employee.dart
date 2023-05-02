
import 'consultation.dart';

class Employee {
  String firstName ;
  String lastName;
  String? email;
  String job;
  int? workHours;
  DateTime? birthDate;
  DateTime? recDate;
  int? num;
  String department ;
  int stress;
  int anxiety;
  int fatigue;
  List<Consultation>? csl;
  Employee({required this.firstName,required this.lastName,required this.department,required this.stress,required this.anxiety,required this.fatigue,
    this.email,required this.job,this.workHours,this.birthDate,this.recDate,this.num,this.csl});
}