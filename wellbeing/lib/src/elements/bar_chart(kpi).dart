import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:responsive_builder/responsive_builder.dart';


class BarChartData {
  BarChartData(this.text, this.x, this.y, this.color);
  final String text;
  final double x;
  final double y;
  final Color color;
}


Widget construireGraphiqueBarres(String titre, List<BarChartData> donneesGraphiqueBarres) {
  return ResponsiveBuilder(
    builder: (BuildContext context, SizingInformation sizingInformation) {
      bool isMobile = sizingInformation.deviceScreenType == DeviceScreenType.mobile;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              titre,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 200,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(fontSize: isMobile ? 10 : 12), // Modifiez la taille de la police
                labelRotation: isMobile ? -45 : 0, // Inclinez les étiquettes
              ),

              primaryYAxis: NumericAxis(
                minimum: 0, // Valeur minimale de l'axe Y
                //maximum: 20, // Valeur maximale de l'axe Y
                //interval: 2, // Intervalle entre les graduations de l'axe Y
              ),
              series: <ColumnSeries<BarChartData, String>>[
                ColumnSeries<BarChartData, String>(
                  dataSource: donneesGraphiqueBarres,
                  xValueMapper: (BarChartData data, _) => data.text,
                  yValueMapper: (BarChartData data, _) => data.y,
                  pointColorMapper: (BarChartData data, _) => data.color,
                  width: 0.6,
                  spacing: 0.1,
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
