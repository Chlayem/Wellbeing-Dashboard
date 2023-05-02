import 'package:flutter/material.dart';

import '../blocs/provider.dart';
import '../elements/employee.dart';

class Det extends StatelessWidget {
  const Det({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).employees,
      builder: (BuildContext context, AsyncSnapshot<Employee> snapshot){
        if (snapshot.hasData && snapshot.data != null){
          return Container(
            child: Text(snapshot.data!.firstName),
          );
        }else{
          return SizedBox();
        }


      },
    );
  }
}
