import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/contact_page.dart';

class CreateTourneePage extends StatefulWidget {
  @override
  _CreateTourneePageState createState() => _CreateTourneePageState();
}

class _CreateTourneePageState extends State<CreateTourneePage> {
  final _createTourneeKeyForm = GlobalKey<FormState>();
  String choiceIdCollecteur = 'null'; //for get idCollecteur
  String choiceIdVehicule = 'null'; //for get idVehicule
  //For collecteur
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  //For Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
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
                      text: 'Create Tournee',
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
              width: 600,
              height: 1200,
              color: Colors.green,
              child: Column(children: [
                Container(
                  height: 60,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(
                            FontAwesomeIcons.truck,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Create New Tournee',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        thickness: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 60,
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
                              FontAwesomeIcons.cog,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              ' Informations et paramètres',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          thickness: 5,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 800,
                  width: 800,
                  color: Colors.blue,
                  child: Form(
                    key: _createTourneeKeyForm,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          height: 50,
                          color: Colors.red,
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.user,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Collecteur',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              StreamBuilder<QuerySnapshot>(
                                  stream: _collecteur.snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    return DropdownButton(
                                      onChanged: (String? changedValue) {
                                        setState(() {
                                          choiceIdCollecteur = changedValue!;
                                        });
                                      },
                                      value: choiceIdCollecteur,
                                      items: snapshot.data!.docs.map(
                                          (DocumentSnapshot
                                              document_collecteur) {
                                        Map<String, dynamic> dataCollecteur =
                                            document_collecteur.data()!
                                                as Map<String, dynamic>;

                                        return DropdownMenuItem<String>(
                                          value: dataCollecteur['idCollecteur'],
                                          child: new Text(
                                              dataCollecteur['nomCollecteur'] +
                                                  ' ' +
                                                  dataCollecteur[
                                                      'prenomCollecteur']),
                                        );
                                      }).toList(),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          height: 50,
                          color: Colors.red,
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.truck,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Vehicule',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              StreamBuilder<QuerySnapshot>(
                                  stream: _vehicule.snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    return DropdownButton(
                                      onChanged: (String? changedValue) {
                                        setState(() {
                                          choiceIdVehicule = changedValue!;
                                        });
                                      },
                                      value: choiceIdVehicule,
                                      items: snapshot.data!.docs.map(
                                          (DocumentSnapshot document_vehicule) {
                                        Map<String, dynamic> dataVehicule =
                                            document_vehicule.data()!
                                                as Map<String, dynamic>;

                                        return DropdownMenuItem<String>(
                                          value: dataVehicule['idVehicule'],
                                          child: new Text(
                                              dataVehicule['nomVehicule'] +
                                                  ' ' +
                                                  dataVehicule[
                                                      'numeroImmatriculation']),
                                        );
                                      }).toList(),
                                    );
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 5,
                ),
                Container(
                  width: 800,
                  height: 80,
                  color: Colors.red,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ContactPage()));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {},
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
                                  'Create',
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
                ),
              ])))
    ])));
  }
}
