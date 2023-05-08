class Consultation {
  DateTime date;
  String bilan;
  String diag;
  String pro;
  String res;
  bool isExpanded ;
  Consultation({required this.date,this.bilan="",this.diag="",this.pro="",this.res="",this.isExpanded=false});
}