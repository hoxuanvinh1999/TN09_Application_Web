import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'dart:async';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:tn09_app_web_demo/pages/math_function/week_of_year.dart';
import 'package:tn09_app_web_demo/pages/planning_daily_vehicule_page.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class PlanningDailyPage extends StatefulWidget {
  DateTime thisDay;
  PlanningDailyPage({
    required this.thisDay,
  });
  @override
  _PlanningDailyPageState createState() => _PlanningDailyPageState();
}

class _PlanningDailyPageState extends State<PlanningDailyPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // For Tournee
  CollectionReference _tournee =
      FirebaseFirestore.instance.collection("Tournee");
  // for Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  Stream<QuerySnapshot> _vehiculeStream = FirebaseFirestore.instance
      .collection("Vehicule")
      .orderBy('orderVehicule')
      .snapshots();
  //For Collecteur
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  //clear data
  void clearCreatingTournee() async {
    await _tournee
        .where('isCreating', isEqualTo: 'true')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((tournee_data) {
        _tournee.doc(tournee_data['idTournee']).delete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    clearCreatingTournee();
    //For set up Date
    int currentDay = widget.thisDay.weekday;
    DateTime nextDay = widget.thisDay.add(new Duration(days: 1));
    DateTime previousDay = widget.thisDay.subtract(Duration(days: 1));
    int weeknumber = weekNumber(widget.thisDay);
    String thisDay = DateFormat('EEEE, d MMM').format(widget.thisDay);
    print('widget.thisDay: ${widget.thisDay}');
    print('currentday: $currentDay');
    print('weeknumber: $weeknumber');
    print('thisDay: $thisDay');
    print('nextDay: $nextDay');
    print('previousDay: $previousDay');

    //Pick Date Widget
    Future pickDate(BuildContext context) async {
      final initialDate = widget.thisDay;
      final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 25),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (newDate == null) return;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PlanningDailyPage(
                thisDay: newDate,
              )));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context: context),
            menu(context: context),
            Container(
                decoration: BoxDecoration(
                  color: Color(graphique.color['default_yellow']),
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                ),
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      FontAwesomeIcons.home,
                      size: 12,
                      color: Color(graphique.color['default_black']),
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Home',
                              style: TextStyle(
                                  color: Color(graphique.color['default_red']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Semaine #$weeknumber',
                              style: TextStyle(
                                  color: Color(graphique.color['default_red']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlanningWeeklyPage(
                                                thisDay: widget.thisDay,
                                              )));
                                }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: thisDay,
                            style: TextStyle(
                                color: Color(graphique.color['default_grey']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Container(
              width: 1200,
              height: 3000,
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 600,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                color: Color(graphique.color['default_yellow']),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlanningDailyPage(
                                                        thisDay: previousDay,
                                                      )));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.stepBackward,
                                          size: 15,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          pickDate(context);
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlanningDailyPage(
                                                        thisDay: nextDay,
                                                      )));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.stepForward,
                                          size: 15,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Planning of $thisDay ${widget.thisDay.year}',
                                style: TextStyle(
                                  color: Color(graphique.color['main_color_2']),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 500,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          graphique.color['default_yellow']),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Color(
                                              graphique.color['default_black']),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'New Rendez-Vous',
                                          style: TextStyle(
                                            color: Color(graphique
                                                .color['default_black']),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          graphique.color['default_yellow']),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      showActionSubMenu(context: context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.chevronCircleRight,
                                          color: Color(
                                              graphique.color['default_black']),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Action',
                                          style: TextStyle(
                                            color: Color(graphique
                                                .color['default_black']),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1190,
                    height: 1000,
                    color: Color(graphique.color['default_yellow']),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 200,
                          height: 800,
                          color: Color(graphique.color['default_red']),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          width: 900,
                          height: 800,
                          color: Color(graphique.color['default_red']),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 900,
                                  color:
                                      Color(graphique.color['default_green']),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: _vehicule
                                        .where('idVehicule',
                                            isNotEqualTo: 'null')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      // print('$snapshot');
                                      return SingleChildScrollView(
                                        child: Row(
                                          children: snapshot.data!.docs.map(
                                              (DocumentSnapshot
                                                  document_vehicule) {
                                            Map<String, dynamic> vehicule =
                                                document_vehicule.data()!
                                                    as Map<String, dynamic>;
                                            // print('$collecteur');
                                            return Expanded(
                                                child: Container(
                                                    width: 150,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_white']),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5, bottom: 5),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PlanningDailyVehiculePage(
                                                                              thisDay: widget.thisDay,
                                                                              dataVehicule: vehicule,
                                                                            )));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          buildVehiculeIcon(
                                                              icontype: vehicule[
                                                                  'typeVehicule'],
                                                              iconcolor: vehicule[
                                                                      'colorIconVehicule']
                                                                  .toUpperCase(),
                                                              sizeIcon: 15.0),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            vehicule[
                                                                'nomVehicule'],
                                                            style: TextStyle(
                                                              color: Color(graphique
                                                                      .color[
                                                                  'default_black']),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: SizedBox(
                                                                child:
                                                                    Container(
                                                                  width: 2,
                                                                  height: 50,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )));
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showActionSubMenu({required BuildContext context}) {
    return showDialog(
        barrierColor: null,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            alignment: Alignment(1, -0.10),
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => PlanningDailyPage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Color(graphique.color['default_red']),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.print,
                          size: 12,
                          color: Color(graphique.color['default_black']),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Imprimer',
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
                          ),
                        ),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => PlanningDailyPage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Color(graphique.color['default_red']),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.cropAlt,
                          size: 12,
                          color: Color(graphique.color['default_black']),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Vue Compacte',
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
                          ),
                        ),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => PlanningDailyPage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Color(graphique.color['default_red']),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.userClock,
                          size: 12,
                          color: Color(graphique.color['default_black']),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Vue Collecteur',
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
