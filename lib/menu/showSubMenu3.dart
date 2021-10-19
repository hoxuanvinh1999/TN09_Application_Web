import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/pages/collecteur_page.dart';
import 'package:tn09_app_web_demo/pages/contact_page.dart';
import 'package:tn09_app_web_demo/pages/create_tournee_page.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';

showSubMenu3({required BuildContext context}) {
  return showDialog(
      barrierColor: null,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment(-0.15, -0.04),
          child: Container(
              height: 400,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PlanningWeeklyPage(
                                  thisDay:
                                      // DateTime.parse('2019-10-05 15:43:03.887'),
                                      DateTime.now(),
                                )));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 0),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Planning Weekly'),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PlanningDailyPage(
                                  thisDay:
                                      // DateTime.parse('2019-10-05 15:43:03.887'),
                                      DateTime.now(),
                                )));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 0),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Planning Daily'),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateTourneePage()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 0),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Create Tournee'),
                          )),
                    ),
                  ],
                ),
              )),
        );
      });
}
