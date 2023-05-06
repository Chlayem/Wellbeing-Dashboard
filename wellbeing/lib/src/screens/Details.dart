
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
