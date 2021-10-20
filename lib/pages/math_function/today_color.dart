import 'package:flutter/material.dart';

Color today_color({required DateTime check_day}) {
  Color result = Colors.red;
  if (check_day.day == DateTime.now().day &&
      check_day.month == DateTime.now().month &&
      check_day.year == DateTime.now().year) {
    result = Color(0xFF296F03);
  }
  return result;
}
