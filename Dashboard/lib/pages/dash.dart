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
    Employee("Jhon","Marketing",1,2,0),
    Employee("Kevin", "IT", 0, 0, 1),
    Employee("Emma", "Marketing", 1, 0, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: emp.length,
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 40.0),
            child: Card(
              child: ListTile(
                onTap: (){},
                title: Row(
                  children: [
                    Expanded(child: Text(emp[index].name)),
                    Expanded(
                        child: Row(
                          children: [
                            Expanded(flex:6,child: Text(emp[index].department)),
                            Expanded(child: setColor(emp[index].stress)),
                            Expanded(child: setColor(emp[index].anxiety)),
                            Expanded(child: setColor(emp[index].fatigue))
                          ],
                        )
                    ),

                  ],
                ),

                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/"+emp[index].name+".jpg"),
                ),

              ),

            ),
          );
        },

      )
    );
  }
}

