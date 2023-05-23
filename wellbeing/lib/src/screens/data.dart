import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';
//import 'fetch_data.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context);

    return StreamBuilder<String>(
      stream: bloc.selectedYear,
      builder: (context, yearSnapshot) {
        return StreamBuilder<String>(
          stream: bloc.selectedMonth,
          builder: (context, monthSnapshot) {
            if (!yearSnapshot.hasData || !monthSnapshot.hasData) {
              return CircularProgressIndicator(); // Afficher un indicateur de chargement si les données ne sont pas encore disponibles
            }

            String selectedYear = yearSnapshot.data!;
            String selectedMonth = monthSnapshot.data!;

            // Récupérer les données de Firebase en fonction de l'année et du mois sélectionnés
            // Vous pouvez utiliser la méthode .where() pour filtrer les données en fonction de l'année et du mois
            // Exemple :
            // Query firebaseQuery = yourFirebaseRef.where('year', isEqualTo: selectedYear).where('month', isEqualTo: selectedMonth);

            // Récupérer les données et remplir les tableaux
            // ...
            //fetchData(selectedYear, selectedMonth);

            // Retourner un widget avec les tableaux remplis
            return Data(
                selectedYear: selectedYear, selectedMonth: selectedMonth);
          },
        );
      },
    );
  }
}

class Data extends StatelessWidget {
  final String selectedYear;
  final String selectedMonth;

  Data({required this.selectedYear, required this.selectedMonth});

  // Initialisez une référence à la base de données Firebase

  final CollectionReference Incidentfb =
  FirebaseFirestore.instance.collection('Incident');

  final CollectionReference severityfb =
  FirebaseFirestore.instance.collection('severity');

  final CollectionReference Typeofincidentdatafb =
  FirebaseFirestore.instance.collection('Typeofincidentdata');

  final CollectionReference  InjuryConsequencedatafb =
  FirebaseFirestore.instance.collection('InjuryConsequencedata');

  final CollectionReference  smalltablefb =
  FirebaseFirestore.instance.collection('smalltable');







  //------------------------------------------------

