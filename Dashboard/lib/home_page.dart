import 'package:dashboard/pages/dash.dart';
import 'package:dashboard/pages/settings.dart';
import 'package:dashboard/pages/contacts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;
  @override
  Widget build(BuildContext context) {
    var container ;
    switch(currentPage){
      case(DrawerSections.dashboard):
        container = Dash();
        break;
      case(DrawerSections.settings):
        container = Settings();
        break;
      case(DrawerSections.contacts):
        container = Contacts();
        break;
    }
    return Scaffold(
      appBar: AppBar(),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget MyDrawerList(){
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1,"Dashboard",Icons.dashboard_outlined,currentPage == DrawerSections.dashboard ? true:false),
          menuItem(2,"Contacts",Icons.people_alt_outlined,currentPage==DrawerSections.contacts ? true:false),
          Divider(),
          menuItem(3,"Settings",Icons.settings_outlined,currentPage==DrawerSections.settings ? true:false),
        ],

      ),
    );

  }
  Widget menuItem(int id,String title,IconData icon,bool selected){
    return Material(
      color: selected ? Colors.grey[300]:Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
          setState(() {
            switch(id){
              case 1 :
                currentPage = DrawerSections.dashboard;
                break;
              case 2 :
                currentPage = DrawerSections.contacts;
                break;
              case 3 :
                currentPage = DrawerSections.settings;
                break;
            }
          });
        },
        child: Padding(
          padding:EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black,
                  )
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style:TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ) ,
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
enum DrawerSections{
  dashboard,
  contacts,
  settings,
}