import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

Color today_color({required DateTime check_day}) {
  Color result = Color(graphique.color['default_red']);
  if (check_day.day == DateTime.now().day &&
      check_day.month == DateTime.now().month &&
      check_day.year == DateTime.now().year) {
    result = Color(graphique.color['default_green']);
  }
  return result;
}
