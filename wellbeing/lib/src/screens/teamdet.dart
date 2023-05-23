import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:wellbeing/src/elements/employee.dart';
import 'package:wellbeing/src/elements/consultation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../elements/consultation_form.dart';


class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeigth=MediaQuery.of(context).size.height;
    double screenWidth =MediaQuery.of(context).size.width;
    //var columns = screenWidth > 500 ? 2:1;
    double cardPadding;
    double buttonFontSize ;
    double nameFontSize;
    if(screenWidth<600){
      nameFontSize=16;
      buttonFontSize=12;
      cardPadding=5;

    }else{
      nameFontSize=21;
      buttonFontSize=18;
      cardPadding=screenWidth/40;

    }

    //var columns = screenWidth > 500 ? 2:1;
    //List<Widget> list =;
    //Widget colrow = screenWidth < 500.0 ? Row(children: list,) : Column(children: list,);
    //exp = csl.map((e) => e.isExpanded).toList();



    return Container(
      color: Color(0xffdcdcdc),
      child: StreamBuilder<Employee>(
          stream: Provider.of(context).employees,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null){
              Employee employee = snapshot.data! ;
              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Card(
                            elevation: 8,
                            color: Color(0xfff5f5f5),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ListTile(
                                leading:Container(
                                  height: 40,
                                  width: 40,
                                  child: Expanded(
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/${employee.firstName}.jpg"),
                                    ),
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Expanded(child: Text('${employee.firstName!} ${employee.lastName!}',style:GoogleFonts.mulish(fontWeight:FontWeight.w700,letterSpacing:1,color: Color(0xff002966),fontSize: nameFontSize))),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: TextButton.icon(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 16,vertical: 16)),
                                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                              if (states.contains(MaterialState.hovered)) {
                                                return Color(0xffbbbbbb);
                                              }
                                              return Color(0xffdcdcdc); // default color
                                            },
                                          ),
                                          foregroundColor: MaterialStateProperty.all<Color>(Color(0xff002966)),
                                        ),
                                        onPressed: (){},
                                        icon: Icon(Icons.calendar_month_rounded,size: buttonFontSize),
                                        label: Text("Fix a meet",style:GoogleFonts.mulish(fontSize:buttonFontSize,fontWeight:FontWeight.w400,letterSpacing:1)),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 8)),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: TextButton.icon(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 16,vertical: 16)),
                                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                    (Set<MaterialState> states) {
                                                  if (states.contains(MaterialState.hovered)) {
                                                    return Color(0xff002966);
                                                  }
                                                  return Color(0xff00559a); // default color
                                                },
                                              ),
                                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xffdcdcdc))
                                          ),
                                          onPressed: (){},
                                          icon: Icon(Icons.notification_add,size: buttonFontSize,),
                                          label: Text("Notify",style:GoogleFonts.mulish(fontSize:buttonFontSize,fontWeight:FontWeight.w400,letterSpacing:1))
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 600,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //crossAxisCount: columns,
                            children: [
                              Text('Info',style:GoogleFonts.mulish(fontWeight:FontWeight.w600,letterSpacing:1,fontSize:18,color: Color(0xff708090))),
                              SizedBox(height: 12.0),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xfff5f5f5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 11.0, // soften the shadow
                                      spreadRadius: 0.8, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 5  horizontally
                                        0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(flex:1,child: Text("Job",style: GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(child: Text(": ${employee.job ?? "-"}",
                                            style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Email",style: GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(child: Text(": ${employee.email ?? "-"}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Number",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(child: Text(": ${employee.num ?? "-"}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1,color: Color(0xff2F4F4F) )))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Birth date",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(child: Text(": ${employee.birthDate?.day} - ${employee.birthDate?.month} - ${employee.birthDate?.year}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1,color: Color(0xff2F4F4F) )))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Hiring date",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1,color: Color(0xff708090) ))),
                                        Expanded(child: Text(": ${employee.recDate?.day} - ${employee.recDate?.month} - ${employee.recDate?.year}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Working hours",style:GoogleFonts.mulish(fontWeight:FontWeight.w300,letterSpacing:1 ,color: Color(0xff708090)))),
                                        Expanded(child: Text(": ${employee.workHours}",style: GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 ,color: Color(0xff2F4F4F))))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text('Consultations',style:GoogleFonts.mulish(fontWeight:FontWeight.w600,letterSpacing:1,fontSize: 18,color: Color(0xff708090))),
                              Column(
                                children: [
                                  StreamBuilder<List<Consultation>>(
                                      stream: Provider.of(context).consultations,
                                      builder: (context, snap) {
                                        if (snap.hasData && snap.data != null){
                                          final List<Consultation> csl = snap.data ?? [] ;
                                          //final List<bool> expandedList = csl.map((e) => e.isExpanded).toList(); //?? List.filled(csl.length, false);
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: csl.length,
                                            itemBuilder: (context,i){
                                              return Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 1.0),
                                                child: Card(
                                                  child: ExpansionTile(
                                                    title: Row(
                                                      children: [
                                                        Expanded(child: Text("Date de consultation :",style:GoogleFonts.mulish(fontWeight:FontWeight.w200,letterSpacing:1 )),flex: 2,),
                                                        Expanded(child: Text("${csl[i].date.year}-${csl[i].date.month}-${csl[i].date.day} ",style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )))
                                                      ],
                                                    ),
                                                    onExpansionChanged: (expanded){
                                                      csl[i].isExpanded=expanded;
                                                      Provider.of(context).pushCsl(csl);
                                                    },
                                                    initiallyExpanded: csl[i].isExpanded,
                                                    children: [
                                                      ListTile(
                                                        title: Text("Bilan de consultation:",style:GoogleFonts.mulish(fontWeight:FontWeight.w100,letterSpacing:1 )),
                                                        subtitle: Text(csl[i].bilan,style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }else{
                                          return SizedBox();
                                        }
                                      }
                                  ),

                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text('Formations',style:GoogleFonts.mulish(fontWeight:FontWeight.w600,letterSpacing:1,fontSize: 18,color: Color(0xff708090))),
                              Column(
                                children: [
                                  StreamBuilder<List<Consultation>>(
                                      stream: Provider.of(context).consultations,
                                      builder: (context, snap) {
                                        if (snap.hasData && snap.data != null){
                                          final List<Consultation> csl = snap.data ?? [] ;
                                          //final List<bool> expandedList = csl.map((e) => e.isExpanded).toList(); //?? List.filled(csl.length, false);
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: csl.length,
                                            itemBuilder: (context,i){
                                              return Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 1.0),
                                                child: Card(
                                                  child: ExpansionTile(
                                                    title: Row(
                                                      children: [
                                                        Expanded(child: Text("Date de consultation :",style:GoogleFonts.mulish(fontWeight:FontWeight.w200,letterSpacing:1 )),flex: 2,),
                                                        Expanded(child: Text("${csl[i].date.year}-${csl[i].date.month}-${csl[i].date.day} ",style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )))
                                                      ],
                                                    ),
                                                    onExpansionChanged: (expanded){
                                                      csl[i].isExpanded=expanded;
                                                      Provider.of(context).pushCsl(csl);
                                                    },
                                                    initiallyExpanded: csl[i].isExpanded,
                                                    children: [
                                                      ListTile(
                                                        title: Text("Bilan de consultation:",style:GoogleFonts.mulish(fontWeight:FontWeight.w200,letterSpacing:1 )),
                                                        subtitle: Text(csl[i].bilan,style:GoogleFonts.mulish(fontWeight:FontWeight.w500,letterSpacing:1 )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }else{
                                          return SizedBox(child: Text('Noo'));
                                        }
                                      }
                                  ),

                                ],
                              )],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
              return SizedBox();
            }
          }
      ),
    );
  }
}
