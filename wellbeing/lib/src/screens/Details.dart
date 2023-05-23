import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:wellbeing/src/elements/chart_data.dart';
import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/elements/consultation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellbeing/src/elements/kpi_chart.dart';
import '../elements/consultation_form.dart';


class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeigth=MediaQuery.of(context).size.height;
    double screenWidth =MediaQuery.of(context).size.width;
    //var columns = screenWidth > 500 ? 2:1;
    double cardPadding;
    double buttonFontSize ;
    double nameFontSize;
    if(screenWidth<600){
      nameFontSize=16;
      buttonFontSize=12;
      cardPadding=5;

    }else{
      nameFontSize=21;
      buttonFontSize=18;
      cardPadding=screenWidth/40;

    }

    //List<Widget> list =;
    //Widget colrow = screenWidth < 500.0 ? Row(children: list,) : Column(children: list,);
    //exp = csl.map((e) => e.isExpanded).toList();



    return Container(
      color: Color(0xffdcdcdc),
      child: StreamBuilder<Employee>(
          stream: Provider.of(context).employees,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null){
              Employee employee = snapshot.data! ;
              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,10.0),
                        child: Card(
                          elevation: 8,
                          color: Color(0xffffffff),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: cardPadding),
                            child: ListTile(
                              leading:CircleAvatar(
                                backgroundImage: AssetImage("assets/${employee.firstName}.jpg"),
                              ),
                              title: Row(
                                children: [
                                  Expanded(child: Text('${employee.firstName!} ${employee.lastName!}',style:GoogleFonts.mulish(fontWeight:FontWeight.w700,letterSpacing:1,color: Color(0xff002966),fontSize: nameFontSize))),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: TextButton.icon(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: screenWidth*0.02,vertical: screenHeigth*0.025)),
                                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                            if (states.contains(MaterialState.hovered)) {
                                              return Color(0xffbbbbbb);
                                            }
                                            return Color(0xffdcdcdc); // default color
                                          },
                                        ),
                                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xff002966)),
                                      ),
                                      onPressed: (){},
                                      icon: Icon(Icons.calendar_month_rounded,size: buttonFontSize,),
                                      label: Text("Fix a meet",style:GoogleFonts.mulish(fontSize:buttonFontSize,fontWeight:FontWeight.w400,letterSpacing:1)),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 8)),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: TextButton.icon(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: screenWidth*0.02,vertical: screenHeigth*0.025)),
                                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                if (states.contains(MaterialState.hovered)) {
                                                  return Color(0xff002966);
                                                }
                                                return Color(0xff00559a); // default color
                                              },
                                            ),
                                            foregroundColor: MaterialStateProperty.all<Color>(Color(0xffdcdcdc))),
                                        onPressed: (){},
                                        icon: Icon(Icons.notification_add,size: buttonFontSize,),
                                        label: Text("Notify",style:GoogleFonts.mulish(fontSize:buttonFontSize,fontWeight:FontWeight.w400,letterSpacing:1))
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 600,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //crossAxisCount: columns,
                            children: [
                              Text('Info',style:GoogleFonts.mulish(fontWeight:FontWeight.w600,letterSpacing:1,fontSize:18,color: Color(0xff708090))),
                              SizedBox(height: 12.0),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffffffff),
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
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(flex:2,child: Text("Job",style: GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(flex:3,child: Text(": ${employee.job ?? "-"}",
                                            style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(flex:2,child: Text("Email",style: GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(flex:3,child: Text(": ${employee.email ?? "-"}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(flex:2,child: Text("Number",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(flex:3,child: Text(": ${employee.num ?? "-"}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1,color: Color(0xff2F4F4F) )))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(flex:2,child: Text("Birth date",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(flex:3,child: Text(": ${employee.birthDate?.day} - ${employee.birthDate?.month} - ${employee.birthDate?.year}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1,color: Color(0xff2F4F4F) )))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(flex:2,child: Text("Hiring date",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1,color: Color(0xff708090) ))),
                                        Expanded(flex:3,child: Text(": ${employee.recDate?.day} - ${employee.recDate?.month} - ${employee.recDate?.year}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(flex:2,child: Text("Working hours",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(flex:3,child: Text(": ${employee.workHours}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text('Consultations',style:GoogleFonts.mulish(fontWeight:FontWeight.w600,letterSpacing:1,fontSize: 18,color: Color(0xff708090))),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  StreamBuilder<List<Consultation>>(
                                      stream: Provider.of(context).consultations,
                                      builder: (context, snap) {
                                        if (snap.hasData && snap.data != null){
                                          final List<Consultation> csl = snap.data ?? [] ;
                                          //final List<bool> expandedList = csl.map((e) => e.isExpanded).toList(); //?? List.filled(csl.length, false);
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: csl.length,
                                            itemBuilder: (context,i){
                                              return Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 1.0),
                                                child: Card(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: Colors.white,
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
                                                    ),
                                                    child: ExpansionTile(
                                                      title: Row(
                                                        children: [
                                                          Expanded(child: Text("Date de consultation :",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090))),flex: 2),
                                                          Expanded(child: Text("${csl[i].date.year}-${csl[i].date.month}-${csl[i].date.day} ",style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1,color: Color(0xff2F4F4F))))
                                                        ],
                                                      ),
                                                      onExpansionChanged: (expanded){
                                                        csl[i].isExpanded=expanded;
                                                        Provider.of(context).pushCsl(csl);
                                                      },
                                                      initiallyExpanded: csl[i].isExpanded,
                                                      children: [
                                                        ListTile(
                                                          title: Text("Bilan:",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090))),
                                                          subtitle: Text(csl[i].bilan,style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )),
                                                        ),
                                                        ListTile(
                                                          title: Text("Diagnostics:",style:GoogleFonts.mulish(fontWeight:FontWeight.w300 ,color: Color(0xff708090))),
                                                          subtitle: Text(csl[i].diag,style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )),
                                                        ),
                                                        ListTile(
                                                          title: Text("Pronostics:",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090))),
                                                          subtitle: Text(csl[i].pro,style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )),
                                                        ),
                                                        ListTile(
                                                          title: Text("Resumé:",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090))),
                                                          subtitle: Text(csl[i].res,style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }else{
                                          return SizedBox();
                                        }
                                      }
                                  ),

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 1.0),
                                child: ConsultationForm(),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal:20.0),
                                child: KpiChart(
                                  chartData: employee.stress,
                                  positionedText:'',

                                  title: 'Stress',
                                  xValueMapper: (ChartData data) => data.month,
                                  yValueMapper: (ChartData data, int _) => data.value,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal:20.0),
                                child: KpiChart(
                                  chartData: employee.anxiety,
                                  positionedText:'',

                                  title: 'Anxiety',
                                  xValueMapper: (ChartData data) => data.month,
                                  yValueMapper: (ChartData data, int _) => data.value,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal:20.0),
                                child: KpiChart(
                                  chartData: employee.fatigue,
                                  positionedText:'',

                                  title: 'Fatigue',
                                  xValueMapper: (ChartData data) => data.month,
                                  yValueMapper: (ChartData data, int _) => data.value,
                                ),
                              ),
                            ],

                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }else{
              return SizedBox();
            }
          }
      ),

    );
  }
}


