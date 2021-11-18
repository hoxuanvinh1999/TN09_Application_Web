import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

Widget buildBoolIcon({required bool check, required double sizeIcon}) {
  switch (check) {
    case true:
      {
        return Icon(
          FontAwesomeIcons.check,
          size: sizeIcon,
          color: Color(graphique.color['default_green']),
        );
      }
    case false:
      {
        return Icon(
          FontAwesomeIcons.times,
          size: sizeIcon,
          color: Color(graphique.color['default_red']),
        );
      }

    default:
      {
        return Icon(
          FontAwesomeIcons.times,
          size: sizeIcon,
          color: Color(graphique.color['default_red']),
        );
        ;
      }
  }
}
