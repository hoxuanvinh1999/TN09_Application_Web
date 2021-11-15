import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/pages/collecteur_page.dart';
import 'package:tn09_app_web_demo/pages/contenant_page.dart';
import 'package:tn09_app_web_demo/pages/matieres_page.dart';
import 'package:tn09_app_web_demo/pages/type_contenant_page.dart';
import 'package:tn09_app_web_demo/pages/vehicule_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

showSubMenu1({required BuildContext context}) {
  return showDialog(
      barrierColor: null,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: const Alignment(-1.045, -0.04),
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
                            builder: (context) => CollecteurPage()));
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
                                  FontAwesomeIcons.users,
                                  size: 15,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  graphique.languagefr['button_1']
                                      ['function_1_title'],
                                  style: TextStyle(
                                    color:
                                        Color(graphique.color['main_color_2']),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Color(graphique.color['secondary_color_2']),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => VehiculePage()));
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
                                    FontAwesomeIcons.truck,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_1']
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
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ContenantPage()));
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
                                    FontAwesomeIcons.boxOpen,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_1']
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
                    Divider(
                      thickness: 2,
                      indent: 30,
                      color: Color(graphique.color['secondary_color_2']),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => TypeContenantPage()));
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          color: Color(graphique.color['main_color_1']),
                          width: 380,
                          height: 30,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.cubes,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_1']
                                        ['sub_function_3_title'],
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
                            builder: (context) => MatieresPage()));
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
                                    FontAwesomeIcons.tags,
                                    size: 15,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['button_1']
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
