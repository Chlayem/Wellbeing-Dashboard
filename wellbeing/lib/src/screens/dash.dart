import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:wellbeing/src/elements/consultation.dart';
import 'package:intl/intl.dart';
import '../elements/employee.dart';

class Dash extends StatelessWidget {
  final List<Employee> emp;
  Dash({required this.emp});

  Icon setColor(int? i){
    Color c=Colors.green;
    if(i==null)return Icon(Icons.circle,size: 8,);
    switch(i){
      case -1:
        c=Colors.grey;
        break;
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
        result=emp.where((e) => e.firstName!.toLowerCase().contains(entredKeyword.toLowerCase())).toList();
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
              padding: EdgeInsets.symmetric(vertical: 10.0),
              width: searchWidth,
              child: TextField(
                onChanged: (value) => runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: cardPadding),
              child: Row(
                children: const [
                  Expanded(flex:2,child: SizedBox()),
                  Expanded(flex:8,child: Text("Name")),
                  Expanded(flex:8,child: Text("Last Consultation")),
                  Expanded(flex:2,child: Text("Stress",)),
                  Expanded(flex:2,child: Text("Anxiety")),
                  Expanded(flex:2,child: Text("Fatigue")),
                ],
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
                      DateTime? cslDate ;

                      final csl = empFound[index].csl;
                      if(csl != null){
                        cslDate=csl.isNotEmpty ?csl.last.date:null;
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: cardPadding),
                        child: Card(
                          child: ListTile(
                            onTap: (){
                              Employee e =empFound[index];
                              Provider.of(context).selectEmployee(e);
                              Provider.of(context).pushCsl(e.csl??[]);
                              Provider.of(context).navigateToScreen(4);

                            },
                            title: Row(
                              children: [
                                Expanded(flex:8,child: Text('${empFound[index].firstName!} ${empFound[index].lastName!}')),
                                Expanded(flex:8,child: Text(cslDate!=null?DateFormat('yyyy-MM-dd').format(cslDate!):"       -",)),
                                Expanded(flex:2,child: setColor(empFound[index].stress.last.value)),
                                Expanded(flex:2,child: setColor(empFound[index].anxiety.last.value)),
                                Expanded(flex:2,child: setColor(empFound[index].fatigue.last.value)),

                              ],
                            ),

                            leading: CircleAvatar(
                              backgroundImage: AssetImage("assets/Kevin.jpg"),
                            ),

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
  }

}
