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


  /*final dataMap = <String, double>{
    "Flutter": 5,
  };*/

  final colorList = <Color>[
    Color(0xffFFB4B4),
  ];

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int pieChartCount=width>700 ?3:1;
    double pieChartRatio = width > 700? 1.65: width/3/50;

    return Container(
        color: Color(0xffEFF5F5),
        child: SingleChildScrollView(
          child: StreamBuilder<Period>(
            stream: Provider.of(context).periods,
            builder: (BuildContext context, AsyncSnapshot<Period> snapshot) {

              if (snapshot.hasData && snapshot.data != null) {
                Period p = snapshot.data!;
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Column(children: [
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Period per = Period(departments: [
                                  Department(
                                    name: "Dev",
                                      stress: {"Flutter": 75},
                                      anxiety: {"anxiety": 15},
                                      fatigue: {"fatigue": 10}),
                                  Department(
                                      name: "Finance",
                                      stress: {"Flutter": 4},
                                      anxiety: {"anxiety": 18},
                                      fatigue: {"fatigue": 2}),
                                  Department(
                                      name:"Marketing",
                                      stress: {"Flutter": 7},
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
                                  Department(
                                      name: "Dev",
                                      stress: {"Flutter": 90},
                                      anxiety: {"anxiety": 5},
                                      fatigue: {"fatigue": 6}),
                                  Department(
                                      name: "Finance",
                                      stress: {"Flutter": 2},
                                      anxiety: {"anxiety": 5},
                                      fatigue: {"fatigue": 2}),
                                  Department(
                                      name: "Marketing",
                                      stress: {"Flutter": 7},
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
                      ),
                      GridView.builder(
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: pieChartCount,
                            childAspectRatio: pieChartRatio,
                            crossAxisSpacing:50 ,
                            mainAxisSpacing: 20,
                          ),
                        shrinkWrap: true,
                        itemCount: p.departments.length,
                          itemBuilder: (context,i){
                            return Container(
                                padding: EdgeInsets.only(
                                  left: width * .006,
                                  right: width * 0.006),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xffD6E4E5),
                                  ),
                            child:Column(children: [
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: height * .01),
                                      child: Text(p.departments[i].name,
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontSize:20,
                                              letterSpacing: 2)))),
                              Expanded(
                                  flex: 7,
                                  child: Row(children: [
                                    Expanded(
                                        child: PieChart(
                                          centerText:
                                          '${p.departments[i].stress.values.toList().first}%',
                                          dataMap: p.departments[i].stress,
                                          chartType: ChartType.ring,
                                          baseChartColor: Color(0xffFFF9CA),
                                          colorList: colorList,
                                          chartValuesOptions:
                                          ChartValuesOptions(
                                            showChartValues: false,
                                            showChartValueBackground: false,
                                            showChartValuesInPercentage: true,
                                            decimalPlaces: 0,
                                          ),
                                          totalValue: 100,
                                          ringStrokeWidth:15,
                                          chartRadius: 40,
                                          initialAngleInDegree: 180,
                                          legendOptions:
                                          LegendOptions(showLegends: false),
                                        )),
                                    Expanded(
                                        child: PieChart(
                                          centerText: '${p.departments[i].anxiety.values.toList().first}%',
                                          dataMap: p.departments[i].anxiety,
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
                                          ringStrokeWidth: 15,
                                          chartRadius: 40,
                                          initialAngleInDegree: 180,
                                          legendOptions:
                                          LegendOptions(
                                              showLegends: false),
                                        )),
                                    Expanded(
                                        child: PieChart(
                                          dataMap: p.departments[i].fatigue,
                                          chartType: ChartType.ring,
                                          baseChartColor: Color(0xffFFF9CA),
                                          colorList: colorList,
                                          chartValuesOptions:
                                          ChartValuesOptions(
                                            showChartValueBackground: false,
                                            showChartValuesInPercentage: true,
                                            decimalPlaces: 0,
                                          ),
                                          totalValue: 100,
                                          ringStrokeWidth: 15,
                                          chartRadius: 40,
                                          initialAngleInDegree: 180,
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
                                                    fontSize: 20))),
                                        Expanded(
                                            child: Text('Anxiety',
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 20.0))),
                                        Expanded(
                                            child: Text('Fatigue',
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 20.0))),
                                      ])))
                            ]) ,
                            );
                          },
                      ),

                      Row(children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.05,
                                    left: width * 0.07,
                                    right: width * 0.05),
                                child: Container(
                                  height: 70,
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
                                    height: 70,
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
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Color(0xFFD08DED),
                                    )))),
                      ]),
                      GridView.count(
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 150,
                        shrinkWrap: true,
                        crossAxisCount: width>700?2:1,
                          children: [
                            Container(
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
                                      fontSize: 10),
                                  rangePadding: ChartRangePadding.none,
                                  opposedPosition: false,
                                ),
                                series: <ChartSeries>[
                                  ColumnSeries<Incident, String>(
                                      dataSource: p.incidents,
                                      xValueMapper: (Incident number, _) => number.type,
                                      yValueMapper: (Incident number, _) => number.number,
                                      color: Color(0xffFFB4B4)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: width * 0.09, top: height * 0.035),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  labelStyle: TextStyle(fontSize: 10),
                                ),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: 33,
                                  labelStyle: TextStyle(
                                      fontSize:10),
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
                            )
                          ]
                      )
                    ]));
              }else{
                return SizedBox();
              }
              }
            ),
        ));
  }
}

