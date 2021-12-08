import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu2.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu3.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu1.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

Widget menu({
  required BuildContext context,
//  required String language,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(graphique.color['secondary_color_1']),
      border: Border(
        bottom: BorderSide(
            width: 1.0, color: Color(graphique.color['default_black'])),
      ),
    ),
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showSubMenu1(context: context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 10),
              alignment: Alignment.center,
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
                ),
              ),
              child: Text(
                graphique.languagefr['button_1']['title'],
                style: TextStyle(
                  color: Color(graphique.color['main_color_2']),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showSubMenu2(context: context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.center,
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
                ),
              ),
              child: Text(graphique.languagefr['button_2']['title'],
                  style: TextStyle(
                    color: Color(graphique.color['main_color_2']),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              showSubMenu3(context: context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.center,
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
                ),
              ),
              child: Text(graphique.languagefr['button_3']['title'],
                  style: TextStyle(
                    color: Color(graphique.color['main_color_2']),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
