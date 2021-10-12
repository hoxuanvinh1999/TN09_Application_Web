import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/create_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/view_partenaire_page.dart';

class PartenairePage extends StatefulWidget {
  @override
  _PartenairePageState createState() => _PartenairePageState();
}

class _PartenairePageState extends State<PartenairePage> {
  //for controll table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");
  //For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
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
                            FontAwesomeIcons.flag,
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
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreatePartenairePage()));
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
                                        width: 300,
                                        height: 50,
                                        color: Colors.green,
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: partenaire[
                                                      'nomPartenaire'],
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ViewPartenairePage(
                                                                            partenaire:
                                                                                partenaire,
                                                                          )));
                                                        }),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Container(
                                        alignment: Alignment(-1, 0.15),
                                        width: 50,
                                        height: 50,
                                        color: Colors.green,
                                        child: contactPartenaire(
                                            dataPartenaire: partenaire))
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

  Widget contactPartenaire({required dataPartenaire}) {
    switch (dataPartenaire['idContactPartenaire']) {
      case 'null':
        {
          return IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              size: 17,
            ),
            tooltip: 'Add Contact',
            onPressed: () {
              addContactPartenaire(dataPartenaire: dataPartenaire);
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

  //For Create Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  TextEditingController _nomContactController = TextEditingController();
  TextEditingController _prenomContractController = TextEditingController();
  TextEditingController _telephone1ContactController = TextEditingController();
  TextEditingController _telephone2ContactController = TextEditingController();
  TextEditingController _emailContactController = TextEditingController();
  TextEditingController _passwordContactController = TextEditingController();
  TextEditingController _noteContactController = TextEditingController();
  final _createContactKeyForm = GlobalKey<FormState>();
  bool isPrincipal = true;
  bool recoitRapport = false;
  bool recoitFacture = false;
  bool accessEtranet = false;

  addContactPartenaire({required Map dataPartenaire}) {
    if (dataPartenaire['idContactPartenaire'] == 'null') {
      isPrincipal = true;
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 600,
              width: 800,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      color: Colors.blue,
                      child: Text(
                        'New Contact',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )),
                  Divider(
                    thickness: 5,
                  ),
                  Container(
                    height: 400,
                    width: 500,
                    color: Colors.green,
                    child: Form(
                        key: _createContactKeyForm,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _nomContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom*:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _prenomContractController,
                                  decoration: InputDecoration(
                                    labelText: 'Prenom*:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _telephone1ContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Telephone 1:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _telephone2ContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Telephone2:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _emailContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Email:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 310,
                                    color: Colors.red,
                                    child: TextFormField(
                                      controller: _passwordContactController,
                                      decoration: InputDecoration(
                                        labelText: 'Password:',
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value == '') {
                                          return 'This can not be null';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        FontAwesomeIcons.syncAlt,
                                        size: 17,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        FontAwesomeIcons.copy,
                                        size: 17,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 400,
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _noteContactController,
                                      maxLines: 4,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Note"),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Recoit Facture',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Switch(
                                    value: recoitFacture,
                                    onChanged: (value) {
                                      setState(() {
                                        recoitFacture = !recoitFacture;
                                        print('recoitFacture $recoitFacture');
                                      });
                                    },
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Recoit Rapport',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Switch(
                                    value: recoitRapport,
                                    onChanged: (value) {
                                      setState(() {
                                        recoitRapport = !recoitRapport;
                                        print('recoitRapport $recoitRapport');
                                      });
                                    },
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Access Etranet',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Switch(
                                    value: accessEtranet,
                                    onChanged: (value) {
                                      setState(() {
                                        accessEtranet = !accessEtranet;
                                        print('accessEtranet $accessEtranet');
                                      });
                                    },
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
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
                          width: 400,
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
                                Navigator.of(context).pop();
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
                                    'Save',
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
                ],
              ),
            ),
          );
        });
  }

  Widget buildStatusIcon({required String iconstatus}) {
    switch (iconstatus) {
      case 'Disponible':
        {
          return Icon(
            FontAwesomeIcons.check,
            size: 17,
            color: Colors.black,
          );
        }
      case 'PasDisponible':
        {
          return Icon(
            FontAwesomeIcons.times,
            size: 17,
            color: Colors.black,
          );
        }
      default:
        {
          return Icon(
            FontAwesomeIcons.question,
            size: 17,
            color: Colors.black,
          );
          ;
        }
    }
  }
}
