import 'package:flutter/material.dart';

bool isNumericUsing_tryParse(String string) {
  if (string == null || string.isEmpty) {
    return false;
  }
  final number = num.tryParse(string);
  if (number == null) {
    return false;
  }
  return true;
}
