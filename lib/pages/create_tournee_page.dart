import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
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
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';

class CreateTourneePage extends StatefulWidget {
  @override
  _CreateTourneePageState createState() => _CreateTourneePageState();
}

class _CreateTourneePageState extends State<CreateTourneePage> {
  final _createTourneeKeyForm = GlobalKey<FormState>();
  String choiceIdCollecteur = 'null'; //for get idCollecteur
  String choiceIdVehicule = 'null'; //for get idVehicule
  String choiceIdPartenaire = 'null'; //for get IdPartenaire
  String choiceIdAdresse = 'null'; //for get IdAdresse
  String choiceIdFrequence = 'null'; // for get IdFrequence
  // String choiceNomPartenaire = 'None'; //for get NomPartenaire
  // String choiceNomPartenaireAdresse = 'None'; //for get NomPartenaireAdresse
  // For save Partenaire information
  List<String> list_choiceIdPartenaire = [];
  List<String> list_choiceNomPartenaire = [];
  // For save Adresse Information
  List<String> list_choiceIdAdresse = [];
  List<String> list_choiceNomPartenaireAdresse = [];
  List<String> list_latitudeAdresse = [];
  List<String> list_longitudeAdresse = [];
  List<String> list_ligne1Adresse = [];
  // For save Frequence Information
  List<String> list_choiceIdFrequence = [];
  List<String> list_startFrequence = [];
  List<String> list_endFrequence = [];
  List<String> list_tarifFrequence = [];

  //For collecteur
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  //For Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  // For Frequence
  CollectionReference _frequence =
      FirebaseFirestore.instance.collection("Frequence");
  // For select day
  String _jourPlanning = '';

