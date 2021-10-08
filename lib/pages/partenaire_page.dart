import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartenairePage extends StatefulWidget {
  @override
  _PartenairePageState createState() => _PartenairePageState();
}

class _PartenairePageState extends State<PartenairePage> {
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Vehicule");
  Stream<QuerySnapshot> _partenaireStream = FirebaseFirestore.instance
      .collection("Partenaire")
      .orderBy('nomPartenaire')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      header(context: context),
      menu(context: context),
      SizedBox(height: 20),
      Align(
          alignment: Alignment(-0.9, 0),
          child: Container(
              margin: EdgeInsets.only(left: 20),
              width: 800,
              height: 1000,
              color: Colors.green,
              child: Column(children: [
                Container(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(
                            FontAwesomeIcons.building,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Partenaire',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 500,
                          ),
                          Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  //Update later
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
                                      'New Partenaire',
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
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.building,
                              size: 17,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Actif',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Text(
                              'Nom Partenaire',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                            ),
                            Icon(
                              FontAwesomeIcons.user,
                              size: 17,
                            ),
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
                StreamBuilder<QuerySnapshot>(
                  stream: _partenaireStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    // print('$snapshot');
                    return Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> partenaire =
                            document.data()! as Map<String, dynamic>;
                        // print('$vehicule');
                        return Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    buildTypePartenaireIcon(
                                        typePartenaire:
                                            partenaire['typePartenaire']),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    buildStatusPartenaireIcon(
                                        actifPartenaire:
                                            partenaire['actifPartenaire']),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Container(
                                      alignment: Alignment(-1, 0.15),
                                      width: 100,
                                      height: 50,
                                      color: Colors.green,
                                      child: Row(
                                        children: [
                                          Text(
                                            partenaire['nomPartenaire'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320,
                                    ),
                                    Container(
                                        alignment: Alignment(-1, 0.15),
                                        width: 50,
                                        height: 50,
                                        color: Colors.green,
                                        child: contactPartenaire(
                                            idContactPartenaire: partenaire[
                                                'idContactPartenaire']))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  thickness: 5,
                                ),
                              ],
                            ));
                      }).toList(),
                    );
                  },
                ),
              ]))),
    ])));
  }

  Widget buildTypePartenaireIcon({required String typePartenaire}) {
    // print('$typePartenaire');
    switch (typePartenaire) {
      case 'PRIVE':
        {
          return Tooltip(
            message: 'PRIVE',
            child: Icon(
              FontAwesomeIcons.building,
              size: 17,
            ),
          );
        }

      case 'PUBLIC':
        {
          return Tooltip(
            message: 'PUBLIC',
            child: Icon(
              FontAwesomeIcons.city,
              size: 17,
            ),
          );
        }
      case 'EXPERIMENTATION':
        {
          return Tooltip(
            message: 'EXPERIMENTATION',
            child: Icon(
              FontAwesomeIcons.flask,
              size: 17,
            ),
          );
        }
      default:
        {
          return Tooltip(
            message: 'AUTRES',
            child: Icon(
              FontAwesomeIcons.flag,
              size: 17,
            ),
          );
        }
    }
  }

  Widget buildStatusPartenaireIcon({required String actifPartenaire}) {
    // print('$typePartenaire');
    switch (actifPartenaire) {
      case 'true':
        {
          return Tooltip(
            message: 'Actif',
            child: Icon(
              FontAwesomeIcons.check,
              size: 17,
            ),
          );
        }

      case 'false':
        {
          return Tooltip(
            message: 'PasActif',
            child: Icon(
              FontAwesomeIcons.times,
              size: 17,
            ),
          );
        }
      default:
        {
          return Tooltip(
            message: 'PasActif',
            child: Icon(
              FontAwesomeIcons.times,
              size: 17,
            ),
          );
        }
    }
  }

  Widget contactPartenaire({required idContactPartenaire}) {
    switch (idContactPartenaire) {
      case 'null':
        {
          return IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              size: 17,
            ),
            tooltip: 'Add Contact',
            onPressed: () {
              //addContactPartenaire();
            },
          );
        }
      default:
        {
          return IconButton(
            icon: const Icon(
              FontAwesomeIcons.user,
              size: 17,
            ),
            tooltip: 'View Contact',
            onPressed: () {
              //viewContactPartenaire();
            },
          );
        }
    }
  }
}
