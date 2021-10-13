import 'dart:math';
import 'package:flutter/material.dart';

String limitString({required String text, required int limit_long}) {
  String result = '';

  if (text.length < limit_long) {
    result += text;
    for (int i = 1; i < (limit_long - text.length + 2); i++) {
      result += ' ';
    }
  } else {
    result += text.substring(0, limit_long - 1);
    result += '..';
  }
  // print('|$result|');
  return result;
}
