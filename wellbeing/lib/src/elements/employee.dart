
import 'package:cloud_firestore/cloud_firestore.dart';
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



  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'cin': cin,
      'email': email,
      'job': job,
      'workHours': workHours,
      'birthDate': birthDate,
      'recDate': recDate,
      'num': num,
      'department': department,
      'stress': stress.map((chartData) => chartData.toMap()).toList(),
      'anxiety': anxiety.map((chartData) => chartData.toMap()).toList(),
      'fatigue': fatigue.map((chartData) => chartData.toMap()).toList(),
      'csl': csl?.map((consultation) => consultation.toMap()).toList(),
    };
  }

  factory Employee.fromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Employee(
      firstName: data?['firstName'] ?? '',
      lastName: data?['lastName'] ?? '',
      cin: data?['cin'] ?? 0,
      email: data?['email'] ?? '',
      job: data?['job'] ?? '',
      workHours: data?['workHours'] ?? 0,
      birthDate: data?['birthDate']?.toDate() ?? null,
      recDate: data?['recDate']?.toDate() ?? null,
      num: data?['num'] ?? 0,
      department: data?['department'] ?? '',
      stress: parseChartDataList(data?['stress']),
      anxiety: parseChartDataList(data?['anxiety']),
      fatigue: parseChartDataList(data?['fatigue']),
      csl: parseConsultationList(data?['csl']),
    );
  }

  static List<ChartData> parseChartDataList(List<dynamic>? chartDataList) {
    if (chartDataList == null) {
      return [];
    }
    return chartDataList.map((chartData) => ChartData(
      month: chartData['month'],
      value: chartData['value'] ?? -1,
    )).toList();
  }

  static List<Consultation> parseConsultationList(List<dynamic>? consultationList) {
    if (consultationList == null) {
      return [];
    }
    return consultationList.map((consultation) => Consultation(
      date: consultation['date'].toDate(),
      bilan: consultation['bilan'] ?? '',
      diag: consultation['diag'] ?? '',
      pro: consultation['pro'] ?? '',
      res: consultation['res'] ?? '',
      isExpanded: consultation['isExpanded'] ?? false,
    )).toList();
  }

}

