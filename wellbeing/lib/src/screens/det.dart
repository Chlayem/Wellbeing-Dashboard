import 'package:flutter/material.dart';
import 'package:wellbeing/src/blocs/eprovider.dart';

import '../elements/employee.dart';

class Det extends StatelessWidget {
  const Det({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: EProvider.of(context).currentScreen,
      builder: (BuildContext context, AsyncSnapshot<Employee> snapshot){
        if (snapshot.hasData && snapshot.data != null){
          return Container(
            child: Text(snapshot.data!.name),
          );
        }else{
          return SizedBox();
        }


      },
    );
  }
}
