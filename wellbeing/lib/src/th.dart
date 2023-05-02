import 'package:flutter/material.dart';

import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/screens/Details.dart';
import 'package:wellbeing/src/screens/dash.dart';
import 'package:wellbeing/src/screens/det.dart';
import 'package:wellbeing/src/screens/details_moblie.dart';
import 'package:wellbeing/src/screens/parameters.dart';
import 'blocs/provider.dart';
import 'elements/drawer.dart';
import 'elements/menu_item.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Employee> emp=[
  Employee(name: "Jhon",department: "Marketing",stress:1,anxiety: 2,fatigue: 0,email: "jhon.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 28664020),
  Employee(name: "Kevin",department: "Production",stress: 0,anxiety: 0,fatigue: 1,email: "kevin.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 25668744),
  Employee(name: "Emma",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2,email: "emma.james@gmail.com",job: "Developer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 55870099),
  Employee(name: "James",department: "Finance",stress: 1,anxiety: 0,fatigue: 2,email: "james.james@gmail.com",job: "Engineer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 92050886),
  Employee(name: "Fred",department: "Finance",stress: 1,anxiety: 0,fatigue: 2,email: "fred.james@gmail.com",job: "Developer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 99885020),
  Employee(name: "Selena",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2,email: "selena.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 21741133),
  Employee(name: "Adam",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2,email: "adam.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 52114189),
];
final mark =emp.where((e) => e.department=="Marketing").toList();
final finn =emp.where((e) => e.department=="Finance").toList();
final prod =emp.where((e) => e.department=="Production").toList();
class Th extends StatelessWidget {

  final List<MenuuItem> items =[
    MenuuItem(title: "Home", icon: Icons.home, screenIndex: 0),
    MenuuItem(title: "Departments", icon: Icons.account_balance_rounded, screenIndex: -1,isExpansion: true,exItems: [
      MenuuItem(title: "Production", screenIndex: 1),
      MenuuItem(title: "Finance",  screenIndex: 2),
      MenuuItem(title: "Marketing", screenIndex: 3)
    ]),
    MenuuItem(title: "Settings", icon: Icons.settings, screenIndex: 4),
  ];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme:ThemeData(
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
      fontFamily:'SpaceGrotesk',
    ),
        home: Builder(builder: (BuildContext context) {
      return MediaQuery.of(context).size.width > 900
          ? Scaffold(
          body: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                child:Draweer(items: items),
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
              drawer: Draweer(items: items,),
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
                          return DetailsMobile();
                        default:
                          Provider.of(context).pushList(emp);
                          return Dash(emp: emp,); // Default screen to show if the latest value in the stream doesn't match any of the cases
                      }
                    }
                  }),
      );
    }));
  }
}
