import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';

import '../elements/employee.dart';

class Dash extends StatelessWidget {
  final List<Employee> emp;
  Dash({required this.emp});

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
    return Icon(Icons.circle,color: c,size: 8,);
  }

  List<Employee> empFound =[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void runFilter(String entredKeyword){
      List<Employee> result = [];
      if(entredKeyword.isEmpty){
        result=emp;
      }else{
        result=emp.where((e) => e.name.toLowerCase().contains(entredKeyword.toLowerCase())).toList();
      }
      Provider.of(context).pushList(result);
    }
    double searchWidth ;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardPadding= screenWidth /40;



    if (screenWidth>500) {
      searchWidth=400;
    }else{
      searchWidth=screenWidth-100;
    }
    print(emp);


    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: searchWidth,
              child: TextField(
                onChanged: (value) => runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search)
                ),
              ),
            ),
            StreamBuilder<List<Employee>>(
                stream:Provider.of(context).lists,
                builder:(BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
                  if (snapshot.hasData && snapshot.data != null){
                  empFound= snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: empFound.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: cardPadding),
                        child: Card(
                          child: ListTile(
                            onTap: (){
                              Employee e =empFound[index];
                              Provider.of(context).pushEmployee(e);
                              Provider.of(context).pushCsl(e.csl??[]);
                              Provider.of(context).navigateToScreen(4);

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

                            //leading: CircleAvatar(
                            //  backgroundImage: AssetImage("assets/${empFound[index].name}.jpg"),
                            //),

                          ),

                        ),
                      );
                    },

                  );} else {
                  return Center(
                  child: CircularProgressIndicator(),
                  );
                }}
            ) ,
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}
