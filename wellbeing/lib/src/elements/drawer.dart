import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import 'menu_item.dart';

class Draweer extends StatefulWidget {
  List<MenuuItem> items;
  Draweer({required this.items});
  @override
  State<Draweer> createState() => _DraweerState();
}

class _DraweerState extends State<Draweer> {
  Widget build(context) {
    //bool s=false;
    double screenWidth = MediaQuery.of(context).size.width;
    //double itemSpacing = screenHeight * 0.02;

    return Drawer(
      elevation: 0,
      backgroundColor: Color.fromRGBO(3, 28, 48, 1.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/James.jpg"),
              ),
              title: Text("James Rodriguez",style: TextStyle(color: Colors.white,),),
              subtitle: Text("Responsable ressources humaines",style: TextStyle(color: Colors.grey),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Divider(color: Colors.white,),
          ),
          //SizedBox(height: 50.0,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (context,i){
              if(widget.items[i].isExpansion){
                List<MenuuItem>? l=widget.items[i].exItems;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5.0,5.0,5.0,5.0),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(widget.items[i].icon,color: Colors.white,),
                    title: Text(widget.items[i].title,style:TextStyle(
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
                                selected: l?[j].isSelected??false,
                                selectedTileColor: Color.fromRGBO(102, 122, 138, 1.0),
                              hoverColor: Color.fromRGBO(102, 122, 138, 1.0),
                              leading:Icon(l![j].icon,color: Colors.white,size: 15.0,) ,
                              title: Text(l[j].title,style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),),
                              onTap: () {setState(() {
                                for(MenuuItem item in widget.items){
                                  if (item.isExpansion){
                                    for(MenuuItem it in item.exItems!){
                                      it.isSelected=false;
                                    }}else{
                                    item.isSelected=false;
                                  }
                                }
                                l[j].isSelected=true;
                              });

                                if(screenWidth <= 1100){
                                  Navigator.of(context).pop();
                                }
                                Provider.of(context).navigateToScreen(l[j].screenIndex);

                              }
                            ),
                          );
                        }
                    ),]
                  ),
                );
              } else{return Padding(
                padding: EdgeInsets.fromLTRB(5.0,5.0,5.0,5.0),
                child: ListTile(
                  selected: widget.items[i].isSelected,
                  selectedTileColor: Color.fromRGBO(102, 122, 138, 1.0),
                  hoverColor: Color.fromRGBO(102, 122, 138, 1.0),
                  leading: Icon(widget.items[i].icon,color: Colors.white,),
                  title: Text(widget.items[i].title,style: TextStyle(
                    color: Colors.white,
                    //letterSpacing: 3.0,
                  ),),
                  onTap: (){
                    setState(() {
                      for(MenuuItem item in widget.items){
                        if (item.isExpansion){
                          for(MenuuItem it in item.exItems!){
                            it.isSelected=false;
                          }}else{
                          item.isSelected=false;
                        }
                      }
                      widget.items[i].isSelected=true;
                    });

                    if(screenWidth <= 1100){
                      Navigator.of(context).pop();
                    }
                    Provider.of(context).navigateToScreen(widget.items[i].screenIndex);

                  },
                ),
              );}
            }
          ),
        ],
      ),
    );
  }
}