import 'department.dart';
import 'incident.dart';
class Period {
  List<Department> departments;
  List<Incident> incidents;
  List<Incident> daysOff ;
  Period({required this.departments,required this.incidents,required this.daysOff});
}