import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class Indicators extends StatefulWidget {
  final String selectedYear;
  final String selectedMonth;

  Indicators({required this.selectedYear, required this.selectedMonth});

  @override
  _IndicatorsState createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> {
  final CollectionReference KPIfb =
  FirebaseFirestore.instance.collection('KPI');

  Future<Map<String, dynamic>> etatfb() async {
    var querysnapshot = await KPIfb
        .where('fiscalYear', isEqualTo: widget.selectedYear)
        .limit(1)
        .get();
    if (querysnapshot.docs.isNotEmpty) {
      return querysnapshot.docs[0].data() as Map<String, dynamic>;
    }
    return {};
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: etatfb(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<List<String>> KPI = [
              ['1', '#Incidents', snapshot.data!['incidenceMax'] ?? ''],
              [
                '2',
                '#Critical Incidents',
                snapshot.data!['criticalincidenteMAX'] ?? ''
              ],
              [
                '3',
                '#Incidents >3 DaysOfAbsence',
                snapshot.data!['daysofabsMax'] ?? ''
              ],
              ['4', 'Incidents Cost', snapshot.data!['incidenceCostMax'] ?? ''],
              ['5', 'Lost Days', snapshot.data!['lostdaysMax'] ?? ''],
            ];


            List<String> columns = [
              'ID',
              'KPI',
              'enter value',
            ];

            final bloc = Provider.of(context);

            return Container(
                color: Color(0xffdcdcdc),
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Start Month Dropdown
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: StreamBuilder<String>(
                              stream: bloc.selectedMonth,
                              builder: (context, snapshot) {
                                return DropdownButton<String>(
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      letterSpacing: 1),
                                  underline: SizedBox(),
                                  value: snapshot.data,
                                  onChanged: bloc.selectMonth,
                                  items: bloc.months
                                      .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.mulish(
                                                letterSpacing: 1,
                                                color: Colors.black),
                                          ),
                                        ),
                                  )
                                      .toList(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 20.0),
                          // Fiscal Year Dropdown
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: StreamBuilder<String>(
                              stream: bloc.selectedYear,
                              builder: (context, snapshot) {
                                return DropdownButton<String>(
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      letterSpacing: 1),
                                  underline: SizedBox(),
                                  value: snapshot.data,
                                  onChanged: bloc.selectYear,
                                  items: bloc.years
                                      .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.mulish(
                                                letterSpacing: 1),
                                          ),
                                        ),
                                  )
                                      .toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      //--------------------------------------------------------------------------

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25, bottom: 30, left: 50),
                            child: Text(
                              'Key Performance Indicators (KPI) :',
                              style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1),
                            ),
                          ),
                          // Ajuster l'espacement entre le texte et la table
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            // Ajuste la largeur de la deuxième colonne
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(1),
                          },
                          border: TableBorder.all(color: Colors.grey),
                          defaultVerticalAlignment: TableCellVerticalAlignment
                              .middle,
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Colors
                                  .grey[100]),
                              children: columns
                                  .map((column) =>
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 15, 0, 0),
                                    child: Container(
                                      height: 35,
                                      // Modifier la hauteur de la première ligne uniquement
                                      child: Text(column,
                                          style: GoogleFonts.mulish(
                                              color: Color(0xff00559a),
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                          textAlign: TextAlign.center),
                                    ),
                                  ))
                                  .toList(),
                            ),

                            // Lignes de données du tableau
                            ...KPI.map((row) {
                              int rowIndex = KPI.indexOf(row);
                              return TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: List.generate(
                                    columns.length, (colIndex) {
                                  bool isHeader = colIndex < 2;
                                  String value = row[colIndex];
                                  if (isHeader) {
                                    return Text(value,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.mulish(
                                            letterSpacing: 1));
                                  } else {
                                    return TextField(

                                      onChanged: (newValue) {
                                        KPI[rowIndex][colIndex] = newValue;
                                      },
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                }),
                              );
                            })
                          ],
                        ),
                      ),

                      //-----------------------------------------------------------------------

                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            String incidence = KPI[0][2];
                            String criticalincidente = KPI[1][2];
                            String daysofabs = KPI[2][2];
                            String incidenceCost = KPI[3][2];
                            String lostdays = KPI[4][2];
                            KPIfb.add(
                                {
                                  'incidenceMax': incidence,
                                  'criticalincidenteMAX': criticalincidente,
                                  'daysofabsMax': daysofabs,
                                  'incidenceCostMax': incidenceCost,
                                  'lostdaysMax': lostdays,
                                  'startMonth': widget.selectedMonth,
                                  'fiscalYear': widget.selectedYear,
                                }

                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: Text('Confirm',
                                style:
                                GoogleFonts.mulish(
                                    fontSize: 15, letterSpacing: 1)),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<
                                  EdgeInsetsGeometry>(EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6)),
                              backgroundColor: MaterialStateProperty
                                  .resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Color(0xff002966);
                                  }
                                  return Color(0xff00559a); // default color
                                },
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xffdcdcdc))
                          ),
                        ),
                      )
                    ])));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}