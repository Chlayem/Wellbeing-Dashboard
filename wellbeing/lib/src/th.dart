import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/screens/Details.dart';
import 'package:wellbeing/src/screens/dash.dart';
import 'package:wellbeing/src/screens/parameters.dart';
import 'package:wellbeing/src/screens/welcome_screen.dart';
import 'blocs/provider.dart';
import 'elements/chart_data.dart';
import 'elements/drawer.dart';
import 'elements/menu_item.dart';
import 'package:google_fonts/google_fonts.dart';

/*
final List<Employee> emp=[
  Employee(firstName: "Jhon",lastName:"Rodriguez",department: "Marketing",stress:[
    ChartData(month: "Jan", value: 2),
    ChartData(month: "Feb", value: 1),
    ChartData(month: "Mar", value: 1),
    ChartData(month: "Apr", value: 0),
    ChartData(month: "May", value: 2),
    ChartData(month: "Jun", value: 1),
    ChartData(month: "Jul", value: 0),
    ChartData(month: "Aug", value: 0),
    ChartData(month: "Sep", value: 0),
    ChartData(month: "Oct", value: 0),
    ChartData(month: "Nov", value: 0),
    ChartData(month: "Dec", value: 1),
  ],anxiety: [
    ChartData(month: "Jan", value: 0),
    ChartData(month: "Feb", value: 1),
    ChartData(month: "Mar", value: 1),
    ChartData(month: "Apr", value: 0),
    ChartData(month: "May", value: 2),
    ChartData(month: "Jun", value: 2),
    ChartData(month: "Jul", value: 2),
    ChartData(month: "Aug", value: 1),
    ChartData(month: "Sep", value: 2),
    ChartData(month: "Oct", value: 2),
    ChartData(month: "Nov", value: 0),
    ChartData(month: "Dec", value: 0),
  ],fatigue: [
    ChartData(month: "Jan", value: 2),
    ChartData(month: "Feb", value: 1),
    ChartData(month: "Mar", value: 1),
    ChartData(month: "Apr", value: 0),
    ChartData(month: "May", value: 2),
    ChartData(month: "Jun", value: 1),
    ChartData(month: "Jul", value: 0),
    ChartData(month: "Aug", value: 1),
    ChartData(month: "Sep", value: 2),
    ChartData(month: "Oct", value: 2),
    ChartData(month: "Nov", value: 0),
    ChartData(month: "Dec", value: 1),
  ],email: "jhon.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 28664020),
  Employee(firstName: "Kevin",lastName:"Rodriguez",department: "Production",stress: [ChartData(month: "Mars")],anxiety: [ChartData(month: "Mars")],fatigue: [ChartData(month: "Mars")],email: "kevin.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 25668744),
  Employee(firstName: "Emma",lastName:"Rodriguez",department: "Marketing",stress: [ChartData(month: "Mars")],anxiety: [ChartData(month: "Mars")],fatigue: [ChartData(month: "Mars")],email: "emma.james@gmail.com",job: "Developer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 55870099),
  Employee(firstName: "James",lastName:"Rodriguez",department: "Finance",stress: [ChartData(month: "Mars")],anxiety: [ChartData(month: "Mars")],fatigue: [ChartData(month: "Mars")],email: "james.james@gmail.com",job: "Engineer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 92050886),
  Employee(firstName: "Fred",lastName:"Rodriguez",department: "Finance",stress: [ChartData(month: "Mars")],anxiety: [ChartData(month: "Mars")],fatigue: [ChartData(month: "Mars")],email: "fred.james@gmail.com",job: "Developer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 99885020),
  Employee(firstName: "Selena",lastName:"Rodriguez",department: "Marketing",stress: [ChartData(month: "Mars")],anxiety: [ChartData(month: "Mars")],fatigue: [ChartData(month: "Mars")],email: "selena.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 21741133),
  Employee(firstName: "Adam",lastName:"Rodriguez",department: "Marketing",stress: [ChartData(month: "Mars")],anxiety: [ChartData(month: "Mars")],fatigue: [ChartData(month: "Mars")],email: "adam.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 52114189),];
*/

class Th extends StatelessWidget {
  String username ;
  String role ;
  Th({required this.username,required this.role});

  final List<MenuuItem> items =[
    MenuuItem(title: "Home", icon: Icons.home, screenIndex: 0,isSelected: true),
    MenuuItem(title: "Departments", icon: Icons.account_balance_rounded, screenIndex: -1,isExpansion: true,exItems: [
      MenuuItem(title: "Production", screenIndex: 1,),
      MenuuItem(title: "Finance",  screenIndex: 2),
      MenuuItem(title: "Marketing", screenIndex: 3)
    ]),
    MenuuItem(title: "Log out", icon: Icons.logout_rounded, screenIndex: 5),
  ];



  @override
  Widget build(BuildContext context) {
    final List<Employee> emp =Provider.of(context).currentList ;
    final mark =emp.where((e) => e.department=="Marketing").toList();
    final finn =emp.where((e) => e.department=="Finance").toList();
    final prod =emp.where((e) => e.department=="Production").toList();


      return MediaQuery.of(context).size.width > 900
          ? Scaffold(
          body: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                child:Draweer(username:username,role:role,items: items),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.75,
                child: StreamBuilder<int>(
                  stream: Provider.of(context).screens,
                  builder:
                      (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (!snapshot.hasData) {
                      return Dash(emp: emp,); // Default screen to show when the stream doesn't have any data yet
                    } else {
                      switch (snapshot.data) {
                        case 0:
                          Provider.of(context).pushListFound(emp);
                          return Dash(emp: emp,);
                        case 1:
                          Provider.of(context).pushListFound(prod);
                          return Dash(emp: prod);
                        case 2:
                          Provider.of(context).pushListFound(finn);
                          return Dash(emp: finn);
                        case 3:
                          Provider.of(context).pushListFound(mark);
                          return Dash(emp: mark);
                        case 4:
                          return Details();
                        case 5:
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop();
                          Provider.of(context).navigateToScreen(0);

                          return Text('Log out');
                        default:
                          Provider.of(context).pushList(emp);
                          return Dash(emp: emp,); // Default screen to show if the latest value in the stream doesn't match any of the cases
                      }
                    }
                  },
                ),
              ),
            ],
          ))
          : Scaffold(
              appBar: AppBar(title: Text('WellBeing Dashboard'),backgroundColor: Color.fromRGBO(3, 28, 48, 1.0),),
              drawer: Draweer(username:username,role:role,items: items),
              body: StreamBuilder<int>(
                  stream: Provider.of(context).screens,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (!snapshot.hasData) {
                      Provider.of(context).pushList(emp);
                      return Dash(emp: emp,); // Default screen to show when the stream doesn't have any data yet
                    } else {
                      switch (snapshot.data) {
                        case 0:
                          Provider.of(context).pushList(emp);
                          return Dash(emp: emp,);
                        case 1:
                          Provider.of(context).pushList(prod);
                          return Dash(emp: prod);
                        case 2:
                          Provider.of(context).pushList(finn);
                          return Dash(emp: finn);
                        case 3:
                          Provider.of(context).pushList(mark);
                          return Dash(emp: mark);
                        case 4:
                          return Details();
                        case 5:
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop();
                          Provider.of(context).navigateToScreen(0);

                          return Text('Log out');

                        default:
                          Provider.of(context).pushList(emp);
                          return Dash(emp: emp,); // Default screen to show if the latest value in the stream doesn't match any of the cases
                      }
                    }
                  }),
      );
  }
}
