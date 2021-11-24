import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/pages/menu3/create_tournee_page.dart';
import 'package:tn09_app_web_demo/pages/menu3/peser_daily_page.dart';
import 'package:tn09_app_web_demo/pages/menu3/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/menu3/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

showSubMenu3({required BuildContext context}) {
  return showDialog(
      barrierColor: null,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: const Alignment(-0.1, -0.04),
          child: Container(
              height: 400,
              width: 200,
              decoration: BoxDecoration(
                color: Color(graphique.color['main_color_1']),
                border: Border(
                    right: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                    left: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['default_black']))),
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
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Color(graphique.color['main_color_1']),
                          ),
                          width: 400,
                          height: 30,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.calendarAlt,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_3']
                                        ['function_1_title'],
                                    style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                    Divider(
                      thickness: 2,
                      color: Color(graphique.color['secondary_color_2']),
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
                          color: Color(graphique.color['main_color_1']),
                          width: 400,
                          height: 30,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.calendarDay,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_3']
                                        ['function_2_title'],
                                    style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                    Divider(
                      thickness: 2,
                      color: Color(graphique.color['secondary_color_2']),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateTourneePage()));
                      },
                      child: Container(
                        color: Colors.red,
                        width: 400,
                        height: 30,
                        child: Container(
                            color: Color(graphique.color['main_color_1']),
                            width: 400,
                            height: 30,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.truck,
                                      size: 15,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      graphique.languagefr['button_3']
                                          ['function_3_title'],
                                      style: TextStyle(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Color(graphique.color['secondary_color_2']),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PeserDailyPage(
                                  thisDay: DateTime.now(),
                                )));
                      },
                      child: Container(
                        color: Colors.red,
                        width: 400,
                        height: 30,
                        child: Container(
                            color: Color(graphique.color['main_color_1']),
                            width: 400,
                            height: 30,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.weight,
                                      size: 15,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      graphique.languagefr['button_3']
                                          ['function_4_title'],
                                      style: TextStyle(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Color(graphique.color['secondary_color_2']),
                    ),
                  ],
                ),
              )),
        );
      });
}
