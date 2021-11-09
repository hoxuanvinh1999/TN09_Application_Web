import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/pages/collecteur_page.dart';
import 'package:tn09_app_web_demo/pages/contact_page.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';

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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PartenairePage()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Partenaire'),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ContactPage()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Contact'),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
        );
      });
}
