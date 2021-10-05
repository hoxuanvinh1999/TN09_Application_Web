import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/pages/collecteur_page.dart';

showSubMenu2({required BuildContext context}) {
  return showDialog(
      barrierColor: null,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment(-0.6, -0.04),
          child: Container(
              height: 400,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              )),
        );
      });
}
