
import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/elements/consultation.dart';


class Details extends StatelessWidget {
  List<Consultation> csl =[Consultation(date:DateTime(2020,5,9),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2021,9,18),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),Consultation(date: DateTime(2022,8,26),bilan: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")];
  List<bool> exp= [];
  @override
  Widget build(BuildContext context) {
    //double screenWidth =MediaQuery.of(context).size.width;
    //var columns = screenWidth > 500 ? 2:1;
    //List<Widget> list =;
    //Widget colrow = screenWidth < 500.0 ? Row(children: list,) : Column(children: list,);
    exp = csl.map((e) => e.isExpanded).toList();



    return StreamBuilder<Employee>(
      stream: Provider.of(context).employees,
      builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data != null){
        Employee employee = snapshot.data! ;
          return Column(
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
                            Expanded(child: Text(employee.name)),
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
                  child: Row(
                    //crossAxisCount: columns,
                    children: [
                      Expanded(
                        child: Container(
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
                                  Expanded(flex:1,child: Text("Job")),
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
                                  Expanded(child: Text("Birth date")),
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
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            StreamBuilder<List<bool>>(
                              stream: Provider.of(context).expandeds,
                              builder: (context, snap) {
                                if (snap.hasData && snap.data != null){
                                  final List<bool> expandedList = snap.data ?? List.filled(csl.length, false);
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
                                            children: [
                                              Text(csl[i].bilan),
                                            ],
                                            onExpansionChanged: (expanded){
                                              expandedList[i]=expanded;
                                              Provider.of(context).pushExpand(expandedList);
                                            },
                                            initiallyExpanded: expandedList[i],
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

                            FloatingActionButton(
                              onPressed: (){},
                              child:Icon(Icons.add),
                            )
                          ],
                        ),
                      )],
                  ),
                ),
              ],
          );
      }else{
        return SizedBox();
      }
      }
    );
  }
}
