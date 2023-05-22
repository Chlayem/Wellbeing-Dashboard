import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/provider.dart';
import 'package:intl/intl.dart';
import 'employee.dart';

class EmployeeForm extends StatefulWidget {
  //final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final CollectionReference employees =
  FirebaseFirestore.instance.collection('employees');

  final Employee employee;
  String formType ;
  EmployeeForm({required this.employee,required this.formType});
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> _departments = ['Marketing','Finance','Production' ];
  late String _selectedDepartment;
  late TextEditingController birthDateController;
  late TextEditingController hiringDateController;
  late TextEditingController firstNameController ;
  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    birthDateController = TextEditingController(
        text: widget.employee.birthDate == null
            ? ""
            : DateFormat('yyyy-MM-dd').format(widget.employee.birthDate!));
    hiringDateController = TextEditingController(
        text: widget.employee.recDate == null
            ? ""
            : DateFormat('yyyy-MM-dd').format(widget.employee.recDate!));
  }
  /*var birthDateController=TextEditingController(text:widget.employee.birthDate == null ?"":DateFormat('yyyy-mm-dd').format(widget.employee.birthDate!));//"${widget.employee.birthDate?.year}-${widget.employee.birthDate?.month}-${widget.employee.birthDate?.day}");
  var hiringDateController=TextEditingController(text:widget.employee.recDate == null ?"":DateFormat('yyyy-mm-dd').format(widget.employee.recDate!));
*/


  @override
  Widget build(BuildContext context) {

    return Dialog(
        child: Container(
          width: 500,
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.formType=='add'?'Ajouter un nouveau employé':'Modifier',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.employee.firstName ,
                                controller: firstNameController,
                                decoration: InputDecoration(labelText: 'First Name'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the first name';
                                  }
                                  return null;
                                },
                                onSaved: (value) => widget.employee.firstName = value,
                                // Store the value in the Employee instance.
                                //autofocus: true,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.employee.lastName,
                                decoration: InputDecoration(labelText: 'Last Name'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the last name';
                                  }
                                  return null;
                                },
                                onSaved: (value) => widget.employee.lastName = value,
                                // Store the value in the Employee instance.
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),

                        TextFormField(
                          initialValue: '${widget.employee.cin?? ""}',
                          decoration: InputDecoration(labelText: 'CIN Number'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the CIN number';
                            }
                            return null;
                          },
                          onSaved: (value) => widget.employee.cin = int.parse(value!),
                          // Store the value in the Employee instance.
                          textInputAction: TextInputAction.next,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                //initialValue: widget.employee.birthDate.toString(),
                                controller: birthDateController,
                                decoration: InputDecoration(hintText: 'YYYY-MM-DD',labelText: 'Birthdate'),//border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the birthdate';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  widget.employee.birthDate = DateTime.parse(value!);
                                },
                                keyboardType: TextInputType.datetime,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            IconButton(
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              icon: Icon(Icons.calendar_month_outlined),
                              onPressed: (){
                                setState(() {
                                  showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1930),
                                  lastDate: DateTime(2004),
                                  ).then((value) {
                                    if (value != null) {
                                        birthDateController.text =DateFormat('yyyy-MM-dd').format(value);
                                        print(birthDateController.text);
                                    }
                                  });
                                });
                              },
                              //label: Text("Date de consultation"),
                            ),
                          ],
                        ),
                        TextFormField(
                          initialValue: widget.employee.job,
                          decoration: InputDecoration(labelText: 'Job'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the job';
                            }
                            return null;
                          },
                          onSaved: (value) => widget.employee.job = value,
                          textInputAction: TextInputAction.next,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: '${widget.employee.workHours ?? ""}',
                                decoration: InputDecoration(labelText: 'Working Hours',border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the working hours';
                                  }
                                  return null;
                                },
                                onSaved: (value) => widget.employee.workHours = int.parse(value!),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                value: widget.employee.department,
                                focusColor: Colors.transparent,
                                items: _departments.map((department) => DropdownMenuItem(
                                  value: department,
                                  child: Text(department),
                                )).toList(),
                                decoration: InputDecoration(labelText: 'Department'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the department';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDepartment = value!;
                                  });
                                },
                                onSaved: (value) => widget.employee.department = value,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                //initialValue: widget.employee.recDate.toString(),
                                controller: hiringDateController,
                                decoration: InputDecoration(labelText: 'Hiring Date',hintText: 'YYYY-MM-DD'),//border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the hiring date';
                                  }
                                  return null;
                                },
                                onSaved: (value) =>
                                    widget.employee.recDate = DateTime.parse(value!),
                                // Store the value in the Employee instance.
                                keyboardType: TextInputType.datetime,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            IconButton(
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              icon: Icon(Icons.calendar_month_outlined),
                              onPressed: (){
                                setState(() {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2023),
                                  ).then((value) {
                                    if (value != null) {
                                      hiringDateController.text= DateFormat('yyyy-MM-dd').format(value);
                                    }
                                  });
                                });
                              },
                            ),

                          ],
                        ),


                        TextFormField(
                          initialValue: widget.employee.email,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the email';
                            }
                            return null;
                          },
                          onSaved: (value) => widget.employee.email = value,
                          // Store the value in the Employee instance.
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        TextFormField(
                          initialValue: '${widget.employee.num??""}',
                          decoration: InputDecoration(labelText: 'Phone Number'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the phone number';
                            }
                            return null;
                          },
                          onSaved: (value) => widget.employee.num = int.parse(value!),
                          // Store the value in the Employee instance.
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.employee.department=_selectedDepartment;
                              _formKey.currentState!.save();
                              if(widget.formType=='edit') Provider.of(context).popEmployee(widget.employee);
                              Provider.of(context).pushEmployee(widget.employee);
                              widget.employees.add(widget.employee.toMap());
                              print('Employee: ${widget.employee.toString()}');
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(widget.formType=='add'?'Ajouter employé':'Modifier'),
                        ),
                      ]),
                ))));
  }
} // Store