/*

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/elements/consultation.dart';
import 'package:intl/intl.dart';
import '../elements/chart_data.dart';
import '../elements/consultation_form.dart';
import '../elements/kpi_chart.dart';


class Details extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth =MediaQuery.of(context).size.width;
    var columns = screenWidth > 500 ? 2:1;
    var contentWidth = screenWidth > 900 ? screenWidth*0.5:screenWidth*0.9;
    //List<Widget> list =;
    //Widget colrow = screenWidth < 500.0 ? Row(children: list,) : Column(children: list,);
    //exp = csl.map((e) => e.isExpanded).toList();

    double cardPadding= screenWidth /40;

    return StreamBuilder<Employee>(
      stream: Provider.of(context).employees,
      builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data != null){
        Employee employee = snapshot.data! ;
          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.fromLTRB(cardPadding,20.0,cardPadding,10.0),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading:CircleAvatar(
                              backgroundImage: AssetImage("assets/Kevin.jpg"),
                            ),
                            title: Row(
                              children: [
                                Expanded(child: Text(employee.firstName!,style: GoogleFonts.varelaRound(),)),
                                TextButton.icon(
                                  onPressed: (){},
                                  icon: Icon(Icons.calendar_month_rounded),
                                  label: Text("Fix a meet"),
                                ),
                                TextButton.icon(
                                  onPressed: (){},
                                  icon: Icon(Icons.notification_add),
                                  label: Text("Notify")
                                )
                              ],
                            ),
                            ),
                        ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: contentWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //crossAxisCount: columns,
                          children: [
                            Text("Informations :",style: GoogleFonts.varelaRound(color: Color(0xff154F62),fontWeight: FontWeight.bold),),
                            SizedBox(height: 20.0,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                              decoration: BoxDecoration(

                                color:Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 1.0, // soften the shadow
                                    spreadRadius: 0.8, //extend the shadow
                                    offset: Offset(
                                      0, // Move to right 5  horizontally
                                      0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(flex:1,child: Text("Job",style: GoogleFonts.mulish(),)),
                                      Expanded(child: Text(": ${employee.job ?? "-"}",))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Email")),
                                      Expanded(child: Text(": ${employee.email ?? "-"}"))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Number")),
                                      Expanded(child: Text(": ${employee.num ?? "-"}"))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Birth date",style: TextStyle(fontWeight: FontWeight.w100),)),
                                      Expanded(child: Text(": ${employee.birthDate?.day} - ${employee.birthDate?.month} - ${employee.birthDate?.year}"))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Hiring date")),
                                      Expanded(child: Text(": ${employee.recDate?.day} - ${employee.recDate?.month} - ${employee.recDate?.year}"))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Working hours")),
                                      Expanded(child: Text(": ${employee.workHours}"))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Text("Consultations :",style: TextStyle(color: Color(0xff154F62),fontWeight: FontWeight.bold),),
                            Column(
                              children: [
                                StreamBuilder<List<Consultation>>(
                                  stream: Provider.of(context).consultations,
                                  builder: (context, snap) {
                                    if (snap.hasData && snap.data != null){
                                      final List<Consultation> csl = snap.data ?? [] ;
                                      //final List<bool> expandedList = csl.map((e) => e.isExpanded).toList(); //?? List.filled(csl.length, false);
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: csl.length,
                                        itemBuilder: (context,i){
                                          return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 1.0),
                                            child: Card(
                                              child: ExpansionTile(
                                                title: Row(
                                                  children: [
                                                    Expanded(child: Text("Date de consultation :"),flex: 2,),
                                                    Expanded(child: Text(DateFormat('yyyy-MM-dd').format(csl[i].date)))
                                                  ],
                                                ),
                                                onExpansionChanged: (expanded){
                                                  csl[i].isExpanded=expanded;
                                                  Provider.of(context).pushCsl(csl);
                                                },
                                                initiallyExpanded: csl[i].isExpanded,
                                                children: [
                                                  ListTile(
                                                    title: Text("Bilan de consultation:"),
                                                    subtitle: Text(csl[i].bilan),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }else{
                                      return SizedBox();
                                    }
                                  }
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 1.0),
                                  child: ConsultationForm(),
                                ),

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal:20.0),
                              child: KpiChart(
                                chartData: employee.stress,
                                title: 'Stress',
                                xValueMapper: (ChartData data) => data.month,
                                yValueMapper: (ChartData data, int _) => data.value,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal:20.0),
                              child: KpiChart(
                                chartData: employee.anxiety,
                                title: 'Anxiety',
                                xValueMapper: (ChartData data) => data.month,
                                yValueMapper: (ChartData data, int _) => data.value,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal:20.0),
                              child: KpiChart(
                                chartData: employee.fatigue,
                                title: 'Fatigue',
                                xValueMapper: (ChartData data) => data.month,
                                yValueMapper: (ChartData data, int _) => data.value,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
              ),
            ),
          );
      }else{
        return SizedBox();
      }
      }
    );
  }
}
*/
