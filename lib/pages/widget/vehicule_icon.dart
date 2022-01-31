import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildVehiculeIcon(
    {required String icontype,
    required String iconcolor,
    required double sizeIcon}) {
  switch (icontype) {
    case 'camion':
      {
        return Icon(
          FontAwesomeIcons.truck,
          size: sizeIcon,
          color: Color(int.parse(iconcolor)),
        );
      }
    case 'velo':
      {
        return Icon(
          FontAwesomeIcons.bicycle,
          size: sizeIcon,
          color: Color(int.parse(iconcolor)),
        );
      }
    case 'voiture':
      {
        return Icon(
          FontAwesomeIcons.car,
          size: sizeIcon,
          color: Color(int.parse(iconcolor)),
        );
      }
    default:
      {
        return Icon(
          FontAwesomeIcons.truck,
          size: sizeIcon,
          color: Color(int.parse(iconcolor)),
        );
      }
  }
}
