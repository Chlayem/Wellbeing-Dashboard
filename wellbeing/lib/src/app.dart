import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/pprovider.dart';
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

class App extends StatelessWidget {
  final List<MenuuItem> items =[
    MenuuItem(title: "Home", icon: Icons.home,screenIndex: 0),
    MenuuItem(title: "Team", icon: Icons.people,screenIndex: 1),
    MenuuItem(title: "KPI", icon: Icons.add_chart,screenIndex: 0,isExpansion: true,exItems: [
      MenuuItem(title: "Indicators", icon:Icons.table_rows_rounded,screenIndex: 2),
      MenuuItem(title: "Data", icon: Icons.table_view_rounded,screenIndex: 3),
      MenuuItem(title: "Monthly Dashboard",icon:Icons.area_chart,screenIndex: 4),
      MenuuItem(title: "YTD Dashboard", icon:Icons.area_chart,screenIndex: 5)
    ]),
    MenuuItem(title: "Settings", icon:Icons.settings,screenIndex: 6)
  ];
  @override
  Widget build(BuildContext context) {
    return PProvider(
      child: MaterialApp(home: Builder(builder: (BuildContext context) {
        return MediaQuery.of(context).size.width > 700
            ? Scaffold(
                body: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.25,
                    child:Draweer(items: items),
                  ),
                  Expanded(
                    child: StreamBuilder<int>(
                      stream: Provider.of(context).currentScreen,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        if (!snapshot.hasData) {
                          return Home(); // Default screen to show when the stream doesn't have any data yet
                        } else {
                          switch (snapshot.data) {
                            case 0:
                              return Home();
                            case 1:
                              return TeamScreen();
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
                appBar: AppBar(title: Text('WellBeing Dashboard')),
                drawer: Draweer(items: items,),
                body: StreamBuilder<int>(
                    stream: Provider.of(context).currentScreen,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (!snapshot.hasData) {
                        return Home(); // Default screen to show when the stream doesn't have any data yet
                      } else {
                        switch (snapshot.data) {
                          case 0:
                            return Home();
                          case 1:
                            return TeamScreen();
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
