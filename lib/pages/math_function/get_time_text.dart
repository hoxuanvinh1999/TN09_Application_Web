import 'package:flutter/material.dart';

String getTimeText({required TimeOfDay time}) {
  if (time == null) {
    return 'Select Time';
  } else {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
