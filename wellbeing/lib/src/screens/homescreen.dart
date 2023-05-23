import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellbeing/src/elements/period.dart';
import '../elements/bar_chart(kpi).dart';
import '../blocs/provider.dart';
import '../elements/department.dart';
import '../elements/incident.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  String _selectedMonth = "";
  final List<String> _months = [
    'January',
    'February',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre',
  ];
  final List<String> _years = ['2020', '2021', '2022', '2023'];

  /*final dataMap = <String, double>{
    "Flutter": 5,
  };*/

  final colorList = <Color>[
    Color(0xffFFB4B4),
  ];

  Color? setColorStress(double val) {
    if (val < 10) {
      return Colors.lightBlue[100];
    } else if (val < 20) {
      return Colors.lightBlue;
    } else {
      return Colors.lightBlue[800];
    }
  }

  Color? setColorAnx(double val) {
    if (val < 10) {
      return Colors.pink[100];
    } else if (val < 20) {
      return Colors.pink;
    } else {
      return Colors.pink[800];
    }
  }

  Color? setColorFat(double val) {
    if (val < 10) {
      return Colors.green[100];
    } else if (val < 20) {
      return Colors.green[300];
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int pieChartCount = screenWidth > 700 ? 3 : 1;
    double pieChartRatio = screenWidth > 700 ? 1.5 : screenWidth / 200;
    double chartPaddingHorizantal =
        screenWidth < 600 ? screenWidth * 0.01 : screenWidth * 0.03;
    double chartPaddingVertical = screenWidth < 600 ? 0 : screenWidth * 0.01;

    return Container(
        color: Color(0xffdcdcdc),
        child: SingleChildScrollView(
          child: StreamBuilder<Period>(
              stream: Provider.of(context).periods,
              builder: (BuildContext context, AsyncSnapshot<Period> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  Period p = snapshot.data!;
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: DropdownButton(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                                underline: SizedBox(),
                                value: Provider.of(context).currentPeriod.month,
                                items: _months
                                    .map((month) => DropdownMenuItem<String>(
                                          value: month,
                                          child: Text(month),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  Provider.of(context)
                                      .pushPeriod(value ?? 'Mars');
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: DropdownButton(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                                underline: SizedBox(),
                                value: '2023',
                                items: _years
                                    .map((year) => DropdownMenuItem<String>(
                                          value: year,
                                          child: Text(year),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                              ),
                            ),
                            /*ElevatedButton(
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
                          ),*/
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: pieChartCount,
                            childAspectRatio: pieChartRatio,
                            crossAxisSpacing: 50,
                            mainAxisSpacing: 20,
                          ),
                          shrinkWrap: true,
                          itemCount: p.departments.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              /*padding: EdgeInsets.only(
                                  left: width * .006,
                                  right: width * 0.006),*/
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 11.0, // soften the shadow
                                    spreadRadius: 0.8, //extend the shadow
                                    offset: Offset(
                                      0, // Move to right 5  horizontally
                                      0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xffffffff),
                              ),
                              child: Column(children: [
                                Expanded(
                                    flex: 5,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * .01),
                                        child: Text(p.departments[i].name,
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal,
                                                fontSize: 24,
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
                                        baseChartColor: Color(0xffdfdfdf),
                                        colorList: [
                                          setColorStress(p
                                              .departments[i].stress.values
                                              .toList()
                                              .first)!
                                        ],
                                        chartValuesOptions: ChartValuesOptions(
                                          showChartValues: false,
                                          showChartValueBackground: false,
                                          showChartValuesInPercentage: true,
                                          decimalPlaces: 0,
                                        ),
                                        totalValue: 100,
                                        ringStrokeWidth: 10,
                                        chartRadius: 65,
                                        initialAngleInDegree: 180,
                                        legendOptions:
                                            LegendOptions(showLegends: false),
                                      )),
                                      Expanded(
                                          child: PieChart(
                                        centerText:
                                            '${p.departments[i].anxiety.values.toList().first}%',
                                        dataMap: p.departments[i].anxiety,
                                        chartType: ChartType.ring,
                                        baseChartColor: Color(0xffdfdfdf),
                                        colorList: [
                                          setColorAnx(p
                                              .departments[i].anxiety.values
                                              .toList()
                                              .first)!
                                        ],
                                        chartValuesOptions: ChartValuesOptions(
                                          showChartValues: false,
                                          showChartValueBackground: false,
                                          showChartValuesInPercentage: true,
                                          decimalPlaces: 0,
                                        ),
                                        totalValue: 100,
                                        ringStrokeWidth: 10,
                                        chartRadius: 65,
                                        initialAngleInDegree: 180,
                                        legendOptions:
                                            LegendOptions(showLegends: false),
                                      )),
                                      Expanded(
                                          child: PieChart(
                                        centerText:
                                            '${p.departments[i].fatigue.values.toList().first}%',
                                        dataMap: p.departments[i].fatigue,
                                        chartType: ChartType.ring,
                                        baseChartColor: Color(0xffdfdfdf),
                                        colorList: [
                                          setColorFat(p
                                              .departments[i].fatigue.values
                                              .toList()
                                              .first)!
                                        ],
                                        chartValuesOptions: ChartValuesOptions(
                                          showChartValues: false,
                                          showChartValueBackground: false,
                                          showChartValuesInPercentage: true,
                                          decimalPlaces: 0,
                                        ),
                                        totalValue: 100,
                                        ringStrokeWidth: 10,
                                        chartRadius: 65,
                                        initialAngleInDegree: 180,
                                        legendOptions:
                                            LegendOptions(showLegends: false),
                                      )),
                                    ])),
                                Expanded(
                                    flex: 3,
                                    child: Row(children: [
                                      Expanded(
                                          child: Center(
                                        child: Text('Stress',
                                            style: GoogleFonts.mulish(
                                                color: Colors.grey[800],
                                                fontSize: 16)),
                                      )),
                                      Expanded(
                                          child: Center(
                                        child: Text('Anxiety',
                                            style: GoogleFonts.mulish(
                                                color: Colors.grey[800],
                                                fontSize: 16.0)),
                                      )),
                                      Expanded(
                                          child: Center(
                                        child: Text('Fatigue',
                                            style: GoogleFonts.mulish(
                                                color: Colors.grey[800],
                                                fontSize: 16.0)),
                                      )),
                                    ]))
                              ]),
                            );
                          },
                        ),
                        SizedBox(height: 30,),
                        Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(screenWidth * 0.04, 40, screenWidth * 0.01, 40),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.005, horizontal: screenWidth * 0.005),
                                    height: screenWidth > 600 ? 100 : 80,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 11.0,
                                          spreadRadius: 0.8,
                                          offset: Offset(
                                            0,
                                            0,
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(25),
                                      color: Color(0xffffffff),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "Employees",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.mulish(color:Color(
                                                  0xFF415781),fontSize: screenWidth > 600 ? 16 : 10, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "76",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(fontSize: screenWidth > 600 ? 22 : 16, fontWeight: FontWeight.w800),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01, horizontal: screenWidth * 0.02),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.005, horizontal: screenWidth * 0.005),
                                    height: screenWidth > 600 ? 100 : 80,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 11.0,
                                          spreadRadius: 0.8,
                                          offset: Offset(
                                            0,
                                            0,
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(25),
                                      color: Color(0xffffffff),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "Participation in trainings",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.mulish(color:Color(
                                                  0xFF415781),fontSize: screenWidth > 600 ? 16 : 10, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "243",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(fontSize: screenWidth > 600 ? 22 : 16, fontWeight: FontWeight.w800),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(screenWidth * 0.01, 40, screenWidth * 0.04, 40),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.005, horizontal: screenWidth * 0.005),
                                        height: screenWidth > 600 ? 100 : 80,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 11.0,
                                              spreadRadius: 0.8,
                                              offset: Offset(
                                                0,
                                                0,
                                              ),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(25),
                                          color: Color(0xffffffff),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "Complaints",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.mulish(color:Color(0xFF415781),fontSize: screenWidth > 600 ? 16 : 10, fontWeight: FontWeight.bold),

                                                  ),
                                                )),
                                            Expanded(
                                              child: Text(
                                                "19",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.mulish(fontSize: screenWidth > 600 ? 22 : 16, fontWeight: FontWeight.w800),
                                              ),
                                            )
                                      ],
                                    ),
                                  ))),
                        ]),
                        GridView.count(
                            childAspectRatio: 1.1,
                            crossAxisSpacing: 0,
                            shrinkWrap: true,
                            mainAxisSpacing: 0,
                            crossAxisCount: screenWidth > 600 ? 2 : 1,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: chartPaddingHorizantal,
                                    vertical: chartPaddingVertical),
                                child: construireGraphiqueBarres('Severity', [
                                  BarChartData('Low', 1, p.incidents[0].number as double, Colors.greenAccent[400]!),
                                  BarChartData('Medium', 2, p.incidents[1].number as double, Colors.yellowAccent[400]!),
                                  BarChartData('High', 3, p.incidents[2].number as double, Colors.lightBlue),
                                  BarChartData('Critical', 4, p.incidents[3].number as double, Colors.pink)
                                ]),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: chartPaddingHorizantal,
                                    vertical: chartPaddingVertical),
                                child: construireGraphiqueBarres(
                                    'Type Of Incident', [
                                  BarChartData('Injury', 1, p.daysOff[0].number as double, Colors.greenAccent[400]!),
                                  BarChartData('Illness', 2, p.daysOff[1].number as double, Colors.yellowAccent[400]!),
                                  BarChartData('Psychological', 3, p.daysOff[2].number as double, Colors.lightBlue),
                                  BarChartData('Harrasment', 4, p.daysOff[3].number as double, Colors.pink),
                                  BarChartData('Other', 4, p.daysOff[4].number as double, Colors.deepPurple)
                                ]),
                              )
                            ])
                      ]));
                } else {
                  return SizedBox();
                }
              }),
        ));
  }
}
