import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellbeing/src/elements/period.dart';

import '../blocs/provider.dart';
import '../elements/department.dart';
import '../elements/incident.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);


  final dataMap = <String, double>{
    "Flutter": 5,
  };

  final colorList = <Color>[
    Color(0xffFFB4B4),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xffEFF5F5),
        body: StreamBuilder<Period>(
          stream: Provider.of(context).periods,
          builder: (BuildContext context, AsyncSnapshot<Period> snapshot) {

            if (snapshot.hasData && snapshot.data != null) {
              Period p = snapshot.data!;
              return Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.01,
                      right: width * 0.01,
                      bottom: height * 0.1),
                  child: Column(children: [
                    Expanded(child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Period per = Period(departments: [
                                Department(stress: {"Flutter": 75},
                                    anxiety: {"anxiety": 15},
                                    fatigue: {"fatigue": 10}),
                                Department(stress: {"Flutter": 4},
                                    anxiety: {"anxiety": 18},
                                    fatigue: {"fatigue": 2}),
                                Department(stress: {"Flutter": 7},
                                    anxiety: {"anxiety": 20},
                                    fatigue: {"fatigue": 9})
                              ], incidents: [
                                Incident("faible", 10),
                                Incident("Moyen", 20),
                                Incident("Severe", 15),
                                Incident("Critique", 2)
                              ], daysOff: [
                                Incident("Santé", 10),
                                Incident("Emotionelle", 20),
                                Incident("Incidents", 12)
                              ]);
                              Provider.of(context).pushPeriod(per);
                            },
                            child: Text("Year")
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Period per = Period(departments: [
                                Department(stress: {"Flutter": 90},
                                    anxiety: {"anxiety": 5},
                                    fatigue: {"fatigue": 6}),
                                Department(stress: {"Flutter": 2},
                                    anxiety: {"anxiety": 5},
                                    fatigue: {"fatigue": 2}),
                                Department(stress: {"Flutter": 7},
                                    anxiety: {"anxiety": 2},
                                    fatigue: {"fatigue": 9})
                              ], incidents: [
                                Incident("faible", 5),
                                Incident("Moyen", 30),
                                Incident("Severe", 1),
                                Incident("Critique", 7)
                              ], daysOff: [
                                Incident("Santé", 7),
                                Incident("Emotionelle", 30),
                                Incident("Incidents", 12)
                              ]);
                              Provider.of(context).pushPeriod(per);
                            },
                            child: Text("Month")
                        ),

                      ],
                    )),
                    Expanded(
                        flex: 2,
                        child: Row(children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.1,
                                      bottom: height * 0.03,
                                      left: width * 0.05,
                                      right: width * 0.02),
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: width * .006,
                                          right: width * 0.006),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xffD6E4E5),
                                      ),
                                      child: Column(children: [
                                        Expanded(
                                            flex: 4,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * .01),
                                                child: Text('Dev',
                                                    style: TextStyle(
                                                        color: Colors.teal,
                                                        fontSize: sqrt(
                                                            pow(width, 2) +
                                                                pow(height,
                                                                    2)) *
                                                            0.013,
                                                        letterSpacing: 2)))),
                                        Expanded(
                                            flex: 7,
                                            child: Row(children: [
                                              Expanded(
                                                  child: PieChart(
                                                    formatChartValues: (value) {
                                                      return value;
                                                    },
                                                    centerText:
                                                    '${p.departments[0].stress
                                                        .values
                                                        .toList()
                                                        .first}%',
                                                    dataMap: p.departments[0]
                                                        .stress,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValues: false,
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 100,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: 0,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                              Expanded(
                                                  child: PieChart(
                                                    centerText: '${p
                                                        .departments[0].anxiety
                                                        .values
                                                        .toList()
                                                        .first}%',
                                                    dataMap: p.departments[0]
                                                        .anxiety,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: 0,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                              Expanded(
                                                  child: PieChart(
                                                    dataMap: p.departments[0]
                                                        .fatigue,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: 0,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                            ])),
                                        Expanded(
                                            flex: 3,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: height * .015,
                                                    left: width * 0.015),
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Text('Stress',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                  Expanded(
                                                      child: Text('Anxiety',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                  Expanded(
                                                      child: Text('Fatigue',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                ])))
                                      ])))),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.1,
                                      bottom: height * 0.03,
                                      left: width * 0.025,
                                      right: width * 0.045),
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: width * .006,
                                          right: width * 0.006),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xffD6E4E5),
                                      ),
                                      child: Column(children: [
                                        Expanded(
                                            flex: 4,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * .01),
                                                child: Text('Finance',
                                                    style: TextStyle(
                                                        color: Colors.teal,
                                                        fontSize: sqrt(
                                                            pow(width, 2) +
                                                                pow(height,
                                                                    2)) *
                                                            0.013,
                                                        letterSpacing: 2)))),
                                        Expanded(
                                            flex: 7,
                                            child: Row(children: [
                                              Expanded(
                                                  child: PieChart(
                                                    dataMap: p.departments[1]
                                                        .stress,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: -90,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                              Expanded(
                                                  child: PieChart(
                                                    dataMap: p.departments[1]
                                                        .anxiety,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: -90,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                              Expanded(
                                                  child: PieChart(
                                                    dataMap: p.departments[1]
                                                        .fatigue,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: -90,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                            ])),
                                        Expanded(
                                            flex: 3,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: height * .015,
                                                    left: width * 0.015),
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Text('Stress',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                  Expanded(
                                                      child: Text('Anxiety',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                  Expanded(
                                                      child: Text('Fatigue',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                ])))
                                      ])))),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.1,
                                      bottom: height * 0.03,
                                      right: width * 0.07),
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: width * .006,
                                          right: width * 0.006),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xffD6E4E5),
                                      ),
                                      child: Column(children: [
                                        Expanded(
                                            flex: 4,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.01),
                                                child: Text('IT',
                                                    style: TextStyle(
                                                        color: Colors.teal,
                                                        fontSize: sqrt(
                                                            pow(width, 2) +
                                                                pow(height,
                                                                    2)) *
                                                            0.013,
                                                        letterSpacing: 2)))),
                                        Expanded(
                                            flex: 7,
                                            child: Row(children: [
                                              Expanded(
                                                  child: PieChart(
                                                    dataMap: p.departments[2]
                                                        .stress,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: -90,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                              Expanded(
                                                  child: PieChart(
                                                    dataMap: p.departments[2]
                                                        .anxiety,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: -90,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                              Expanded(
                                                  child: PieChart(
                                                    dataMap: p.departments[2]
                                                        .fatigue,
                                                    chartType: ChartType.ring,
                                                    baseChartColor: Color(
                                                        0xffFFF9CA),
                                                    colorList: colorList,
                                                    chartValuesOptions:
                                                    ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      showChartValuesInPercentage: true,
                                                      decimalPlaces: 0,
                                                    ),
                                                    totalValue: 20,
                                                    ringStrokeWidth: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.012,
                                                    chartRadius: sqrt(
                                                        pow(width, 2) +
                                                            pow(height, 2)) *
                                                        0.03,
                                                    initialAngleInDegree: -90,
                                                    legendOptions:
                                                    LegendOptions(
                                                        showLegends: false),
                                                  )),
                                            ])),
                                        Expanded(
                                            flex: 3,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: height * .015,
                                                    left: width * 0.015),
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Text('Stress',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                  Expanded(
                                                      child: Text('Anxiety',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                  Expanded(
                                                      child: Text('Fatigue',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: sqrt(
                                                                  pow(width,
                                                                      2) +
                                                                      pow(
                                                                          height,
                                                                          2)) *
                                                                  .01))),
                                                ])))
                                      ]))))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.05,
                                      left: width * 0.07,
                                      right: width * 0.05),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xFFD08DED),
                                      )))),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.05,
                                      left: width * 0.035,
                                      right: width * .085),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xFFD08DED),
                                      )))),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.05, right: width * 0.12),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xFFD08DED),
                                      )))),
                        ])),
                    Expanded(
                        flex: 2,
                        child: Row(children: [
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.035,
                                    right: 0.02 * width,
                                    left: width * 0.06),
                                child: SfCartesianChart(
                                  plotAreaBackgroundColor: Color(0xffEFF5F5),
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                    minimum: 0,
                                    labelStyle: TextStyle(
                                        fontSize: width * 0.007),
                                    rangePadding: ChartRangePadding.none,
                                    opposedPosition: false,
                                  ),
                                  series: <ChartSeries>[
                                    ColumnSeries<Incident, String>(
                                        dataSource: p.incidents,
                                        xValueMapper: (Incident number,
                                            _) => number.type,
                                        yValueMapper: (Incident number, _) =>
                                        number.number,
                                        color: Color(0xffFFB4B4)),
                                  ],
                                ),
                              )),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: width * 0.09, top: height * 0.035),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  labelStyle: TextStyle(fontSize: width * 0.01),
                                ),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: 33,
                                  labelStyle: TextStyle(
                                      fontSize: width * 0.007),
                                  rangePadding: ChartRangePadding.none,
                                  opposedPosition: false,
                                ),
                                series: <ChartSeries>[
                                  ColumnSeries<Incident, String>(
                                      dataSource: p.daysOff,
                                      xValueMapper: (Incident number, _) =>
                                      number.type,
                                      yValueMapper: (Incident number, _) =>
                                      number.number,
                                      width: 0.6,
                                      color: Color(0xffFFB4B4)),
                                ],
                              ),
                            ),
                          )
                        ]))
                  ]));
            }else{
              return SizedBox();
            }
            }
          ));
  }
}

