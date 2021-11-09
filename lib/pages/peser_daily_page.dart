import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'dart:async';
// import 'package:http/http.dart' as html;
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_if_a_time.dart';
import 'package:tn09_app_web_demo/pages/math_function/frequence_title.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/is_Inconnu.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/math_function/week_of_year.dart';
import 'package:tn09_app_web_demo/pages/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/view_tournee_page.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:tn09_app_web_demo/.env.dart';
import 'package:tn09_app_web_demo/pages/widget/company_position.dart'
    as company;

class PeserDailyPage extends StatefulWidget {
  DateTime thisDay;
  PeserDailyPage({required this.thisDay});
  @override
  _PeserDailyPageState createState() => _PeserDailyPageState();
}

class _PeserDailyPageState extends State<PeserDailyPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
          builder: (context) => PeserDailyPage(
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
                              text: thisDay,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Container(
              width: 1200,
              height: 3000,
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
                                                              PeserDailyPage(
                                                                thisDay:
                                                                    previousDay,
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
                                                              PeserDailyPage(
                                                                thisDay:
                                                                    nextDay,
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
                                    'Peser $thisDay ${widget.thisDay.year}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 5,
                        ),
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
}
