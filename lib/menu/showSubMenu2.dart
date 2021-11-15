import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/pages/contact_page.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

showSubMenu2({required BuildContext context}) {
  return showDialog(
      barrierColor: null,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: const Alignment(-0.58, -0.04),
          child: Container(
              height: 400,
              width: 200,
              decoration: BoxDecoration(
                color: Color(graphique.color['main_color_1']),
                border: Border(
                    right: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['defaut_black'])),
                    left: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['defaut_black'])),
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['defaut_black']))),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PartenairePage()));
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
                                    FontAwesomeIcons.flag,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_2']
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
                            builder: (context) => ContactPage()));
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
                                    FontAwesomeIcons.user,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_2']
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
                  ],
                ),
              )),
        );
      });
}
