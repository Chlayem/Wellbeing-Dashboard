import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import 'menu_item.dart';

class Draweer extends StatelessWidget {
  List<MenuuItem> items;
  Draweer({required this.items});
  Widget build(context) {
    //bool s=false;
    //double screenHeight = MediaQuery.of(context).size.height;
    //double itemSpacing = screenHeight * 0.02;

    return Drawer(
      elevation: 0,
      backgroundColor: Color.fromRGBO(3, 28, 48, 1.0),
      child: Column(
        children: [
          SizedBox(height: 150.0,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context,i){
              if(items[i].isExpansion){
                List<MenuuItem>? l=items[i].exItems;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5.0,5.0,5.0,5.0),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(items[i].icon,color: Colors.white,),
                    title: Text(items[i].title,style:TextStyle(
                      color: Colors.white,
                      //letterSpacing: 3.0,
                    ) ,),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: l?.length  ,
                        itemBuilder: (context,j){
                          return Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: ListTile(
                              hoverColor: Color.fromRGBO(102, 122, 138, 1.0),
                              leading:Icon(l![j].icon,color: Colors.white,size: 15.0,) ,
                              title: Text(l[j].title,style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),),
                              onTap: () =>Provider.of(context).navigateToScreen(l[j].screenIndex),
                            ),
                          );
                        }
                    ),]
                  ),
                );
              } else{return Padding(
                padding: EdgeInsets.fromLTRB(5.0,5.0,5.0,5.0),
                child: ListTile(
                  //selected: items[i].isSelected,
                  //selectedColor: Colors.black,
                  hoverColor: Color.fromRGBO(102, 122, 138, 1.0),
                  leading: Icon(items[i].icon,color: Colors.white,),
                  title: Text(items[i].title,style: TextStyle(
                    color: Colors.white,
                    //letterSpacing: 3.0,
                  ),),
                  onTap: (){
                    //items[i].isSelected=true;
                    Provider.of(context).navigateToScreen(items[i].screenIndex);
                    },
                ),
              );}
            }
          ),
        ],
      ),
      /*child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.14),
          // add 20% of screen height from top
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(height: itemSpacing),
                ListTile(
                  hoverColor: Colors.white,
                  title: Row(children: const [
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.home))),
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Home Screen',
                              style: TextStyle(
                                letterSpacing: 3.0,
                              ),
                            ))),
                  ]),
                  onTap: () {
                    Provider.of(context).navigateToScreen(0);
                  },
                ),
                SizedBox(height: itemSpacing),
                ListTile(
                  hoverColor: Colors.white,
                  title: Row(children: const [
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.people))),
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Team Screen',
                              style: TextStyle(
                                letterSpacing: 3.0,
                              ),
                            ))),
                  ]),
                  onTap: () {
                    Provider.of(context).navigateToScreen(1);
                  },
                ),
                SizedBox(height: itemSpacing),
                Theme(
                    data: ThemeData(
                      hoverColor: Colors.white,
                    ),
                    child:ExpansionTile(
                      tilePadding: EdgeInsets.only(left: screenHeight*.04),
                      childrenPadding: EdgeInsets.only(left: screenHeight*.08),
                      title: Row(children: const [
                        Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.add_chart))),
                        Expanded(
                            flex: 2,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'KPI',
                                  style: TextStyle(
                                    letterSpacing: 3.0,
                                  ),
                                ))),
                      ]),
                      children: [
                        ListTile(
                          hoverColor: Colors.white,
                          title: Row(children: const [
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.table_rows_rounded))),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Indicators',
                                      style: TextStyle(
                                        letterSpacing: 3.0,
                                      ),
                                    ))),
                          ]),
                          onTap: () {
                            Provider.of(context).navigateToScreen(4);
                          },
                        ),
                        SizedBox(height: itemSpacing / 2),
                        ListTile(
                          hoverColor: Colors.white,
                          title: Row(children: const [
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.table_view_rounded))),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'DATA',
                                      style: TextStyle(
                                        letterSpacing: 3.0,
                                      ),
                                    ))),
                          ]),
                          onTap: () {
                            Provider.of(context).navigateToScreen(5);
                          },
                        ),
                        SizedBox(height: itemSpacing),
                        ListTile(
                          hoverColor: Colors.white,
                          title: Row(children: const [
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.area_chart))),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Monthly Dashboard',
                                      style: TextStyle(
                                        letterSpacing: 3.0,
                                      ),
                                    ))),
                          ]),
                          onTap: () {
                            Provider.of(context).navigateToScreen(2);
                          },
                        ),
                        SizedBox(height: itemSpacing),
                        ListTile(
                          hoverColor: Colors.white,
                          title: Row(children: const [
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.area_chart))),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'YTd Dashboard',
                                      style: TextStyle(
                                        letterSpacing: 3.0,
                                      ),
                                    ))),
                          ]),
                          onTap: () {
                            Provider.of(context).navigateToScreen(6);
                          },
                        ),
                        SizedBox(height: itemSpacing),
                      ],
                    )),
                SizedBox(height: itemSpacing),
                ListTile(
                  hoverColor: Colors.white,
                  title: Row(children: const [
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.settings))),
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                letterSpacing: 3.0,
                              ),
                            ))),
                  ]),
                  onTap: () {
                    Provider.of(context).navigateToScreen(3);
                  },
                ),
                SizedBox(height: itemSpacing),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.14),
          // add 20% of screen height from bottom
        ],
      ),*/
    );
  }
}