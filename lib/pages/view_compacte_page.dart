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
import 'package:tn09_app_web_demo/pages/math_function/check_date.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/math_function/today_color.dart';
import 'package:tn09_app_web_demo/pages/math_function/week_of_year.dart';
import 'package:tn09_app_web_demo/pages/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/view_planning_collecteur_page.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';

class PlanningWeeklyCompactePage extends StatefulWidget {
  DateTime thisDay;
  PlanningWeeklyCompactePage({
    required this.thisDay,
  });
  @override
  _PlanningWeeklyCompactePageState createState() =>
      _PlanningWeeklyCompactePageState();
}

class _PlanningWeeklyCompactePageState
    extends State<PlanningWeeklyCompactePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // for Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  Stream<QuerySnapshot> _vehiculeStream = FirebaseFirestore.instance
      .collection("Vehicule")
      .orderBy('orderVehicule')
      .snapshots();
  // for Tournee
  CollectionReference _tournee =
      FirebaseFirestore.instance.collection("Tournee");
  // for Collecteur
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  // for Etape
  CollectionReference _etape = FirebaseFirestore.instance.collection("Etape");

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
          builder: (context) => PlanningWeeklyCompactePage(
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
                                  color: Colors.red,
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
                            text: 'View Compacte',
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
              height: 6000,
              color: Colors.yellow,
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
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlanningWeeklyCompactePage(
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
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlanningWeeklyCompactePage(
                                                            thisDay: nextWeek,
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
                        1132, // 7 part, each 160, 6 space between => 7*160+2*6 = 1132
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: monday,
                                    style: TextStyle(
                                        color: today_color(
                                            check_day: firstDayOfWeek),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDailyPage(
                                                        thisDay:
                                                            firstDayOfWeek)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: tuesday,
                                    style: TextStyle(
                                        color: today_color(
                                            check_day: date_tuesday),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDailyPage(
                                                        thisDay:
                                                            date_tuesday)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: wednesday,
                                    style: TextStyle(
                                        color: today_color(
                                            check_day: date_wednesday),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDailyPage(
                                                        thisDay:
                                                            date_wednesday)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: thursday,
                                    style: TextStyle(
                                        color: today_color(
                                            check_day: date_thursday),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDailyPage(
                                                        thisDay:
                                                            date_thursday)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: friday,
                                    style: TextStyle(
                                        color:
                                            today_color(check_day: date_friday),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDailyPage(
                                                        thisDay: date_friday)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: saturday,
                                    style: TextStyle(
                                        color: today_color(
                                            check_day: date_saturday),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDailyPage(
                                                        thisDay:
                                                            date_saturday)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: sunday,
                                    style: TextStyle(
                                        color: today_color(
                                            check_day: lastDayOfWeek),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDailyPage(
                                                        thisDay:
                                                            lastDayOfWeek)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1132,
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
                            height: 1000,
                            color: Colors.green,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _tournee
                                  .where('dateTournee',
                                      isEqualTo:
                                          getDateText(date: firstDayOfWeek))
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
                                  child: Column(
                                    children: snapshot.data!.docs.map(
                                        (DocumentSnapshot
                                            document_tournee_monday) {
                                      Map<String, dynamic> tournee_monday =
                                          document_tournee_monday.data()!
                                              as Map<String, dynamic>;
                                      return Container(
                                          width: 150,
                                          height: 55 +
                                              80 *
                                                  double.parse(tournee_monday[
                                                      'nombredeEtape']),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          color: Color(int.parse(
                                              tournee_monday['colorTournee'])),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.yellow,
                                                child: Text(
                                                  'Tournee: ' +
                                                      limitString(
                                                          text: tournee_monday[
                                                              'idTournee'],
                                                          limit_long: 6),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.blue,
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _collecteur
                                                      .where('idCollecteur',
                                                          isEqualTo:
                                                              tournee_monday[
                                                                  'idCollecteur'])
                                                      .limit(1)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return Row(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document_collecteur_monday) {
                                                        Map<String, dynamic>
                                                            collecteur_monday =
                                                            document_collecteur_monday
                                                                    .data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        // print('$collecteur');
                                                        return Container(
                                                          height: 50,
                                                          width: 130,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 2),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .user,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(collecteur_monday[
                                                                  'nomCollecteur']),
                                                              SizedBox(
                                                                  width: 5),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(tournee_monday[
                                                                  'startTime']),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 80 *
                                                    double.parse(tournee_monday[
                                                        'nombredeEtape']),
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _etape
                                                      .where('idTourneeEtape',
                                                          isEqualTo:
                                                              tournee_monday[
                                                                  'idTournee'])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: snapshot
                                                            .data!.docs
                                                            .map((DocumentSnapshot
                                                                document_etape) {
                                                          Map<String, dynamic>
                                                              etape =
                                                              document_etape
                                                                      .data()!
                                                                  as Map<String,
                                                                      dynamic>;
                                                          return Container(
                                                            width: 120,
                                                            height: 80,
                                                            color: Colors.white,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(etape[
                                                                'nomAdresseEtape']),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 160,
                            height: 1000,
                            color: Colors.green,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _tournee
                                  .where('dateTournee',
                                      isEqualTo:
                                          getDateText(date: date_tuesday))
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
                                  child: Column(
                                    children: snapshot.data!.docs.map(
                                        (DocumentSnapshot
                                            document_tournee_tuesday) {
                                      Map<String, dynamic> tournee_tuesday =
                                          document_tournee_tuesday.data()!
                                              as Map<String, dynamic>;
                                      return Container(
                                          width: 150,
                                          height: 55 +
                                              80 *
                                                  double.parse(tournee_tuesday[
                                                      'nombredeEtape']),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          color: Color(int.parse(
                                              tournee_tuesday['colorTournee'])),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.yellow,
                                                child: Text(
                                                  'Tournee: ' +
                                                      limitString(
                                                          text: tournee_tuesday[
                                                              'idTournee'],
                                                          limit_long: 6),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.blue,
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _collecteur
                                                      .where('idCollecteur',
                                                          isEqualTo:
                                                              tournee_tuesday[
                                                                  'idCollecteur'])
                                                      .limit(1)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return Row(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document_collecteur_tuesday) {
                                                        Map<String, dynamic>
                                                            collecteur_tuesday =
                                                            document_collecteur_tuesday
                                                                    .data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        // print('$collecteur');
                                                        return Container(
                                                          height: 50,
                                                          width: 130,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 2),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .user,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(collecteur_tuesday[
                                                                  'nomCollecteur']),
                                                              SizedBox(
                                                                  width: 5),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(tournee_tuesday[
                                                                  'startTime']),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 80 *
                                                    double.parse(
                                                        tournee_tuesday[
                                                            'nombredeEtape']),
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _etape
                                                      .where('idTourneeEtape',
                                                          isEqualTo:
                                                              tournee_tuesday[
                                                                  'idTournee'])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: snapshot
                                                            .data!.docs
                                                            .map((DocumentSnapshot
                                                                document_etape) {
                                                          Map<String, dynamic>
                                                              etape =
                                                              document_etape
                                                                      .data()!
                                                                  as Map<String,
                                                                      dynamic>;
                                                          return Container(
                                                            width: 120,
                                                            height: 80,
                                                            color: Colors.white,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(etape[
                                                                'nomAdresseEtape']),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 160,
                            height: 1000,
                            color: Colors.green,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _tournee
                                  .where('dateTournee',
                                      isEqualTo:
                                          getDateText(date: date_wednesday))
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
                                  child: Column(
                                    children: snapshot.data!.docs.map(
                                        (DocumentSnapshot
                                            document_tournee_wednesday) {
                                      Map<String, dynamic> tournee_wednesday =
                                          document_tournee_wednesday.data()!
                                              as Map<String, dynamic>;
                                      return Container(
                                          width: 150,
                                          height: 55 +
                                              80 *
                                                  double.parse(
                                                      tournee_wednesday[
                                                          'nombredeEtape']),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          color: Color(int.parse(
                                              tournee_wednesday[
                                                  'colorTournee'])),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.yellow,
                                                child: Text(
                                                  'Tournee: ' +
                                                      limitString(
                                                          text:
                                                              tournee_wednesday[
                                                                  'idTournee'],
                                                          limit_long: 6),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.blue,
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _collecteur
                                                      .where('idCollecteur',
                                                          isEqualTo:
                                                              tournee_wednesday[
                                                                  'idCollecteur'])
                                                      .limit(1)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return Row(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document_collecteur_wednesday) {
                                                        Map<String, dynamic>
                                                            collecteur_wednesday =
                                                            document_collecteur_wednesday
                                                                    .data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        // print('$collecteur');
                                                        return Container(
                                                          height: 50,
                                                          width: 130,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 2),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .user,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(collecteur_wednesday[
                                                                  'nomCollecteur']),
                                                              SizedBox(
                                                                  width: 5),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(tournee_wednesday[
                                                                  'startTime']),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 80 *
                                                    double.parse(
                                                        tournee_wednesday[
                                                            'nombredeEtape']),
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _etape
                                                      .where('idTourneeEtape',
                                                          isEqualTo:
                                                              tournee_wednesday[
                                                                  'idTournee'])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: snapshot
                                                            .data!.docs
                                                            .map((DocumentSnapshot
                                                                document_etape) {
                                                          Map<String, dynamic>
                                                              etape =
                                                              document_etape
                                                                      .data()!
                                                                  as Map<String,
                                                                      dynamic>;
                                                          return Container(
                                                            width: 120,
                                                            height: 80,
                                                            color: Colors.white,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(etape[
                                                                'nomAdresseEtape']),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 160,
                            height: 1000,
                            color: Colors.green,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _tournee
                                  .where('dateTournee',
                                      isEqualTo:
                                          getDateText(date: date_thursday))
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
                                  child: Column(
                                    children: snapshot.data!.docs.map(
                                        (DocumentSnapshot
                                            document_tournee_thursday) {
                                      Map<String, dynamic> tournee_thursday =
                                          document_tournee_thursday.data()!
                                              as Map<String, dynamic>;
                                      return Container(
                                          width: 150,
                                          height: 55 +
                                              80 *
                                                  double.parse(tournee_thursday[
                                                      'nombredeEtape']),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          color: Color(int.parse(
                                              tournee_thursday[
                                                  'colorTournee'])),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.yellow,
                                                child: Text(
                                                  'Tournee: ' +
                                                      limitString(
                                                          text:
                                                              tournee_thursday[
                                                                  'idTournee'],
                                                          limit_long: 6),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.blue,
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _collecteur
                                                      .where('idCollecteur',
                                                          isEqualTo:
                                                              tournee_thursday[
                                                                  'idCollecteur'])
                                                      .limit(1)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return Row(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document_collecteur_thursday) {
                                                        Map<String, dynamic>
                                                            collecteur_thursday =
                                                            document_collecteur_thursday
                                                                    .data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        // print('$collecteur');
                                                        return Container(
                                                          height: 50,
                                                          width: 130,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 2),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .user,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(collecteur_thursday[
                                                                  'nomCollecteur']),
                                                              SizedBox(
                                                                  width: 5),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(tournee_thursday[
                                                                  'startTime']),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 80 *
                                                    double.parse(
                                                        tournee_thursday[
                                                            'nombredeEtape']),
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _etape
                                                      .where('idTourneeEtape',
                                                          isEqualTo:
                                                              tournee_thursday[
                                                                  'idTournee'])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: snapshot
                                                            .data!.docs
                                                            .map((DocumentSnapshot
                                                                document_etape) {
                                                          Map<String, dynamic>
                                                              etape =
                                                              document_etape
                                                                      .data()!
                                                                  as Map<String,
                                                                      dynamic>;
                                                          return Container(
                                                            width: 120,
                                                            height: 80,
                                                            color: Colors.white,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(etape[
                                                                'nomAdresseEtape']),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 160,
                            height: 1000,
                            color: Colors.green,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _tournee
                                  .where('dateTournee',
                                      isEqualTo: getDateText(date: date_friday))
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
                                  child: Column(
                                    children: snapshot.data!.docs.map(
                                        (DocumentSnapshot
                                            document_tournee_friday) {
                                      Map<String, dynamic> tournee_friday =
                                          document_tournee_friday.data()!
                                              as Map<String, dynamic>;
                                      return Container(
                                          width: 150,
                                          height: 55 +
                                              80 *
                                                  double.parse(tournee_friday[
                                                      'nombredeEtape']),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          color: Color(int.parse(
                                              tournee_friday['colorTournee'])),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.yellow,
                                                child: Text(
                                                  'Tournee: ' +
                                                      limitString(
                                                          text: tournee_friday[
                                                              'idTournee'],
                                                          limit_long: 6),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.blue,
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _collecteur
                                                      .where('idCollecteur',
                                                          isEqualTo:
                                                              tournee_friday[
                                                                  'idCollecteur'])
                                                      .limit(1)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return Row(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document_collecteur_friday) {
                                                        Map<String, dynamic>
                                                            collecteur_friday =
                                                            document_collecteur_friday
                                                                    .data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        // print('$collecteur');
                                                        return Container(
                                                          height: 50,
                                                          width: 130,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 2),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .user,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(collecteur_friday[
                                                                  'nomCollecteur']),
                                                              SizedBox(
                                                                  width: 5),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(tournee_friday[
                                                                  'startTime']),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 80 *
                                                    double.parse(tournee_friday[
                                                        'nombredeEtape']),
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _etape
                                                      .where('idTourneeEtape',
                                                          isEqualTo:
                                                              tournee_friday[
                                                                  'idTournee'])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: snapshot
                                                            .data!.docs
                                                            .map((DocumentSnapshot
                                                                document_etape) {
                                                          Map<String, dynamic>
                                                              etape =
                                                              document_etape
                                                                      .data()!
                                                                  as Map<String,
                                                                      dynamic>;
                                                          return Container(
                                                            width: 120,
                                                            height: 80,
                                                            color: Colors.white,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(etape[
                                                                'nomAdresseEtape']),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 160,
                            height: 1000,
                            color: Colors.green,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _tournee
                                  .where('dateTournee',
                                      isEqualTo:
                                          getDateText(date: date_saturday))
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
                                  child: Column(
                                    children: snapshot.data!.docs.map(
                                        (DocumentSnapshot
                                            document_tournee_saturday) {
                                      Map<String, dynamic> tournee_saturday =
                                          document_tournee_saturday.data()!
                                              as Map<String, dynamic>;
                                      return Container(
                                          width: 150,
                                          height: 55 +
                                              80 *
                                                  double.parse(tournee_saturday[
                                                      'nombredeEtape']),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          color: Color(int.parse(
                                              tournee_saturday[
                                                  'colorTournee'])),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.yellow,
                                                child: Text(
                                                  'Tournee: ' +
                                                      limitString(
                                                          text:
                                                              tournee_saturday[
                                                                  'idTournee'],
                                                          limit_long: 6),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.blue,
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _collecteur
                                                      .where('idCollecteur',
                                                          isEqualTo:
                                                              tournee_saturday[
                                                                  'idCollecteur'])
                                                      .limit(1)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return Row(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document_collecteur_saturday) {
                                                        Map<String, dynamic>
                                                            collecteur_saturday =
                                                            document_collecteur_saturday
                                                                    .data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        // print('$collecteur');
                                                        return Container(
                                                          height: 50,
                                                          width: 130,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 2),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .user,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(collecteur_saturday[
                                                                  'nomCollecteur']),
                                                              SizedBox(
                                                                  width: 5),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(tournee_saturday[
                                                                  'startTime']),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 80 *
                                                    double.parse(
                                                        tournee_saturday[
                                                            'nombredeEtape']),
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _etape
                                                      .where('idTourneeEtape',
                                                          isEqualTo:
                                                              tournee_saturday[
                                                                  'idTournee'])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: snapshot
                                                            .data!.docs
                                                            .map((DocumentSnapshot
                                                                document_etape) {
                                                          Map<String, dynamic>
                                                              etape =
                                                              document_etape
                                                                      .data()!
                                                                  as Map<String,
                                                                      dynamic>;
                                                          return Container(
                                                            width: 120,
                                                            height: 80,
                                                            color: Colors.white,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(etape[
                                                                'nomAdresseEtape']),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 160,
                            height: 1000,
                            color: Colors.green,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _tournee
                                  .where('dateTournee',
                                      isEqualTo:
                                          getDateText(date: lastDayOfWeek))
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
                                  child: Column(
                                    children: snapshot.data!.docs.map(
                                        (DocumentSnapshot
                                            document_tournee_sunday) {
                                      Map<String, dynamic> tournee_sunday =
                                          document_tournee_sunday.data()!
                                              as Map<String, dynamic>;
                                      return Container(
                                          width: 150,
                                          height: 55 +
                                              80 *
                                                  double.parse(tournee_sunday[
                                                      'nombredeEtape']),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          color: Color(int.parse(
                                              tournee_sunday['colorTournee'])),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.yellow,
                                                child: Text(
                                                  'Tournee: ' +
                                                      limitString(
                                                          text: tournee_sunday[
                                                              'idTournee'],
                                                          limit_long: 6),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 130,
                                                color: Colors.blue,
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _collecteur
                                                      .where('idCollecteur',
                                                          isEqualTo:
                                                              tournee_sunday[
                                                                  'idCollecteur'])
                                                      .limit(1)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return Row(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document_collecteur_sunday) {
                                                        Map<String, dynamic>
                                                            collecteur_sunday =
                                                            document_collecteur_sunday
                                                                    .data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        // print('$collecteur');
                                                        return Container(
                                                          height: 50,
                                                          width: 130,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 2),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .user,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(collecteur_sunday[
                                                                  'nomCollecteur']),
                                                              SizedBox(
                                                                  width: 5),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color: Colors
                                                                    .black,
                                                                size: 8,
                                                              ),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(tournee_sunday[
                                                                  'startTime']),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 80 *
                                                    double.parse(tournee_sunday[
                                                        'nombredeEtape']),
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: _etape
                                                      .where('idTourneeEtape',
                                                          isEqualTo:
                                                              tournee_sunday[
                                                                  'idTournee'])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    // print('$snapshot');
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: snapshot
                                                            .data!.docs
                                                            .map((DocumentSnapshot
                                                                document_etape) {
                                                          Map<String, dynamic>
                                                              etape =
                                                              document_etape
                                                                      .data()!
                                                                  as Map<String,
                                                                      dynamic>;
                                                          return Container(
                                                            width: 120,
                                                            height: 80,
                                                            color: Colors.white,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(etape[
                                                                'nomAdresseEtape']),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ]),
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
                onTap: () {},
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PlanningWeeklyPage(
                            thisDay:
                                // DateTime.parse('2019-10-05 15:43:03.887'),
                                widget.thisDay,
                          )));
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
                        Text('Vue Complete'),
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
