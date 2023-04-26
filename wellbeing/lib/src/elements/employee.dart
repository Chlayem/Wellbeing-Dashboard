
class Employee {
  String name ;
  String? email;
  String? job;
  int? workHours;
  DateTime? birthDate;
  DateTime? recDate;
  int? num;
  String department ;
  int stress;
  int anxiety;
  int fatigue;
  Employee({required this.name,required this.department,required this.stress,required this.anxiety,required this.fatigue,
    this.email,this.job,this.workHours,this.birthDate,this.recDate,this.num});
}