  DateTime date = DateTime.now();

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 25),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  //For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  //For Adresse
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
  // for count
  int _count = 0;
  // For Tournee
  CollectionReference _tournee =
      FirebaseFirestore.instance.collection("Tournee");
  bool confirm = true;
  Color confirm_color = Colors.blue;
  String newIdTournee = '';
  // For Step
  CollectionReference _etape = FirebaseFirestore.instance.collection("Etape");
  List<String> list_IdEtape = [];
  List<bool> list_Etape_confirm = [];
  List<Color> list_color_etape = [];
  @override
  Widget build(BuildContext context) {
    // For the list view
    List<Widget> list_step =
        List.generate(_count, (int i) => addStepWidget(element: i));
    ;
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
              height: 2000,
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
                  height: 400,
                  width: 800,
                  color: confirm_color,
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
                                        if (confirm) {
                                          setState(() {
                                            choiceIdCollecteur = changedValue!;
                                          });
                                        } else {
                                          null;
                                        }
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
                              SizedBox(
                                width: 10,
                              ),
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
                                        if (confirm) {
                                          setState(() {
                                            choiceIdVehicule = changedValue!;
                                          });
                                        } else {
                                          null;
                                        }
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          height: 100,
                          color: Colors.red,
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Date de Planning',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              Container(
                                height: 50,
                                width: 150,
                                color: Colors.red,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (confirm) {
                                        pickDate(context);
                                      } else {
                                        null;
                                      }
                                    },
                                    child: Text(
                                      DateFormat('yMd').format(date).toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 800,
                          height: 80,
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: !confirm,
                                child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 20, bottom: 20),
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          confirm = true;
                                          confirm_color = Colors.blue;
                                        });
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
                                            'Change',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Visibility(
                                visible: confirm,
                                child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 20, bottom: 20),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (choiceIdCollecteur == 'null' ||
                                            choiceIdVehicule == 'null') {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please Select Collecteur and Vehicule",
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          if (newIdTournee == '') {
                                            newIdTournee =
                                                _tournee.doc().id.toString();
                                            await _tournee
                                                .doc(newIdTournee)
                                                .set({
                                              'idCollecteur':
                                                  choiceIdCollecteur,
                                              'idVehicule': choiceIdVehicule,
                                              'dateTournee':
                                                  getDateText(date: date),
                                              'isCreating': 'true',
                                            });
                                          } else {
                                            await _tournee
                                                .doc(newIdTournee)
                                                .update({
                                              'idCollecteur':
                                                  choiceIdCollecteur,
                                              'idVehicule': choiceIdVehicule,
                                              'dateTournee':
                                                  getDateText(date: date),
                                            });
                                          }
                                          setState(() {
                                            confirm = false;
                                            confirm_color = Colors.grey;
                                          });
                                        }
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
                                            'Confirm',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                Divider(
                  thickness: 5,
                ),
                Container(
                  width: 600,
                  height: 300,
                  child: Column(
                    children: [
                      Container(
                        width: 400,
                        height: 50,
                        color: Colors.red,
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.flag,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Partenaire',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 10,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: _partenaire.snapshots(),
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
                                        choiceIdPartenaire = changedValue!;
                                        choiceIdAdresse = 'null';
                                      });
                                    },
                                    value: choiceIdPartenaire,
                                    items: snapshot.data!.docs.map(
                                        (DocumentSnapshot document_partenaire) {
                                      Map<String, dynamic> dataPartenaire =
                                          document_partenaire.data()!
                                              as Map<String, dynamic>;

                                      return DropdownMenuItem<String>(
                                        value: dataPartenaire['idPartenaire'],
                                        child: Text(
                                            dataPartenaire['nomPartenaire']),
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
                              FontAwesomeIcons.mapMarker,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Adresse',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 10,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: _adresse
                                    .where('idPartenaireAdresse',
                                        isEqualTo: choiceIdPartenaire)
                                    .snapshots(),
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
                                        choiceIdAdresse = changedValue!;
                                        choiceIdFrequence = 'null';
                                      });
                                    },
                                    value: choiceIdAdresse,
                                    items: snapshot.data!.docs.map(
                                        (DocumentSnapshot document_adresse) {
                                      Map<String, dynamic> dataAdresse =
                                          document_adresse.data()!
                                              as Map<String, dynamic>;

                                      return DropdownMenuItem<String>(
                                        value: dataAdresse['idAdresse'],
                                        child: Text(dataAdresse[
                                            'nomPartenaireAdresse']),
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
                              FontAwesomeIcons.flag,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Frequence',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 10,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: _frequence
                                    .where('idAdresseFrequence',
                                        isEqualTo: choiceIdAdresse)
                                    .snapshots(),
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
                                        choiceIdFrequence = changedValue!;
                                      });
                                    },
                                    value: choiceIdFrequence,
                                    items: snapshot.data!.docs.map(
                                        (DocumentSnapshot document_frequence) {
                                      Map<String, dynamic> dataFrequence =
                                          document_frequence.data()!
                                              as Map<String, dynamic>;

                                      return DropdownMenuItem<String>(
                                        value: dataFrequence['idFrequence'],
                                        child: Text(dataFrequence[
                                                'jourFrequence'] +
                                            ' ' +
                                            dataFrequence['startFrequence'] +
                                            ' - ' +
                                            dataFrequence['endFrequence']),
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
                      ElevatedButton(
                        onPressed: () async {
                          late DateTime dateMinimale;
                          late DateTime dateMaximale;
                          bool min_after = false;
                          bool max_after = false;
                          String datelimit = '';
                          await _frequence
                              .where('idFrequence',
                                  isEqualTo: choiceIdFrequence)
                              .limit(1)
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              _jourPlanning = doc['jourFrequence'];
                              DateTime dateMinimale = DateTime(
                                  int.parse(doc['dateMinimaleFrequence']
                                      .substring(6)),
                                  int.parse(doc['dateMinimaleFrequence']
                                      .substring(3, 5)),
                                  int.parse(doc['dateMinimaleFrequence']
                                      .substring(0, 2)));
                              DateTime dateMaximale = DateTime(
                                  int.parse(doc['dateMaximaleFrequence']
                                      .substring(6)),
                                  int.parse(doc['dateMaximaleFrequence']
                                      .substring(3, 5)),
                                  int.parse(doc['dateMaximaleFrequence']
                                      .substring(0, 2)));
                              min_after = dateMinimale.isAfter(date);
                              max_after = date.isAfter(dateMaximale);
                              datelimit = 'Date Limit is: ' +
                                  DateFormat('yMd')
                                      .format(dateMinimale)
                                      .toString() +
                                  ' - ' +
                                  DateFormat('yMd')
                                      .format(dateMaximale)
                                      .toString();
                            });
                          });
                          print('$min_after');
                          print('$max_after');
                          print('$datelimit');
                          if (confirm) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Confirm Collecteur, Vehicule and Date before",
                                gravity: ToastGravity.TOP);
                          } else if (choiceIdAdresse == 'null' ||
                              choiceIdPartenaire == 'null') {
                            Fluttertoast.showToast(
                                msg: "Please select Partenaire and Adresse",
                                gravity: ToastGravity.TOP);
                          } else if (choiceIdFrequence == 'null') {
                            Fluttertoast.showToast(
                                msg: "Please select a Frequence",
                                gravity: ToastGravity.TOP);
                          } else if (checkday(check_date: date) !=
                              _jourPlanning) {
                            Fluttertoast.showToast(
                                msg: "That Frequence is not in that day",
                                gravity: ToastGravity.TOP);
                          } else if (min_after || max_after) {
                            Fluttertoast.showToast(
                                msg: datelimit, gravity: ToastGravity.TOP);
                          } else {
                            await _frequence
                                .where('idFrequence',
                                    isEqualTo: choiceIdFrequence)
                                .limit(1)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                list_choiceIdFrequence.add(doc['idFrequence']);
                                list_startFrequence.add(doc['startFrequence']);
                                list_endFrequence.add(doc['endFrequence']);
                                list_tarifFrequence.add(doc['tarifFrequence']);
                              });
                            });

                            await _partenaire
                                .where('idPartenaire',
                                    isEqualTo: choiceIdPartenaire)
                                .limit(1)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                list_choiceIdPartenaire
                                    .add(doc['idPartenaire']);
                                list_choiceNomPartenaire
                                    .add(doc['nomPartenaire']);
                              });
                            });
                            await _adresse
                                .where('idAdresse', isEqualTo: choiceIdAdresse)
                                .limit(1)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                list_choiceIdAdresse.add(doc['idAdresse']);
                                list_choiceNomPartenaireAdresse
                                    .add(doc['nomPartenaireAdresse']);
                                list_latitudeAdresse
                                    .add(doc['latitudeAdresse']);
                                list_longitudeAdresse
                                    .add(doc['longitudeAdresse']);
                                list_ligne1Adresse.add(doc['ligne1Adresse']);
                              });
                            });
                            list_Etape_confirm.add(false);
                            list_IdEtape.add(_etape.doc().id);
                            list_color_etape.add(Colors.blue);
                            setState(() {
                              _count++;
                            });
                          }
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 5,
                ),
                Container(
                    width: 600,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Text('Steps:',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ],
                    )),
                Container(
                    height: 800,
                    child: SingleChildScrollView(
                      child: Column(
                        children: list_step,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 800,
                  height: 80,
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (newIdTournee != '') {
                                _tournee
                                    .doc(newIdTournee)
                                    .delete()
                                    .then((value) {
                                  Fluttertoast.showToast(
                                      msg: 'Stop Creating Tournee',
                                      gravity: ToastGravity.TOP);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlanningWeeklyPage(
                                                thisDay: DateTime.now(),
                                              )));
                                }).catchError((error) =>
                                        print("Failed to add user: $error"));
                              } else {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlanningWeeklyPage(
                                              thisDay: DateTime.now(),
                                            )));
                              }
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
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (_count == 0) {
                                Fluttertoast.showToast(
                                    msg: "Please add a Etape",
                                    gravity: ToastGravity.TOP);
                              } else if (confirm) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please select and confirm Collecteur and Vehicule",
                                    gravity: ToastGravity.TOP);
                              } else {
                                bool all_etape_not_confirm = true;
                                int check_all_etape = 0;
                                while (all_etape_not_confirm &&
                                    check_all_etape < _count) {
                                  if (list_Etape_confirm[check_all_etape] ==
                                      false) {
                                    check_all_etape++;
                                  } else {
                                    all_etape_not_confirm = false;
                                  }
                                }
                                if (all_etape_not_confirm) {
                                  Fluttertoast.showToast(
                                      msg: "You did not confirm any Etape",
                                      gravity: ToastGravity.TOP);
                                } else {
                                  bool found_start = false;
                                  int numberofEtape = 0;
                                  int before = 0;
                                  int end = 0;
                                  String idEtapeStart = '';
                                  for (int i = 0; i < _count; i++) {
                                    if (!found_start) {
                                      if (list_Etape_confirm[i]) {
                                        found_start = true;
                                        idEtapeStart = list_IdEtape[i];
                                        numberofEtape++;
                                        await _tournee
                                            .doc(newIdTournee)
                                            .update({
                                          'idEtapeStart': idEtapeStart,
                                        });
                                        before = i;
                                        await _etape.doc(list_IdEtape[i]).set({
                                          'idEtape': list_IdEtape[i],
                                          'idEtapebefore': 'null',
                                          'idPartenaireEtape':
                                              list_choiceIdPartenaire[i],
                                          'idVehiculeEtape': choiceIdVehicule,
                                          'idCollecteurEtape':
                                              choiceIdCollecteur,
                                          'idAdresseEtape':
                                              list_choiceIdAdresse[i],
                                          'nomAdresseEtape':
                                              list_choiceNomPartenaireAdresse[
                                                  i],
                                          'latitudeEtape':
                                              list_latitudeAdresse[i],
                                          'longitude': list_longitudeAdresse[i],
                                          'ligne1Adresse':
                                              list_ligne1Adresse[i],
                                          'idFrequenceEtape':
                                              list_choiceIdFrequence[i],
                                          'startFrequenceEtape':
                                              list_startFrequence[i],
                                          'endFrequenceEtape':
                                              list_endFrequence[i],
                                          'tarifFrequenceEtape':
                                              list_tarifFrequence[i],
                                          'jourEtape': getDateText(date: date),
                                        });
                                        end = i;
                                      }
                                    } else {
                                      if (list_Etape_confirm[i]) {
                                        numberofEtape++;
                                        await _etape
                                            .doc(list_IdEtape[before])
                                            .update({
                                          'idEtapeAfter': list_IdEtape[i],
                                        });
                                        await _etape.doc(list_IdEtape[i]).set({
                                          'idEtape': list_IdEtape[i],
                                          'idEtapebefore': list_IdEtape[before],
                                          'idPartenaireEtape':
                                              list_choiceIdPartenaire[i],
                                          'idVehiculeEtape': choiceIdVehicule,
                                          'idCollecteurEtape':
                                              choiceIdCollecteur,
                                          'idAdresseEtape':
                                              list_choiceIdAdresse[i],
                                          'nomAdresseEtape':
                                              list_choiceNomPartenaireAdresse[
                                                  i],
                                          'latitudeEtape':
                                              list_latitudeAdresse[i],
                                          'longitude': list_longitudeAdresse[i],
                                          'ligne1Adresse':
                                              list_ligne1Adresse[i],
                                          'idFrequenceEtape':
                                              list_choiceIdFrequence[i],
                                          'startFrequenceEtape':
                                              list_startFrequence[i],
                                          'endFrequenceEtape':
                                              list_endFrequence[i],
                                          'tarifFrequenceEtape':
                                              list_tarifFrequence[i],
                                          'jourEtape': getDateText(date: date),
                                        });
                                        before = i;
                                        end = i;
                                      }
                                    }
                                  }
                                  await _etape.doc(list_IdEtape[end]).update({
                                    'idEtapeAfter': 'null',
                                  });
                                  await _tournee.doc(newIdTournee).update({
                                    'nombredeEtape': numberofEtape.toString(),
                                    'isCreating': false.toString(),
                                  }).then((value) {
                                    Fluttertoast.showToast(
                                        msg: "Finish Creating Tournee",
                                        gravity: ToastGravity.TOP);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PlanningWeeklyPage(
                                                  thisDay: date,
                                                )));
                                  }).catchError((error) =>
                                      print("Failed to add user: $error"));
                                }
                              }
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
                                  'Add New Planning',
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

  String checkday({required DateTime check_date}) {
    String result = '';
    String check_date_format = DateFormat('EEEE').format(check_date);
    switch (check_date_format) {
      case 'Monday':
        {
          result = 'Lundi';
          break;
        }
      case 'Tuesday':
        {
          result = 'Mardi';
          break;
        }
      case 'Wednesday':
        {
          result = 'Mercredi';
          break;
        }
      case 'Thursday':
        {
          result = 'Jeudi';
          break;
        }
      case 'Friday':
        {
          result = 'Vendredi';
          break;
        }
      case 'Saturday':
        {
          result = 'Samedi';
          break;
        }
      case 'Sunday':
        {
          result = 'Dimanche';
          break;
        }
      default:
        {
          result = 'Lundi';
          break;
        }
    }
    return result;
  }

  addStepWidget({required int element}) {
    return Container(
      height: 320,
      width: 600,
      color: list_color_etape[element],
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Etape: ' + (element + 1).toString())
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Nom Partenaire: ' + list_choiceNomPartenaire[element])
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Nom Partenaire Adresse: ' +
                  list_choiceNomPartenaireAdresse[element])
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Adresse ' + list_ligne1Adresse[element])
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Duree ' +
                  list_startFrequence[element] +
                  ' - ' +
                  list_endFrequence[element])
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Tarif ' + list_tarifFrequence[element])
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 600,
                height: 80,
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: list_Etape_confirm[element],
                      child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                list_Etape_confirm[element] = false;
                                list_color_etape[element] = Colors.blue;
                              });
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
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Visibility(
                      visible: !list_Etape_confirm[element],
                      child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                list_Etape_confirm[element] = true;
                                list_color_etape[element] = Colors.grey;
                              });
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
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
