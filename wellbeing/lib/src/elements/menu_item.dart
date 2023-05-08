import 'package:flutter/material.dart';

class MenuuItem {
  String title;
  IconData? icon;
  int screenIndex;
  bool isExpansion ;
  List<MenuuItem>? exItems;
  bool isSelected;



  MenuuItem({this.isSelected=false,required this.title, this.icon,required this.screenIndex,this.isExpansion=false,this.exItems});
}