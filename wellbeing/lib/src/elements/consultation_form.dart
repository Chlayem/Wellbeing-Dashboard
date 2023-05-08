import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/provider.dart';
import 'consultation.dart';

class ConsultationForm extends StatelessWidget {
  DateTime date = DateTime.now();
  final _bilanController = TextEditingController();
  final _diagnosticController = TextEditingController();
  final _pronosticController = TextEditingController();
  final _resumeController = TextEditingController();


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
      decoration: BoxDecoration(boxShadow:[BoxShadow(
        color: Colors.grey,
        blurRadius: 11.0, // soften the shadow
        spreadRadius: 0.8, //extend the shadow
        offset: Offset(
          0, // Move to right 5  horizontally
          0, // Move to bottom 5 Vertically
        ),
      )],
          borderRadius: BorderRadius.circular(10),color: Color(0xffffffff),
          //border: Border.all(width:2,color: Color(0xff00559a),)
          ),

      //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    controller: _bilanController,
                    decoration: InputDecoration(
                        labelText: 'Bilan', border: InputBorder.none),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.calendar_month_outlined,color: Color(0xff2F4F4F),),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(

              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
              controller: _diagnosticController,
              decoration: InputDecoration(
                  labelText: 'Diagnostic', border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
              controller: _pronosticController,
              decoration: InputDecoration(
                  labelText: 'Pronostics', border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
              controller: _resumeController,
              decoration: InputDecoration(
                  labelText: 'Resumé', border: InputBorder.none),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Color(0xff002966);
                        }
                        return Color(0xff00559a); // default color
                      },
                    ),
                      foregroundColor: MaterialStateProperty.all<Color>(Color(0xffdcdcdc))),

                  child: Text('Add consultation',
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w500, letterSpacing: 1)),
                  onPressed: () {
                    final bilan = _bilanController.text;
                    final diag=_diagnosticController.text;
                    final pro=_pronosticController.text;
                    final res=_resumeController.text;
                    Provider.of(context).addCsl(Consultation(date: date, bilan: bilan,diag: diag,pro: pro,res: res));
                    _bilanController.clear();
                    _diagnosticController.clear();
                    _pronosticController.clear();
                    _resumeController.clear();
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
