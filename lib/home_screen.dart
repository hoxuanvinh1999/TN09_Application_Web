// ignore_for_file: invalid_return_type_for_catch_error, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context: context),
            menu(context: context),
            Container(
                decoration: BoxDecoration(
                  color: Color(graphique.color['default_yellow']),
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      FontAwesomeIcons.home,
                      size: 12,
                      color: Color(graphique.color['default_black']),
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Home',
                              style: TextStyle(
                                  color: Color(graphique.color['default_red']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                }),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 1000,
              color: Color(graphique.color['special_bureautique_2']),
              child: Column(
                children: [
                  // Container(
                  //     margin: const EdgeInsets.only(left: 80),
                  //     width: 150,
                  //     height: 50,
                  //     color: Colors.yellow,
                  //     alignment: Alignment.center,
                  //     child: GestureDetector(
                  //       onTap: () async {
                  //         //delete test result in 10/11/2021 and 17/11/2021
                  //         await FirebaseFirestore.instance
                  //             .collection("Tournee")
                  //             .where('dateTournee',
                  //                 whereIn: ['10/11/2021', '17/11/2021'])
                  //             .get()
                  //             .then((QuerySnapshot querySnapshot) {
                  //               querySnapshot.docs.forEach((tournee) {
                  //                 FirebaseFirestore.instance
                  //                     .collection('Tournee')
                  //                     .doc(tournee.id)
                  //                     .delete()
                  //                     .then((value) {
                  //                   Fluttertoast.showToast(
                  //                       msg: 'Delete Tournee',
                  //                       gravity: ToastGravity.TOP);
                  //                 }).catchError((error) =>
                  //                         print("Failed to add user: $error"));
                  //               });
                  //             })
                  //             .then((value) {
                  //               Fluttertoast.showToast(
                  //                   msg: 'Finish clean data',
                  //                   gravity: ToastGravity.TOP);
                  //             })
                  //             .catchError((error) =>
                  //                 print("Failed to add user: $error"));
                  //         await FirebaseFirestore.instance
                  //             .collection("Etape")
                  //             .where('jourEtape',
                  //                 whereIn: ['10/11/2021', '17/11/2021'])
                  //             .get()
                  //             .then((QuerySnapshot querySnapshot) {
                  //               querySnapshot.docs.forEach((etape) {
                  //                 FirebaseFirestore.instance
                  //                     .collection('Etape')
                  //                     .doc(etape.id)
                  //                     .delete()
                  //                     .then((value) {
                  //                   Fluttertoast.showToast(
                  //                       msg: 'Delete Etape',
                  //                       gravity: ToastGravity.TOP);
                  //                 }).catchError((error) =>
                  //                         print("Failed to add user: $error"));
                  //               });
                  //             })
                  //             .then((value) {
                  //               Fluttertoast.showToast(
                  //                   msg: 'Finish clean data',
                  //                   gravity: ToastGravity.TOP);
                  //             })
                  //             .catchError((error) =>
                  //                 print("Failed to add user: $error"));
                  //       },
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             'Function Button',
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
