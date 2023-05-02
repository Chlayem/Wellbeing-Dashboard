import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';

import '../elements/employee.dart';

class Crud extends StatelessWidget {
  final List<Employee> emp;
  Crud({required this.emp});

  List<Employee> empFound =[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void runFilter(String entredKeyword){
      List<Employee> result = [];
      if(entredKeyword.isEmpty){
        result=emp;
      }else{
        result=emp.where((e) => e.firstName.toLowerCase().contains(entredKeyword.toLowerCase())).toList();
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
      padding: EdgeInsets.symmetric(horizontal: cardPadding,vertical: 5),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
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
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 1,
                          crossAxisSpacing:1 ,
                          mainAxisSpacing: 1,
                        ),
                      shrinkWrap: true,
                      itemCount: empFound.length,
                      itemBuilder: (context,index){
                        return Container(
                          width: 150,
                          height: 150,
                          child: Card(
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: (){
                                    Employee e =empFound[index];
                                    Provider.of(context).pushEmployee(e);
                                    Provider.of(context).pushCsl(e.csl??[]);
                                    Provider.of(context).navigateToScreen(4);

                                  },
                                  subtitle:Text(empFound[index].job) ,
                                  title: Row(
                                    children: [
                                      Expanded(child: Text("${empFound[index].firstName} ${empFound[index].lastName}")),
                                      /*Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(child: Text(empFound[index].job)),

                                              Expanded(child: Text(empFound[index].department)),

                                              //Expanded(child: setColor(empFound[index].stress)),
                                              //Expanded(child: setColor(empFound[index].anxiety)),
                                              //Expanded(child: setColor(empFound[index].fatigue))
                                            ],
                                          )
                                      ),*/

                                    ],
                                  ),

                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage("assets/Jhon.jpg"),
                                  ),

                                ),
                              ],
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
