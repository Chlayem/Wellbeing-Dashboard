import 'package:flutter/material.dart';

import '../blocs/provider.dart';
import 'consultation.dart';


class ConsultationForm extends StatelessWidget {
  DateTime date =DateTime.now();
  final _bilanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime _showDatePicker(){
      DateTime d =DateTime.now();
      showDatePicker(context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2024)).then((value) =>d=value ?? DateTime.now());
      return d;

    }
    return Column(
      children: [
        TextButton.icon(
          icon: Icon(Icons.calendar_month_rounded),
          onPressed: (){
            date =_showDatePicker();
          },
          label: Text("Date de consultation"),
        ),

        TextField(
          controller: _bilanController,
          decoration: InputDecoration(labelText: 'Bilan'),
        ),
        ElevatedButton(
          child: Text('Add Consultation'),
          onPressed: (){
            final bilan = _bilanController.text;
            Provider.of(context).addCsl(Consultation(date: date, bilan: bilan));
            _bilanController.clear();
          },
        ),
      ],
    );
  }
}
