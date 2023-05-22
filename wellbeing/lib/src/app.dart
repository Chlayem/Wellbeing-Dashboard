import 'package:flutter/material.dart';
import 'elements/chart_data.dart';
import 'elements/employee.dart';
import 'elements/menu_item.dart';
import 'screens/homescreen.dart';
import 'screens/team.dart';
import 'blocs/provider.dart';
import 'screens/parameters.dart';
import 'screens/kpi.dart';
import 'elements/drawer.dart';
import 'screens/indicators.dart';
import 'screens/ytd.dart';
import 'screens/data.dart';
/*final List<Employee> emp=[
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
    ChartData(month: "Dec", value: 0),
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
    ChartData(month: "Dec", value: 0),
  ],email: "jhon.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 28664020),
  Employee(firstName: "Kevin",lastName:"Rodriguez",department: "Production",*//*stress: 0,anxiety: 0,fatigue: 1,*//*email: "kevin.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 25668744),
  Employee(firstName: "Emma",lastName:"Rodriguez",department: "Marketing",*//*stress: 1,anxiety: 0,fatigue: 2,*//*email: "emma.james@gmail.com",job: "Developer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 55870099),
  Employee(firstName: "James",lastName:"Rodriguez",department: "Finance",*//*stress: 1,anxiety: 0,fatigue: 2,*//*email: "james.james@gmail.com",job: "Engineer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 92050886),
  Employee(firstName: "Fred",lastName:"Rodriguez",department: "Finance",*//*stress: 1,anxiety: 0,fatigue: 2,*//*email: "fred.james@gmail.com",job: "Developer",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 99885020),
  Employee(firstName: "Selena",lastName:"Rodriguez",department: "Marketing",*//*stress: 1,anxiety: 0,fatigue: 2,*//*email: "selena.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 21741133),
  Employee(firstName: "Adam",lastName:"Rodriguez",department: "Marketing",*//*stress: 1,anxiety: 0,fatigue: 2,*//*email: "adam.james@gmail.com",job: "Manager",workHours:36,birthDate: DateTime(1980,5,20),recDate: DateTime(2019,2,23),num: 52114189),
];*/
class App extends StatelessWidget {
  final List<MenuuItem> items =[
    MenuuItem(title: "Home", icon: Icons.home,screenIndex: 0,isSelected: true),
    MenuuItem(title: "Team", icon: Icons.people,screenIndex: 1),
    MenuuItem(title: "KPI", icon: Icons.add_chart,screenIndex: 0,isExpansion: true,exItems: [
      MenuuItem(title: "Indicators", icon:Icons.table_rows_rounded,screenIndex: 2),
      MenuuItem(title: "Data", icon: Icons.table_view_rounded,screenIndex: 3),
      MenuuItem(title: "Monthly Dashboard",icon:Icons.area_chart,screenIndex: 4),
      MenuuItem(title: "YTD Dashboard", icon:Icons.area_chart,screenIndex: 5)
    ]),
    MenuuItem(title: "Log out", icon:Icons.logout_outlined,screenIndex: 6)
  ];
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(debugShowCheckedModeBanner:false,home: Builder(builder: (BuildContext context) {

        return MediaQuery.of(context).size.width > 1100
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
                          return Home(); // Default screen to show when the stream doesn't have any data yet
                        } else {
                          switch (snapshot.data) {
                            case 0:
                              return Home();
                            case 1:
                              return Crud(emp: Provider.of(context).currentList);
                            case 2:
                              return Indicators();
                            case 3:
                              return Data();
                            case 4:
                              return KPI();
                            case 5:
                              return YTD();
                            case 6:
                              return Parameters();
                            default:
                              return Home(); // Default screen to show if the latest value in the stream doesn't match any of the cases
                          }
                        }
                      },
                    ),
                  ),
                ],
              ))
            : Scaffold(
                appBar: AppBar(title: Text('WellBeing Dashboard'),backgroundColor: Color.fromRGBO(3, 28, 48, 1.0)),
                drawer: Draweer(items: items,),
                body: StreamBuilder<int>(
                    stream: Provider.of(context).screens,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (!snapshot.hasData) {
                        return Home(); // Default screen to show when the stream doesn't have any data yet
                      } else {
                        switch (snapshot.data) {
                          case 0:
                            return Home();
                          case 1:
                            return Crud(emp: Provider.of(context).currentList);
                          case 2:
                            return Indicators();
                          case 3:
                            return Data();
                          case 4:
                            return KPI();
                          case 5:
                            return YTD();
                          case 6:
                            return Parameters();
                          default:
                            return Home(); // Default screen to show if the latest value in the stream doesn't match any of the cases
                        }
                      }
                    }),
              );
      })),
    );
  }
}
