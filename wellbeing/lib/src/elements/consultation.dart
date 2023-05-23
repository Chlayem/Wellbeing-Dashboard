class Consultation {
  DateTime date;
  String bilan;
  String diag;
  String pro;
  String res;
  bool isExpanded ;
  Consultation({required this.date,this.bilan="",this.diag="",this.pro="",this.res="",this.isExpanded=false});
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'bilan': bilan,
      'diag': diag,
      'pro': pro,
      'res': res,
      'isExpanded': isExpanded,
    };
  }
}