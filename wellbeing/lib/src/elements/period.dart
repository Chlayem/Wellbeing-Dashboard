import 'department.dart';
import 'incident.dart';
class Period {
  String month;
  List<Department> departments;
  List<Incident> incidents;
  List<Incident> daysOff ;
  Period({required this.month,required this.departments,required this.incidents,required this.daysOff});
}