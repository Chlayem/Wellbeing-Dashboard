
class ChartData {
  final String month;
  final int value;

  ChartData({required this.month, this.value=-1});
  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'value': value,
    };
  }
}

