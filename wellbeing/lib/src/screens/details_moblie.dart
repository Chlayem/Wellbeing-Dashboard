
import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/elements/consultation.dart';

import '../elements/consultation_form.dart';


class DetailsMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth =MediaQuery.of(context).size.width;
    var columns = screenWidth > 500 ? 2:1;
    //List<Widget> list =;
    //Widget colrow = screenWidth < 500.0 ? Row(children: list,) : Column(children: list,);
    //exp = csl.map((e) => e.isExpanded).toList();



    return StreamBuilder<Employee>(
        stream: Provider.of(context).employees,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null){
            Employee employee = snapshot.data! ;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          //leading:CircleAvatar(
                          // backgroundImage: AssetImage("assets/Kevin.jpg"),
                          //),
                          title: Row(
                            children: [
                              Expanded(child: Text(employee.firstName)),
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
                    child: Column(
                      //crossAxisCount: columns,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                          decoration: BoxDecoration(
                            color:Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1.0, // soften the shadow
                                spreadRadius: 0.1, //extend the shadow
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
                                  Expanded(flex:1,child: Text("Job",style: TextStyle(fontWeight: FontWeight.w100),)),
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
                                                  Expanded(child: Text("${csl[i].date.year}-${csl[i].date.month}-${csl[i].date.day} "))
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
                        )],
                    ),
                  ),
                ],
              ),
            );
          }else{
            return SizedBox();
          }
        }
    );
  }
}
