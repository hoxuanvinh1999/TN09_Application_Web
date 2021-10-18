import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/pages/collecteur_page.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'dart:async';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu1.dart';
import 'package:tn09_app_web_demo/pages/math_function/week_of_year.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';

class PlanningWeeklyPage extends StatefulWidget {
  DateTime thisDay;
  PlanningWeeklyPage({
    required this.thisDay,
  });
  @override
  _PlanningWeeklyPageState createState() => _PlanningWeeklyPageState();
}

class _PlanningWeeklyPageState extends State<PlanningWeeklyPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // for Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  Stream<QuerySnapshot> _vehiculeStream = FirebaseFirestore.instance
      .collection("Vehicule")
      .orderBy('orderVehicule')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    //For set up Date
    int currentDay = widget.thisDay.weekday;
    DateTime firstDayOfWeek =
        widget.thisDay.subtract(Duration(days: currentDay - 1)); //aka Monday
    DateTime date_tuesday =
        widget.thisDay.subtract(Duration(days: currentDay - 2));
    DateTime date_wednesday =
        widget.thisDay.subtract(Duration(days: currentDay - 3));
    DateTime date_thursday =
        widget.thisDay.subtract(Duration(days: currentDay - 4));
    DateTime date_friday =
        widget.thisDay.subtract(Duration(days: currentDay - 5));
    DateTime date_saturday =
        widget.thisDay.subtract(Duration(days: currentDay - 6));
    DateTime lastDayOfWeek =
        widget.thisDay.subtract(Duration(days: currentDay - 7)); //aka Sunday
    DateTime nextWeek = widget.thisDay.subtract(Duration(days: currentDay - 8));
    DateTime previousWeek =
        widget.thisDay.subtract(Duration(days: currentDay + 1));
    int weeknumber = weekNumber(widget.thisDay);
    String monday = DateFormat('EEEE, d MMM').format(firstDayOfWeek);
    String tuesday = DateFormat('EEEE, d MMM').format(date_tuesday);
    String wednesday = DateFormat('EEEE, d MMM').format(date_wednesday);
    String thursday = DateFormat('EEEE, d MMM').format(date_thursday);
    String friday = DateFormat('EEEE, d MMM').format(date_friday);
    String saturday = DateFormat('EEEE, d MMM').format(date_saturday);
    String sunday = DateFormat('EEEE, d MMM').format(lastDayOfWeek);
    print('widget.thisDay: ${widget.thisDay}');
    print('currentday: $currentDay');
    print('firsDayOfWeek: $firstDayOfWeek');
    print('lastDayOfWeek: $lastDayOfWeek');
    print('weeknumber: $weeknumber');
    print('Monday: $monday');
    print('Tuesday: $tuesday');
    print('Wednesday: $wednesday');
    print('Thursday: $thursday');
    print('Friday: $friday');
    print('Saturday: $saturday');
    print('Sunday: $sunday');
    print('NextWeek: $nextWeek');
    print('PreviousWeek: $previousWeek');

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
          builder: (context) => PlanningWeeklyPage(
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
                color: Colors.yellow,
                width: double.infinity,
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      FontAwesomeIcons.home,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Home',
                              style: TextStyle(
                                  color: Colors.red,
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
                                color: Colors.grey,
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
              height: 1000,
              color: Colors.green,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
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
                                    color: Colors.yellow,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlanningWeeklyPage(
                                                                thisDay:
                                                                    previousWeek,
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
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlanningWeeklyPage(
                                                                thisDay:
                                                                    nextWeek,
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
                                    'Semaine #$weeknumber: Planning du ${firstDayOfWeek.day}/${firstDayOfWeek.month} au ${lastDayOfWeek.day}/${lastDayOfWeek.month}',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 20, bottom: 20),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'New Rendez-Vous',
                                              style: TextStyle(
                                                color: Colors.black,
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
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 20, bottom: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          showActionSubMenu(context: context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons
                                                  .chevronCircleRight,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Action',
                                              style: TextStyle(
                                                color: Colors.black,
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
                        SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          thickness: 5,
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width:
                        1134, // 8 part, each 140, 7 space between => 8*140+2*7 = 1134
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            'Vehicule',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            monday,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            tuesday,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            wednesday,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            thursday,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            friday,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            saturday,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            sunday,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1134,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _vehiculeStream,
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
                        return Column(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document_vehicule) {
                            Map<String, dynamic> dataVehicule =
                                document_vehicule.data()!
                                    as Map<String, dynamic>;
                            // print('$collecteur');
                            if (dataVehicule['orderVehicule'] == '0') {
                              return SizedBox.shrink();
                            }
                            return Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            width: 140,
                                            height: 50,
                                            color: Color(int.parse(dataVehicule[
                                                'colorIconVehicule'])),
                                            child: Row(
                                              children: [
                                                buildVehiculeIcon(
                                                    icontype: dataVehicule[
                                                        'typeVehicule'],
                                                    iconcolor: '0xff000000',
                                                    sizeIcon: 17.0),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  dataVehicule['nomVehicule'] +
                                                      dataVehicule[
                                                          'numeroImmatriculation'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Container(
                                          alignment: Alignment(-1, 0.15),
                                          width: 140,
                                          height: 50,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(
                                      thickness: 5,
                                    ),
                                  ],
                                ));
                          }).toList(),
                        );
                      },
                    ),
                  )
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
                  //         builder: (context) => PlanningWeeklyPage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.print,
                          size: 12,
                        ),
                        SizedBox(width: 10),
                        Text('Imprimer'),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => PlanningWeeklyPage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.cropAlt,
                          size: 12,
                        ),
                        SizedBox(width: 10),
                        Text('Vue Compacte'),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => PlanningWeeklyPage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.userClock,
                          size: 12,
                        ),
                        SizedBox(width: 10),
                        Text('Vue Collecteur'),
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
