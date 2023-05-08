import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../elements/chart_data.dart';
import '../elements/kpi_chart.dart';
import '../elements/bar_chart(kpi).dart';

class KPI extends StatefulWidget {
  @override
  State<KPI> createState() => _KPIState();
}

class _KPIState extends State<KPI> {
  String? _selectedMonth;

  List<ChartData> chartData = [
    ChartData(month: "Jan", value: 35),
    ChartData(month: "Feb", value: 28),
    ChartData(month: "Mar", value: 34),
    ChartData(month: "Apr", value: 32),
    ChartData(month: "May", value: 40),
    ChartData(month: "Jun", value: 30),
    ChartData(month: "Jul", value: 50),
    ChartData(month: "Aug", value: 65),
    ChartData(month: "Sep", value: 55),
    ChartData(month: "Oct", value: 60),
    ChartData(month: "Nov", value: 75),
    ChartData(month: "Dec", value: 80),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double chartPaddingHorizantal = screenWidth <600 ? screenWidth*0.1:screenWidth*0.05;
    double chartPaddingVertical = screenWidth <600 ? 50.0:screenWidth*0.06;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.center,
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FixedColumnWidth(250.0),
                    1: FixedColumnWidth(250.0),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              'Select Month:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Center(
                          child: DropdownButton<String>(
                            value: _selectedMonth,
                            items: [
                              'January',
                              'February',
                              'March',
                              'April',
                              'May',
                              'June',
                              'July',
                              'August',
                              'September',
                              'October',
                              'November',
                              'December'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedMonth = newValue;
                              });
                            },
                            hint: Text(_selectedMonth ?? 'January'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Les courbes
            _selectedMonth == null
                ? Center(child: Text('Please select a month'))
                : Column(
                  children: [
                    GridView.count(
                      childAspectRatio: 2,
                      crossAxisSpacing: 30,
                      shrinkWrap: true,
                      crossAxisCount: screenWidth>700?2:1,
                      children: [
                        // Première courbe
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 25, 8.0, 0),
                          child: KpiChart(
                            chartData: chartData,
                            title: 'Incidents',
                            xValueMapper: (ChartData data) => data.month,
                            yValueMapper: (ChartData data, int _) =>
                                data.value,
                          ),
                        ),
                        // Deuxième courbe
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 25, 8.0, 0),
                          child: KpiChart(
                            chartData: chartData,
                            title: 'Critical Incident',
                            xValueMapper: (ChartData data) => data.month,
                            yValueMapper: (ChartData data, int _) =>
                                data.value,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(8.0, 25, 8.0, 0),
                          child: KpiChart(
                            chartData: chartData,
                            title: 'Incidents > 3 days of absents',
                            xValueMapper: (ChartData data) => data.month,
                            yValueMapper: (ChartData data, int _) =>
                            data.value,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(8.0, 25, 8.0, 0),
                          child: KpiChart(
                            chartData: chartData,
                            title: 'Incidents Cost',
                            xValueMapper: (ChartData data) => data.month,
                            yValueMapper: (ChartData data, int _) =>
                            data.value,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 100,
                    ),
                    GridView.count(
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      crossAxisCount: screenWidth>600?3:1,
                      children: [
                        // Bar Chart 1
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: chartPaddingHorizantal,vertical:chartPaddingVertical),

                          child: construireGraphiqueBarres('Severity', [
                            BarChartData('Low', 1, 4, Colors.teal),
                            BarChartData('Medium', 2, 3, Colors.orange),
                            BarChartData('High', 3, 2, Colors.brown),
                            BarChartData(
                                'Critical', 4, 5, Colors.deepOrange)
                          ]),
                        ),
                        // Bar Chart 2
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: chartPaddingHorizantal,vertical:chartPaddingVertical),

                          child: construireGraphiqueBarres(
                              'Type Of Incident', [
                            BarChartData('Injury', 1, 4, Colors.teal),
                            BarChartData('Illness', 2, 3, Colors.orange),
                            BarChartData(
                                'Psychological', 3, 2, Colors.brown),
                            BarChartData(
                                'Harrasment', 4, 5, Colors.deepOrange),
                            BarChartData('Other', 4, 7, Colors.deepPurple)
                          ]),
                        ),
                        // Bar Chart 3
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: chartPaddingHorizantal,vertical:chartPaddingVertical),

                          child: construireGraphiqueBarres(
                              'Injury Consequence', [
                            BarChartData('Lost Time', 1, 1, Colors.teal),
                            BarChartData(
                                'Medical Case', 2, 3, Colors.orange),
                            BarChartData('First Aid', 3, 2, Colors.brown),
                            BarChartData(
                                'No Treatment', 4, 5, Colors.deepOrange),
                            BarChartData(
                                'Lost Days', 4, 7, Colors.deepPurple)
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(height: 100,)
                  ],

                )
          ],
        ),
      ),
    );
  }
}