  Widget build(BuildContext context) {
    String numberofdays ='' ;
    String lastIncidence='';

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    // tableau avec les colonnes nécessaires
    List<String> columns = [
      'ID',
      'Indicator Name',
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',

      'Total',
      'Selected Month Data',
      'Change over last month',
    ];

    //  les données de la première colonne (ID) et de la deuxième colonne (Indicator Name)
    List<List<String>> Incidentdata = [


      [
        '1',
        '#Incidents',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '2',
        '#Critical Incidents',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '3',
        '#Incidents >3 DaysOfAbsence',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '4',
        'Incidents Cost',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
    ];

    List<List<String>> Severitydata = [
      [
        '5',
        'Low',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '6',
        'Medium',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '7',
        'High',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '8',
        'Critical',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '-',
        'Total',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],

    ];

    List<List<String>> Typeofincidentdata = [
      [
        '9',
        'Injury',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '10',
        'Illness',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '11',
        'Psychological',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '12',
        'Harassment',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '13',
        'Other',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '-',
        'Total',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],

    ];

    List<List<String>> InjuryConsequencedata = [
      [
        '14',
        'Lost Time',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '15',
        'Medical Case',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '16',
        'First Aid',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '17',
        'No Treatment',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '18',
        'Lost Days',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],
      [
        '-',
        'Total',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
      ],

    ];

    return Container(
      color: Color(0xffdcdcdc),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Table(
                      columnWidths: {
                        0: FixedColumnWidth(150.0),
                        1: FixedColumnWidth(150.0),
                      },
                      border: TableBorder.all(color: Colors.grey),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          children: [
                            Text('Date of last incident',
                                style: GoogleFonts.mulish(
                                    color: Color(0xff00559a),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                                textAlign: TextAlign.center),
                            Text('Number of days',
                                style: GoogleFonts.mulish(
                                    color: Color(0xff00559a),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        TableRow(
                          decoration: BoxDecoration(color: Colors.white),

                          children: [
                            TextField(
                              textAlign: TextAlign.center,
                              onChanged: (newValue) {
                                lastIncidence = newValue ;
                              },
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              onChanged: (newValue) {
                                numberofdays = newValue ;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          '1. Incident:',
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

                  Table(
                    columnWidths: {
                      1: FlexColumnWidth(3),
                      15: FlexColumnWidth(2.5),
                      16: FlexColumnWidth(2.5),
                      // Ajuste la largeur de la deuxième colonne
                    },
                    border: TableBorder.all(color: Colors.grey),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      // En-tête du tableau
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        children: columns
                            .map((column) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Container(
                            height: 35,
                            // Modifier la hauteur de la première ligne uniquement
                            child: Text(column,
                                style: GoogleFonts.mulish(
                                  color: Color(0xff00559a),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ))
                            .toList(),
                      ),
                      // Lignes de données du tableau
                      ...Incidentdata.map((row) {
                        int rowIndex = Incidentdata.indexOf(row);
                        return TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: List.generate(columns.length, (colIndex) {
                            bool isHeader = colIndex < 2;
                            String value = row[colIndex];

                            if (isHeader) {
                              return Text(value, textAlign: TextAlign.center,style: GoogleFonts.mulish(letterSpacing: 1),);
                            } else {
                              return TextField(
                                onChanged: (newValue) {
                                  Incidentdata[rowIndex][colIndex]= newValue;

                                },
                                textAlign: TextAlign.center,
                              );
                            }
                          }),
                        );
                      }).toList(),
                    ],
                  ),
                  //---------------------------------------Table severity:---------------------------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          '2. Severity:',
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

                  Table(
                    columnWidths: {
                      1: FlexColumnWidth(3),
                      15: FlexColumnWidth(2.5),
                      16: FlexColumnWidth(2.5),
                      // Ajuste la largeur de la deuxième colonne
                    },
                    border: TableBorder.all(color: Colors.grey),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      // En-tête du tableau
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        children: columns
                            .map((column) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Container(
                            height: 35,
                            // Modifier la hauteur de la première ligne uniquement
                            child: Text(column,
                                style: GoogleFonts.mulish(
                                  color: Color(0xff00559a),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ))
                            .toList(),
                      ),
                      // Lignes de données du tableau
                      ...Severitydata.map((row) {
                        int rowIndex = Severitydata.indexOf(row);
                        return TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: List.generate(columns.length, (colIndex) {
                            bool isHeader = colIndex < 2;
                            String value = row[colIndex];

                            if (isHeader) {
                              return Text(value, textAlign: TextAlign.center,style: GoogleFonts.mulish(letterSpacing: 1));
                            } else {
                              return TextField(
                                onChanged: (newValue) {
                                  Severitydata[rowIndex][colIndex]= newValue;
                                },
                                textAlign: TextAlign.center,
                              );
                            }
                          }),
                        );
                      }).toList(),
                    ],
                  ),

                  //---------------------------------------------type of incident-----------------------------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          '3. Type of incident:',
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

                  Table(
                    columnWidths: {
                      1: FlexColumnWidth(3),
                      15: FlexColumnWidth(2.2),
                      16: FlexColumnWidth(2.5),
                      // Ajuste la largeur de la deuxième colonne
                    },
                    border: TableBorder.all(color: Colors.grey),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      // En-tête du tableau
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        children: columns
                            .map((column) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Container(
                            height: 35,
                            // Modifier la hauteur de la première ligne uniquement
                            child: Text(column,
                                style: GoogleFonts.mulish(
                                  color: Color(0xff00559a),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ))
                            .toList(),
                      ),
                      // Lignes de données du tableau
                      ...Typeofincidentdata.map((row) {
                        int rowIndex = Typeofincidentdata.indexOf(row);
                        return TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: List.generate(columns.length, (colIndex) {
                            bool isHeader = colIndex < 2;
                            String value = row[colIndex];

                            if (isHeader) {
                              return Text(value, textAlign: TextAlign.center,style: GoogleFonts.mulish(letterSpacing: 1));
                            } else {
                              return TextField(
                                onChanged: (newValue) {
                                  Typeofincidentdata[rowIndex][colIndex]= newValue;
                                },
                                textAlign: TextAlign.center,
                              );
                            }
                          }),
                        );
                      }).toList(),
                    ],
                  ),

                  //---------------------------------Injury consequence---------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          '4.Injury Consequence:',
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

                  Table(
                    columnWidths: {
                      1: FlexColumnWidth(3),
                      15: FlexColumnWidth(2.2),
                      16: FlexColumnWidth(2.5),
                      // Ajuste la largeur de la deuxième colonne
                    },
                    border: TableBorder.all(color: Colors.grey),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      // En-tête du tableau
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        children: columns
                            .map((column) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Container(
                            height: 35,
                            // Modifier la hauteur de la première ligne uniquement
                            child: Text(column,
                                style: GoogleFonts.mulish(
                                  color: Color(0xff00559a),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ))
                            .toList(),
                      ),
                      // Lignes de données du tableau
                      ...InjuryConsequencedata.map((row) {
                        int rowIndex = InjuryConsequencedata.indexOf(row);
                        return TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: List.generate(columns.length, (colIndex) {
                            bool isHeader = colIndex < 2;
                            String value = row[colIndex];

                            if (isHeader) {
                              return Text(value, textAlign: TextAlign.center,style: GoogleFonts.mulish(letterSpacing: 1));
                            } else {
                              return TextField(
                                onChanged: (newValue) {
                                  InjuryConsequencedata[rowIndex][colIndex]= newValue;
                                },
                                textAlign: TextAlign.center,
                              );
                            }
                          }),
                        );
                      }).toList(),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        for(int i= 0 ; i<=3 ; i++){
                          for(int j=2 ; j<14 ; j++){
                            if (i==0){
                              Incidentfb.add({
                                'indicatorName' : 'incident' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Incidentdata[i][j] });

                            }else if (i==1){
                              Incidentfb.add({
                                'indicatorName' : 'criticalIncident' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Incidentdata[i][j] });

                            }else if (i==2){
                              Incidentfb.add({
                                'indicatorName' : 'daysofabsence' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Incidentdata[i][j] });
                            }else {
                              Incidentfb.add({
                                'indicatorName' : 'incidentCost' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Incidentdata[i][j] });
                            }
                          }
                        }
                        for(int i= 0 ; i<=4; i++){
                          for(int j=2 ; j<14 ; j++){
                            if (i==0){
                              severityfb.add({
                                'indicatorName' : 'Low' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Severitydata[i][j] });

                            }else if (i==1){
                              severityfb.add({
                                'indicatorName' : 'Medium' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Severitydata[i][j] });

                            }else if (i==2){
                              severityfb.add({
                                'indicatorName' : 'High' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Severitydata[i][j] });
                            }else if(i==3) {
                              severityfb.add({
                                'indicatorName' : 'critical' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Severitydata[i][j] });
                            }else {
                              severityfb.add({
                                'indicatorName' : 'Total' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Severitydata[i][j] });
                            }


                          }
                        }
                        for(int i= 0 ; i<=5; i++){
                          for(int j=2 ; j<14 ; j++){
                            if (i==0){
                              Typeofincidentdatafb.add({
                                'indicatorName' : 'Injury' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Typeofincidentdata[i][j] });

                            }else if (i==1){
                              Typeofincidentdatafb.add({
                                'indicatorName' : 'IILness' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Typeofincidentdata[i][j] });

                            }else if (i==2){
                              Typeofincidentdatafb.add({
                                'indicatorName' : 'Psychological' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Typeofincidentdata[i][j] });
                            }else if(i==3) {
                              Typeofincidentdatafb.add({
                                'indicatorName' : 'Harrasment' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Typeofincidentdata[i][j] });
                            }else if(i==4) {
                              Typeofincidentdatafb.add({
                                'indicatorName' : 'Other' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Typeofincidentdata[i][j] });
                            }

                            else {
                              Typeofincidentdatafb.add({
                                'indicatorName' : 'Total' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : Typeofincidentdata[i][j] });
                            }


                          }
                        }

                        for(int i= 0 ; i<=5; i++){
                          for(int j=2 ; j<14 ; j++){
                            if (i==0){
                              InjuryConsequencedatafb.add({
                                'indicatorName' : 'LostTime' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : InjuryConsequencedata[i][j] });

                            }else if (i==1){
                              InjuryConsequencedatafb.add({
                                'indicatorName' : 'MedicalCase' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : InjuryConsequencedata[i][j] });

                            }else if (i==2){
                              InjuryConsequencedatafb.add({
                                'indicatorName' : 'FirstAid' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : InjuryConsequencedata[i][j] });
                            }else if(i==3) {
                              InjuryConsequencedatafb.add({
                                'indicatorName' : 'NoTreatment' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : InjuryConsequencedata[i][j] });
                            }else if(i==4) {
                              InjuryConsequencedatafb.add({
                                'indicatorName' : 'LostDays' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : InjuryConsequencedata[i][j] });
                            }

                            else {
                              InjuryConsequencedatafb.add({
                                'indicatorName' : 'Total' ,
                                'fiscalYear' : selectedYear ,
                                'month' : columns[j],
                                'valeur' : InjuryConsequencedata[i][j] });
                            }


                          }
                        }
                        smalltablefb.add({
                          'dateoflastIncidence': lastIncidence ,
                          'numberofdays' :numberofdays ,
                        }) ;
                      },


                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Text(' Save',
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
