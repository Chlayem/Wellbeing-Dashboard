import 'dart:js';

import 'package:flutter/material.dart';
import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/elements/consultation.dart';


class Details extends StatelessWidget {
  List<Consultation> csl =[Consultation(date:DateTime(2020,5,9)),Consultation(date: DateTime(2021,9,18)),Consultation(date: DateTime(2022,8,26))];
  Employee employee;

  Details({required this.employee});

  @override
  Widget build(BuildContext context) {
    double screenWidth =MediaQuery.of(context).size.width;
    //List<Widget> list =;
    //Widget colrow = screenWidth < 500.0 ? Row(children: list,) : Column(children: list,);



    return Scaffold(
      body: Column(
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
            child: Column(
              children: [
                Expanded(
                  flex: 2,
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
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: csl.length,
                        itemBuilder: (context,i){
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 1.0),
                            child: Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Expanded(child: Text("Date de consultation :"),flex: 2,),
                                    Expanded(child: Text("${csl[i].date.year}-${csl[i].date.month}-${csl[i].date.day} "))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
      ),
    );
  }
}
