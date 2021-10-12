import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildBoolIcon({required bool check, required double sizeIcon}) {
  switch (check) {
    case true:
      {
        return Icon(
          FontAwesomeIcons.check,
          size: sizeIcon,
          color: Colors.green,
        );
      }
    case false:
      {
        return Icon(
          FontAwesomeIcons.times,
          size: sizeIcon,
          color: Colors.red,
        );
      }

    default:
      {
        return Icon(
          FontAwesomeIcons.times,
          size: sizeIcon,
          color: Colors.red,
        );
        ;
      }
  }
}
