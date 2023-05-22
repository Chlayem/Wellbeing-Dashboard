import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellbeing/src/elements/employee.dart';


class Data extends StatelessWidget {
  final CollectionReference employees =
  FirebaseFirestore.instance.collection('employees');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: employees.snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context,int index){
              final Employee employee=Employee.fromSnapshot(snapshot.data!.docs[index]);
              return ListTile(
                title: Text(employee.firstName??''),
                subtitle: Text(employee.lastName??''),
              );
            }
        );
      },

    );
  }
}