import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:wellbeing/src/elements/emlpoyee_form.dart';

import '../elements/employee.dart';

class Crud extends StatelessWidget {
  List<Employee> emp;
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
        result=emp.where((e) => e.firstName!.toLowerCase().contains(entredKeyword.toLowerCase())).toList();
      }
      Provider.of(context).pushList(result);
    }
    double searchWidth ;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardPadding= screenWidth /40;
    int crossAxisCount ;
    if(screenWidth>1300){
      crossAxisCount = 4;
    }else if(screenWidth>800){
      crossAxisCount=3;
    }else if(screenWidth >430){
      crossAxisCount = 2;
    }else{crossAxisCount =1;}



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
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: searchWidth,
                    child: Card(
                      //color: Colors.grey[100],
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        child: TextField(
                          onChanged: (value) => runFilter(value),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                              floatingLabelStyle: TextStyle(color: Colors.grey),
                              suffixIconColor: Colors.grey,

                              labelText: 'Search',

                              suffixIcon: Icon(Icons.search),

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FloatingActionButton(
                    //backgroundColor: Colors.blue[800],
                    child: const Icon(Icons.add),
                      onPressed: (){
                        showDialog(context: context, builder: (context){
                          return EmployeeForm(employee: Employee(),formType: 'add',);

                        });
                      },
                      /*style: ElevatedButton.styleFrom(
                        fixedSize: Size(50, 50),
                        shape: CircleBorder(),
                      ),*/
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            StreamBuilder<List<Employee>>(
                stream:Provider.of(context).lists,
                builder:(BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
                  if (snapshot.hasData && snapshot.data != null){
                    empFound= snapshot.data!;
                    return GridView.builder(
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisExtent: 300,
                          //childAspectRatio: 0.8,
                          crossAxisSpacing:1 ,
                          mainAxisSpacing: 1,
                        ),
                      shrinkWrap: true,
                      itemCount: empFound.length,
                      itemBuilder: (context,index){
                        return InkWell(

                          hoverColor: Colors.grey,

                          child: Card(
                            //color: Colors.transparent,
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        hoverColor:Colors.transparent,
                                        onPressed: () {
                                          showDialog(context: context, builder: (context){
                                            return EmployeeForm(employee: empFound[index],formType: 'edit',);
                                          });
                                        },
                                        icon: Icon(Icons.mode_edit_outline_outlined,size: 20.0,),
                                      ),
                                      IconButton(
                                        hoverColor:Colors.transparent,
                                        onPressed: () {showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Delete Item?'),
                                              content: Text('Are you sure you want to delete this item?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                  child: Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(true),
                                                  child: Text('Yes'),
                                                ),
                                              ],
                                            );
                                          },
                                        ).then((value) {
                                          if (value == true) {
                                            Provider.of(context).popEmployee(empFound[index]);
                                          }
                                        });
                                        },
                                        icon: const Icon(Icons.delete_outline_outlined,size: 20.0,),
                                      ),
                                    ],
                                  ),
                                  ListTile(
                                    onTap: (){
                                      Employee e =empFound[index];
                                      Provider.of(context).selectEmployee(e);
                                      Provider.of(context).pushCsl(e.csl??[]);
                                      Provider.of(context).navigateToScreen(4);
                                    },
                                    contentPadding:EdgeInsets.fromLTRB(2.0,10.0,2.0,50.0),
                                    subtitle:Text(empFound[index].job!,style:GoogleFonts.mulish()) ,
                                    title: Row(
                                      children: [
                                        Expanded(child: Text("${empFound[index].firstName} ${empFound[index].lastName}",style: TextStyle(fontFamily:'VarelaRound',fontWeight: FontWeight.bold),)),
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
                                  Expanded(
                                    child: Container(

                                      color: Colors.grey[100],
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Department :",style: GoogleFonts.mulish(color: Colors.blue[800],fontWeight:FontWeight.bold,fontSize: 12),),
                                                    SizedBox(height: 5),
                                                    Text(empFound[index].department!,style: GoogleFonts.mulish(letterSpacing:1,fontSize: 16),)
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Date hired :",style: GoogleFonts.mulish(color: Colors.blue[800],fontWeight:FontWeight.bold,fontSize: 12)),
                                                    SizedBox(height: 5),
                                                    Text("${empFound[index].recDate?.day}-${empFound[index].recDate?.month}-${empFound[index].recDate?.year}",
                                                    style: GoogleFonts.mulish(fontSize: 16),)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Expanded(child: SizedBox()),
                                          Row(
                                            children: [
                                              Expanded(child: Icon(Icons.mail_outline,size: 15,)),
                                              Expanded(flex:6,child: Text(empFound[index].email ?? "-",maxLines: 2,style: GoogleFonts.mulish(fontSize: 12) ,)),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Expanded(child: Icon(Icons.phone_outlined,size: 15,)),
                                              Expanded(flex:6,child: Text("+216 ${empFound[index].num}" ,style: GoogleFonts.mulish(fontSize: 12)))
                                            ],
                                          )


                                        ],
                                      ),
                                    ),
                                  )
                                ],
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
