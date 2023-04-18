import 'package:dashboard/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/employee.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}
Icon setColor(int i){
  Color c=Colors.green;
  switch(i){
    case 0:
      c = Colors.green;
      break;
    case 1 : 
      c = Colors.yellowAccent;
      break;
    case 2:
      c = Colors.red;
      break;
  }
  return Icon(Icons.circle,color: c,size: 10,);
}
class _DashState extends State<Dash> {

  List<Employee> emp=[
    Employee(name: "Jhon",department: "Marketing",stress:1,anxiety: 2,fatigue: 0),
    Employee(name: "Kevin",department: "IT",stress: 0,anxiety: 0,fatigue: 1),
    Employee(name: "Emma",department: "Marketing",stress: 1,anxiety: 0,fatigue: 2),
  ];
  List<Employee> empFound =[];
  @override
  void initState() {
    // TODO: implement initState
    empFound=emp;
    super.initState();
  }
  void runFilter(String entredKeyword){
    List<Employee> result = [];
    if(entredKeyword.isEmpty){
      result=emp;
    }else{
      result=emp.where((e) => e.name.toLowerCase().contains(entredKeyword.toLowerCase())).toList();
    }
    setState(() {
      empFound=result;
    });
  }

  @override
  Widget build(BuildContext context) {
    double searchWidth ;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardPadding= screenWidth /40;

    if (screenWidth>500) {
      searchWidth=400;
    }else{
      searchWidth=screenWidth-100;
    }
    return Column(
      children: [
        SizedBox(
          width: searchWidth,
          child: TextField(

            onChanged: (value) => runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search)
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: empFound.length,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: cardPadding),
              child: Card(
                child: ListTile(
                  onTap: (){
                    setState(() {

                    });
                  },
                  title: Row(
                    children: [
                      Expanded(child: Text(empFound[index].name)),
                      Expanded(
                          child: Row(
                            children: [
                              Expanded(flex:6,child: Text(empFound[index].department)),
                              Expanded(child: setColor(empFound[index].stress)),
                              Expanded(child: setColor(empFound[index].anxiety)),
                              Expanded(child: setColor(empFound[index].fatigue))
                            ],
                          )
                      ),

                    ],
                  ),

                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/${empFound[index].name}.jpg"),
                  ),

                ),

              ),
            );
          },

        ),
      ],
    );

  }
}

