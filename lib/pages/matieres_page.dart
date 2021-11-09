import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/create_matiere_page.dart';

class MatieresPage extends StatefulWidget {
  @override
  _MatieresPageState createState() => _MatieresPageState();
}

class _MatieresPageState extends State<MatieresPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // For Matiere
  CollectionReference _matiere =
      FirebaseFirestore.instance.collection("Matiere");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context: context),
            menu(context: context),
            Container(
                color: Colors.yellow,
                width: double.infinity,
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      FontAwesomeIcons.home,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Home',
                              style: TextStyle(
                                  color: Colors.red,
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
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Matiere',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Align(
              alignment: Alignment(-0.9, 0),
              child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 800,
                  color: Colors.green,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.tags,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Matières collectées ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 20, bottom: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateMatierePage()));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'New Matiere',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              thickness: 5,
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      Container(
                          color: Colors.red,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.tag, size: 15),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                thickness: 5,
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          )),
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _matiere.orderBy('nomMatiere').snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('${snapshot.error.toString()}');
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            // print('$snapshot');

                            return SingleChildScrollView(
                              child: Column(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> matiere =
                                      document.data()! as Map<String, dynamic>;
                                  // print('$collecteur');
                                  if (matiere['idMatiere'] == 'null') {
                                    return SizedBox.shrink();
                                  } else {
                                    return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        color: Colors.white,
                                        height: 60,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Icon(
                                                        FontAwesomeIcons.tag,
                                                        size: 15,
                                                        color: Color(int.parse(
                                                            matiere[
                                                                'colorMatiere'])),
                                                      )),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Text(
                                                      matiere['nomMatiere'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 5,
                                            ),
                                          ],
                                        ));
                                  }
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
