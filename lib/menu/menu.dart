import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu2.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu3.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu1.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

Widget menu({required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(graphique.color['secondary_color_1']),
      border: Border(
        bottom: BorderSide(
            width: 1.0, color: Color(graphique.color['defaut_black'])),
      ),
    ),
    width: double.infinity,
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
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(graphique.languagefr['button_1_title'],
                    style: TextStyle(
                      color: Color(graphique.color['main_color_2']),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     showSubMenu1(context: context);
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     width: 200,
          //     decoration: BoxDecoration(color: Colors.blue),
          //     child: Padding(
          //       padding: EdgeInsets.all(12.0),
          //       child: Text('Button1',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           )),
          //     ),
          //   ),
          // ),
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
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Button2',
                    style: TextStyle(
                      color: Color(graphique.color['main_color_2']),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
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
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Button3',
                    style: TextStyle(
                      color: Color(graphique.color['main_color_2']),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
