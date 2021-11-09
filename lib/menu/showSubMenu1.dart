import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/pages/collecteur_page.dart';
import 'package:tn09_app_web_demo/pages/contenant_page.dart';
import 'package:tn09_app_web_demo/pages/type_contenant_page.dart';
import 'package:tn09_app_web_demo/pages/vehicule_page.dart';

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
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Collecteur'),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => VehiculePage()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Vehicule'),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ContenantPage()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          color: Colors.red,
                          width: 400,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Contenant'),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => TypeContenantPage()));
                      },
                      child: Container(
                          margin:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          color: Colors.red,
                          width: 380,
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text('Type Contenant'),
                          )),
                    ),
                  ],
                ),
              )),
        );
      });
}
