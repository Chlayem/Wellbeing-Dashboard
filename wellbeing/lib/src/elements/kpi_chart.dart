import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wellbeing/src/elements/chart_data.dart';

class KpiChart extends StatelessWidget {
  final List<ChartData> chartData;
  final String title;
  final String Function(ChartData) xValueMapper;
  final num Function(ChartData, int) yValueMapper;
  final String positionedText;

  KpiChart({
    required this.chartData,
    required this.title,
    required this.xValueMapper,
    required this.yValueMapper,
    required this.positionedText,

  });

  @override
  Widget build(BuildContext context) {
    if (chartData == null){
      return SizedBox();
    }
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        bool isMobile = sizingInformation.deviceScreenType == DeviceScreenType.mobile;

        return SizedBox(
          height: 150,
          child: Stack(
            children:<Widget>[
              SfCartesianChart(
                plotAreaBorderColor: Colors.transparent,
                primaryXAxis: CategoryAxis(
                  labelRotation: isMobile ? -45 : 0,
                  title: AxisTitle(
                    text: title,
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                primaryYAxis: NumericAxis(isVisible: false),
                backgroundColor: Colors.grey[200],
                series: <LineSeries<ChartData, String>>[
                  LineSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => xValueMapper(data),
                    yValueMapper: yValueMapper,
                  ),
                ],
              ),
              Positioned(
                top: 30, // adjust this value to move the text vertically
                left: 225, // adjust this value to move the text horizontally
                child: Text(
                  positionedText,

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

            ]
          ),
        );
      },
    );
  }
}
