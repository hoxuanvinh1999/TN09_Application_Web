import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/collecteur_page.dart';

showSubMenu1({required BuildContext context}) {
  return showDialog(
      barrierColor: null,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment(-1.045, -0.04),
          child: Container(
              height: 400,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CollecteurPage()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 0),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Collecteur'),
                          )),
                    )
                  ],
                ),
              )),
        );
      });
}
