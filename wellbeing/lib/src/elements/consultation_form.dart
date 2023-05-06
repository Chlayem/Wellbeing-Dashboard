import 'package:flutter/material.dart';

import '../blocs/provider.dart';
import 'consultation.dart';

class ConsultationForm extends StatelessWidget {
  DateTime date = DateTime.now();
  final _bilanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*DateTime _showDatePicker(){
      DateTime d =DateTime.now();
      showDatePicker(context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2024)).then((value) =>d=value ?? DateTime.now());
      return d;

    }*/
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  controller: _bilanController,
                  decoration: InputDecoration(
                      labelText: 'Bilan', border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: Icon(Icons.calendar_month_rounded),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2024),
                  ).then((value) {
                    if (value != null) {
                      date = value;
                    }
                  });
                },
                //label: Text("Date de consultation"),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text('Add consultation'),
                  onPressed: () {
                    final bilan = _bilanController.text;
                    Provider.of(context)
                        .addCsl(Consultation(date: date, bilan: bilan));
                    _bilanController.clear();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
