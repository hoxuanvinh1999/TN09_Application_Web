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
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/math_function/today_color.dart';
import 'package:tn09_app_web_demo/pages/math_function/week_of_year.dart';
import 'package:tn09_app_web_demo/pages/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';

class ViewPlanningCollecteurPage extends StatefulWidget {
  DateTime thisDay;
  ViewPlanningCollecteurPage({
    required this.thisDay,
  });
  @override
  _ViewPlanningCollecteurPageState createState() =>
      _ViewPlanningCollecteurPageState();
}

class _ViewPlanningCollecteurPageState
    extends State<ViewPlanningCollecteurPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // for Collecteur
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  Stream<QuerySnapshot> _collecteurStream = FirebaseFirestore.instance
      .collection("Collecteur")
      .orderBy('nomCollecteur')
      .snapshots();
  // for Tournee
  CollectionReference _tournee =
      FirebaseFirestore.instance.collection("Tournee");
  // for Etape
  CollectionReference _etape = FirebaseFirestore.instance.collection("Etape");
  // for Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  // for control total data
  bool show = false;
  int i = -1;
  List<int> list_nombredeEtape = [];
  List<String> list_idCollecteur = [];
  List<int> list_nombredeTournee = [];

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
          builder: (context) => ViewPlanningCollecteurPage(
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
                            text: 'View Collecteur',
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
              height: 3000,
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
                                                          ViewPlanningCollecteurPage(
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
                                                          ViewPlanningCollecteurPage(
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
                            'Collecteur',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
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
                          width: 140,
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
                          width: 140,
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
                          width: 140,
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
                                                            date_thursday)));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 140,
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
                          width: 140,
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
                            width: 140,
                            height: 50,
                            alignment: Alignment.center,
                            color: Colors.grey,
                            child: Text(
                              'Total',
                              style: TextStyle(fontSize: 15),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: 1134,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _collecteurStream,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document_collecteur) {
                            Map<String, dynamic> dataCollecteur =
                                document_collecteur.data()!
                                    as Map<String, dynamic>;
                            // print('$collecteur');
                            if (dataCollecteur['idCollecteur'] == 'null') {
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
                                            height: 500,
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.user,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  limitString(
                                                      text: dataCollecteur[
                                                              'nomCollecteur'] +
                                                          ' ' +
                                                          dataCollecteur[
                                                              'prenomCollecteur'],
                                                      limit_long: 15),
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
                                          width: 140,
                                          height: 500,
                                          color: Colors.green,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _tournee
                                                .where('idCollecteur',
                                                    isEqualTo: dataCollecteur[
                                                        'idCollecteur'])
                                                .where('dateTournee',
                                                    isEqualTo: getDateText(
                                                        date: firstDayOfWeek))
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Something went wrong');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              // print('$snapshot');
                                              i++;
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_tournee_monday) {
                                                    Map<String, dynamic>
                                                        tournee_monday =
                                                        document_tournee_monday
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return Container(
                                                        height: 150,
                                                        width: 130,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20),
                                                        color: Color(int.parse(
                                                            tournee_monday[
                                                                'colorTournee'])),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 130,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                'Tournee: ' +
                                                                    limitString(
                                                                        text: tournee_monday[
                                                                            'idTournee'],
                                                                        limit_long:
                                                                            6),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              width: 120,
                                                              color:
                                                                  Colors.white,
                                                              child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                                stream: _vehicule
                                                                    .where(
                                                                        'idVehicule',
                                                                        isEqualTo:
                                                                            tournee_monday['idVehicule'])
                                                                    .limit(1)
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
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
                                                                    child: Row(
                                                                      children: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((DocumentSnapshot
                                                                              document_vehicule_monday) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            vehicule_monday =
                                                                            document_vehicule_monday.data()!
                                                                                as Map<String, dynamic>;
                                                                        // print('$collecteur');
                                                                        return Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                120,
                                                                            color:
                                                                                Colors.white,
                                                                            child: Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                buildVehiculeIcon(icontype: vehicule_monday['typeVehicule'], iconcolor: vehicule_monday['colorIconVehicule'].toUpperCase(), sizeIcon: 10),
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                Text(
                                                                                  limitString(text: vehicule_monday['nomVehicule'] + ' ' + vehicule_monday['numeroImmatriculation'], limit_long: 10),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            ));
                                                                      }).toList(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .clock,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      tournee_monday[
                                                                          'startTime'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .flag,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      'Etape: ' +
                                                                          tournee_monday[
                                                                              'nombredeEtape'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
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
                                          width: 140,
                                          height: 500,
                                          color: Colors.green,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _tournee
                                                .where('idCollecteur',
                                                    isEqualTo: dataCollecteur[
                                                        'idCollecteur'])
                                                .where('dateTournee',
                                                    isEqualTo: getDateText(
                                                        date: date_tuesday))
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Something went wrong');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              // print('$snapshot');
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_tournee_tuesday) {
                                                    Map<String, dynamic>
                                                        tournee_tuesday =
                                                        document_tournee_tuesday
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return Container(
                                                        height: 150,
                                                        width: 130,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20),
                                                        color: Color(int.parse(
                                                            tournee_tuesday[
                                                                'colorTournee'])),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 130,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                'Tournee: ' +
                                                                    limitString(
                                                                        text: tournee_tuesday[
                                                                            'idTournee'],
                                                                        limit_long:
                                                                            6),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              width: 120,
                                                              color:
                                                                  Colors.white,
                                                              child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                                stream: _vehicule
                                                                    .where(
                                                                        'idVehicule',
                                                                        isEqualTo:
                                                                            tournee_tuesday['idVehicule'])
                                                                    .limit(1)
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
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
                                                                    child: Row(
                                                                      children: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((DocumentSnapshot
                                                                              document_vehicule_tuesday) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            vehicule_tuesday =
                                                                            document_vehicule_tuesday.data()!
                                                                                as Map<String, dynamic>;
                                                                        // print('$collecteur');
                                                                        return Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                120,
                                                                            color:
                                                                                Colors.white,
                                                                            child: Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                buildVehiculeIcon(icontype: vehicule_tuesday['typeVehicule'], iconcolor: vehicule_tuesday['colorIconVehicule'].toUpperCase(), sizeIcon: 10),
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                Text(
                                                                                  limitString(text: vehicule_tuesday['nomVehicule'] + ' ' + vehicule_tuesday['numeroImmatriculation'], limit_long: 10),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            ));
                                                                      }).toList(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .clock,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      tournee_tuesday[
                                                                          'startTime'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .flag,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      'Etape: ' +
                                                                          tournee_tuesday[
                                                                              'nombredeEtape'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
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
                                          width: 140,
                                          height: 500,
                                          color: Colors.green,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _tournee
                                                .where('idCollecteur',
                                                    isEqualTo: dataCollecteur[
                                                        'idCollecteur'])
                                                .where('dateTournee',
                                                    isEqualTo: getDateText(
                                                        date: date_wednesday))
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Something went wrong');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              // print('$snapshot');
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_tournee_wednesday) {
                                                    Map<String, dynamic>
                                                        tournee_wednesday =
                                                        document_tournee_wednesday
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return Container(
                                                        height: 150,
                                                        width: 130,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20),
                                                        color: Color(int.parse(
                                                            tournee_wednesday[
                                                                'colorTournee'])),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 130,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                'Tournee: ' +
                                                                    limitString(
                                                                        text: tournee_wednesday[
                                                                            'idTournee'],
                                                                        limit_long:
                                                                            6),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              width: 120,
                                                              color:
                                                                  Colors.white,
                                                              child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                                stream: _vehicule
                                                                    .where(
                                                                        'idVehicule',
                                                                        isEqualTo:
                                                                            tournee_wednesday['idVehicule'])
                                                                    .limit(1)
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
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
                                                                    child: Row(
                                                                      children: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((DocumentSnapshot
                                                                              document_vehicule_wednesday) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            vehicule_wednesday =
                                                                            document_vehicule_wednesday.data()!
                                                                                as Map<String, dynamic>;
                                                                        // print('$collecteur');
                                                                        return Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                120,
                                                                            color:
                                                                                Colors.white,
                                                                            child: Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                buildVehiculeIcon(icontype: vehicule_wednesday['typeVehicule'], iconcolor: vehicule_wednesday['colorIconVehicule'].toUpperCase(), sizeIcon: 10),
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                Text(
                                                                                  limitString(text: vehicule_wednesday['nomVehicule'] + ' ' + vehicule_wednesday['numeroImmatriculation'], limit_long: 10),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            ));
                                                                      }).toList(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .clock,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      tournee_wednesday[
                                                                          'startTime'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .flag,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      'Etape: ' +
                                                                          tournee_wednesday[
                                                                              'nombredeEtape'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
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
                                          width: 140,
                                          height: 500,
                                          color: Colors.green,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _tournee
                                                .where('idCollecteur',
                                                    isEqualTo: dataCollecteur[
                                                        'idCollecteur'])
                                                .where('dateTournee',
                                                    isEqualTo: getDateText(
                                                        date: date_thursday))
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Something went wrong');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              // print('$snapshot');
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_tournee_thursday) {
                                                    Map<String, dynamic>
                                                        tournee_thursday =
                                                        document_tournee_thursday
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return Container(
                                                        height: 150,
                                                        width: 130,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20),
                                                        color: Color(int.parse(
                                                            tournee_thursday[
                                                                'colorTournee'])),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 130,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                'Tournee: ' +
                                                                    limitString(
                                                                        text: tournee_thursday[
                                                                            'idTournee'],
                                                                        limit_long:
                                                                            6),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              width: 120,
                                                              color:
                                                                  Colors.white,
                                                              child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                                stream: _vehicule
                                                                    .where(
                                                                        'idVehicule',
                                                                        isEqualTo:
                                                                            tournee_thursday['idVehicule'])
                                                                    .limit(1)
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
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
                                                                    child: Row(
                                                                      children: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((DocumentSnapshot
                                                                              document_vehicule_thursday) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            vehicule_thursday =
                                                                            document_vehicule_thursday.data()!
                                                                                as Map<String, dynamic>;
                                                                        // print('$collecteur');
                                                                        return Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                120,
                                                                            color:
                                                                                Colors.white,
                                                                            child: Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                buildVehiculeIcon(icontype: vehicule_thursday['typeVehicule'], iconcolor: vehicule_thursday['colorIconVehicule'].toUpperCase(), sizeIcon: 10),
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                Text(
                                                                                  limitString(text: vehicule_thursday['nomVehicule'] + ' ' + vehicule_thursday['numeroImmatriculation'], limit_long: 10),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            ));
                                                                      }).toList(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .clock,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      tournee_thursday[
                                                                          'startTime'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .flag,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      'Etape: ' +
                                                                          tournee_thursday[
                                                                              'nombredeEtape'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
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
                                          width: 140,
                                          height: 500,
                                          color: Colors.green,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _tournee
                                                .where('idCollecteur',
                                                    isEqualTo: dataCollecteur[
                                                        'idCollecteur'])
                                                .where('dateTournee',
                                                    isEqualTo: getDateText(
                                                        date: date_friday))
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Something went wrong');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              // print('$snapshot');
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_tournee_friday) {
                                                    Map<String, dynamic>
                                                        tournee_friday =
                                                        document_tournee_friday
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return Container(
                                                        height: 150,
                                                        width: 130,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20),
                                                        color: Color(int.parse(
                                                            tournee_friday[
                                                                'colorTournee'])),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 130,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                'Tournee: ' +
                                                                    limitString(
                                                                        text: tournee_friday[
                                                                            'idTournee'],
                                                                        limit_long:
                                                                            6),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              width: 120,
                                                              color:
                                                                  Colors.white,
                                                              child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                                stream: _vehicule
                                                                    .where(
                                                                        'idVehicule',
                                                                        isEqualTo:
                                                                            tournee_friday['idVehicule'])
                                                                    .limit(1)
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
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
                                                                    child: Row(
                                                                      children: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((DocumentSnapshot
                                                                              document_vehicule_friday) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            vehicule_friday =
                                                                            document_vehicule_friday.data()!
                                                                                as Map<String, dynamic>;
                                                                        // print('$collecteur');
                                                                        return Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                120,
                                                                            color:
                                                                                Colors.white,
                                                                            child: Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                buildVehiculeIcon(icontype: vehicule_friday['typeVehicule'], iconcolor: vehicule_friday['colorIconVehicule'].toUpperCase(), sizeIcon: 10),
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                Text(
                                                                                  limitString(text: vehicule_friday['nomVehicule'] + ' ' + vehicule_friday['numeroImmatriculation'], limit_long: 10),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            ));
                                                                      }).toList(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .clock,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      tournee_friday[
                                                                          'startTime'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .flag,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      'Etape: ' +
                                                                          tournee_friday[
                                                                              'nombredeEtape'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
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
                                          width: 140,
                                          height: 500,
                                          color: Colors.green,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _tournee
                                                .where('idCollecteur',
                                                    isEqualTo: dataCollecteur[
                                                        'idCollecteur'])
                                                .where('dateTournee',
                                                    isEqualTo: getDateText(
                                                        date: date_saturday))
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Something went wrong');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              // print('$snapshot');
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_tournee_saturday) {
                                                    Map<String, dynamic>
                                                        tournee_saturday =
                                                        document_tournee_saturday
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return Container(
                                                        height: 150,
                                                        width: 130,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20),
                                                        color: Color(int.parse(
                                                            tournee_saturday[
                                                                'colorTournee'])),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 130,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                'Tournee: ' +
                                                                    limitString(
                                                                        text: tournee_saturday[
                                                                            'idTournee'],
                                                                        limit_long:
                                                                            6),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              width: 120,
                                                              color:
                                                                  Colors.white,
                                                              child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                                stream: _vehicule
                                                                    .where(
                                                                        'idVehicule',
                                                                        isEqualTo:
                                                                            tournee_saturday['idVehicule'])
                                                                    .limit(1)
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
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
                                                                    child: Row(
                                                                      children: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((DocumentSnapshot
                                                                              document_vehicule_saturday) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            vehicule_saturday =
                                                                            document_vehicule_saturday.data()!
                                                                                as Map<String, dynamic>;
                                                                        // print('$collecteur');
                                                                        return Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                120,
                                                                            color:
                                                                                Colors.white,
                                                                            child: Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                buildVehiculeIcon(icontype: vehicule_saturday['typeVehicule'], iconcolor: vehicule_saturday['colorIconVehicule'].toUpperCase(), sizeIcon: 10),
                                                                                SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                Text(
                                                                                  limitString(text: vehicule_saturday['nomVehicule'] + ' ' + vehicule_saturday['numeroImmatriculation'], limit_long: 10),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            ));
                                                                      }).toList(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .clock,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      tournee_saturday[
                                                                          'startTime'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: 20,
                                                                width: 120,
                                                                color: Colors
                                                                    .white,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .flag,
                                                                      size: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      'Etape: ' +
                                                                          tournee_saturday[
                                                                              'nombredeEtape'],
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
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
                                          width: 140,
                                          height: 500,
                                          color: Colors.green,
                                          child: FutureBuilder<String>(
                                            future: Future<String>.delayed(
                                              const Duration(seconds: 2),
                                              () async {
                                                int numberofEtape = 0;
                                                int numberofTournee = 0;
                                                await _tournee
                                                    .where('idCollecteur',
                                                        isEqualTo:
                                                            dataCollecteur[
                                                                'idCollecteur'])
                                                    .where('dateTournee',
                                                        isEqualTo: getDateText(
                                                            date:
                                                                firstDayOfWeek))
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((tournee) {
                                                    numberofTournee++;
                                                    numberofEtape += int.parse(
                                                        tournee[
                                                            'nombredeEtape']);
                                                  });
                                                });
                                                await _tournee
                                                    .where('idCollecteur',
                                                        isEqualTo:
                                                            dataCollecteur[
                                                                'idCollecteur'])
                                                    .where('dateTournee',
                                                        isEqualTo: getDateText(
                                                            date: date_tuesday))
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((tournee) {
                                                    numberofTournee++;
                                                    numberofEtape += int.parse(
                                                        tournee[
                                                            'nombredeEtape']);
                                                  });
                                                });
                                                await _tournee
                                                    .where('idCollecteur',
                                                        isEqualTo:
                                                            dataCollecteur[
                                                                'idCollecteur'])
                                                    .where('dateTournee',
                                                        isEqualTo: getDateText(
                                                            date:
                                                                date_wednesday))
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((tournee) {
                                                    numberofTournee++;
                                                    numberofEtape += int.parse(
                                                        tournee[
                                                            'nombredeEtape']);
                                                  });
                                                });
                                                await _tournee
                                                    .where('idCollecteur',
                                                        isEqualTo:
                                                            dataCollecteur[
                                                                'idCollecteur'])
                                                    .where('dateTournee',
                                                        isEqualTo: getDateText(
                                                            date:
                                                                date_thursday))
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((tournee) {
                                                    numberofTournee++;
                                                    numberofEtape += int.parse(
                                                        tournee[
                                                            'nombredeEtape']);
                                                  });
                                                });
                                                await _tournee
                                                    .where('idCollecteur',
                                                        isEqualTo:
                                                            dataCollecteur[
                                                                'idCollecteur'])
                                                    .where('dateTournee',
                                                        isEqualTo: getDateText(
                                                            date: date_friday))
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((tournee) {
                                                    numberofTournee++;
                                                    numberofEtape += int.parse(
                                                        tournee[
                                                            'nombredeEtape']);
                                                  });
                                                });
                                                await _tournee
                                                    .where('idCollecteur',
                                                        isEqualTo:
                                                            dataCollecteur[
                                                                'idCollecteur'])
                                                    .where('dateTournee',
                                                        isEqualTo: getDateText(
                                                            date:
                                                                date_saturday))
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((tournee) {
                                                    numberofTournee++;
                                                    numberofEtape += int.parse(
                                                        tournee[
                                                            'nombredeEtape']);
                                                  });
                                                });
                                                return 'Etape: ${numberofEtape.toString()} || Tournee: ${numberofTournee.toString()}';
                                              },
                                            ), // a previously-obtained Future<String> or null
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              List<Widget> children;
                                              if (snapshot.hasData) {
                                                children = <Widget>[
                                                  const Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.green,
                                                    size: 60,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 16),
                                                    child: Text(
                                                        '${snapshot.data}'),
                                                  )
                                                ];
                                              } else if (snapshot.hasError) {
                                                children = <Widget>[
                                                  const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.red,
                                                    size: 60,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 16),
                                                    child: Text(
                                                        'Error: ${snapshot.error}'),
                                                  )
                                                ];
                                              } else {
                                                children = const <Widget>[
                                                  SizedBox(
                                                    child:
                                                        CircularProgressIndicator(),
                                                    width: 60,
                                                    height: 60,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16),
                                                    child: Text(
                                                        'Awaiting result...'),
                                                  )
                                                ];
                                              }
                                              return Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: children,
                                                ),
                                              );
                                            },
                                          ),
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
                  //         builder: (context) => ViewPlanningCollecteurPage(
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
                  //         builder: (context) => ViewPlanningCollecteurPage(
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
                  //         builder: (context) => ViewPlanningCollecteurPage(
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
