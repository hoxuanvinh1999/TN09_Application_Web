import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';

class ViewPartenairePage extends StatefulWidget {
  Map partenaire;
  ViewPartenairePage({
    required this.partenaire,
  });
  @override
  _ViewPartenairePageState createState() => _ViewPartenairePageState();
}

class _ViewPartenairePageState extends State<ViewPartenairePage> {
  //forPartenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  Stream<QuerySnapshot> _partenaireStream = FirebaseFirestore.instance
      .collection("Partenaire")
      .orderBy('nomPartenaire')
      .snapshots();
  final _createPartenaireKeyForm = GlobalKey<FormState>();
  TextEditingController _nomPartenaireController = TextEditingController();
  TextEditingController _notePartenaireController = TextEditingController();
  TextEditingController _siretPartenaireController = TextEditingController();
  String _typePartenaire = 'PRIVE';
  List<String> list_type = ['PRIVE', 'PUBLIC', 'EXPERIMENTATION', 'AUTRES'];
  String _actifPartenaire = 'true';
  void inputData() {
    _nomPartenaireController.text = widget.partenaire['nomPartenaire'];
    _notePartenaireController.text = widget.partenaire['notePartenaire'];
    _siretPartenaireController.text = widget.partenaire['siretPartenaire'];
    _typePartenaire = widget.partenaire['typePartenaire'];
  }

  //for Adresse
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
  final _createAdressesKeyForm = GlobalKey<FormState>();
  TextEditingController _nomPartenaireAdresseController =
      TextEditingController();
  TextEditingController _ligne1AdresseController = TextEditingController();
  TextEditingController _ligne2AdresseController = TextEditingController();
  TextEditingController _codepostalAdresseController = TextEditingController();
  TextEditingController _villeAdresseController = TextEditingController();
  TextEditingController _paysAdresseController = TextEditingController();
  TextEditingController _latitudeAdresseController = TextEditingController();
  TextEditingController _longitudeAdresseController = TextEditingController();
  TextEditingController _etageAdresseController = TextEditingController();
  String _ascenseurAdresse = 'true';
  TextEditingController _noteAdresseController = TextEditingController();
  String _passagesAdresse = 'true';
  String _facturationAdresse = 'true';
  TextEditingController _tarifpassageAdresseController =
      TextEditingController();
  TextEditingController _tempspassageAdresseController =
      TextEditingController();
  TextEditingController _surfacepassageAdresseController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    inputData();
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      header(context: context),
      menu(context: context),
      SizedBox(height: 20),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20),
              width: 600,
              height: 800,
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
                  color: Colors.blue,
                  child: Form(
                      key: _createPartenaireKeyForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _nomPartenaireController,
                              decoration: InputDecoration(
                                labelText: 'Nom* :',
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
                              controller: _siretPartenaireController,
                              decoration: InputDecoration(
                                labelText: 'SIRET :',
                              ),
                              validator: (value) {
                                if (value != '' &&
                                    !value!.isEmpty &&
                                    value.length != 14) {
                                  return 'It must be 14 characters long';
                                }
                              },
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
                                  Icons.place,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Type',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                //dropdown have bug
                                DropdownButton<String>(
                                    onChanged: (String? changedValue) {
                                      setState(() {
                                        _typePartenaire = changedValue!;
                                        // print(
                                        //     '$_typePartenaire  $changedValue');
                                      });
                                    },
                                    value: _typePartenaire,
                                    items: list_type.map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList()),
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
                                Text(
                                  'Actif*: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                //bug with Radio
                                Radio(
                                  value: 'true',
                                  groupValue: _actifPartenaire,
                                  onChanged: (val) {
                                    setState(() {
                                      _actifPartenaire = 'true';
                                      // id = 1;
                                      // print('$_actifPartenaire');
                                    });
                                  },
                                ),
                                Text(
                                  'Actif',
                                  style: new TextStyle(fontSize: 17.0),
                                ),
                                Radio(
                                  value: 'false',
                                  groupValue: _actifPartenaire,
                                  onChanged: (val) {
                                    setState(() {
                                      _actifPartenaire = 'false';
                                      // id = 2;
                                      // print('$_actifPartenaire');
                                    });
                                  },
                                ),
                                Text(
                                  'PasActif',
                                  style: new TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
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
                                  controller: _notePartenaireController,
                                  maxLines: 4,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Note"),
                                ),
                              )),
                        ],
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
                            onTap: () async {
                              if (_createPartenaireKeyForm.currentState!
                                  .validate()) {
                                await _partenaire
                                    .where('idPartenaire',
                                        isEqualTo:
                                            widget.partenaire['idPartenaire'])
                                    .limit(1)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    _partenaire.doc(doc.id).update({
                                      'nomPartenaire':
                                          _nomPartenaireController.text,
                                      'notePartenaire':
                                          _notePartenaireController.text,
                                      'siretPartenaire':
                                          _siretPartenaireController.text,
                                      'idContactPartenaire': 'null',
                                      'actifPartenaire': _actifPartenaire,
                                      'typePartenaire': _typePartenaire,
                                    }).then((value) async {
                                      await _partenaire
                                          .where('idPartenaire',
                                              isEqualTo: widget
                                                  .partenaire['idPartenaire'])
                                          .limit(1)
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          Map<String, dynamic> next_partenaire =
                                              doc.data()!
                                                  as Map<String, dynamic>;
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Update Information Partenaire",
                                              gravity: ToastGravity.TOP);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPartenairePage(
                                                      partenaire:
                                                          next_partenaire,
                                                    )),
                                          ).then((value) => setState(() {}));
                                        });
                                      });
                                    }).catchError((error) =>
                                        print("Failed to update user: $error"));
                                  });
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
                                  'Update',
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
              ])),
          SizedBox(
            width: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 600,
                height: 200 +
                    300 * double.parse(widget.partenaire['nombredeAdresses']),
                color: Colors.green,
                child: Column(
                  children: [
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
                                FontAwesomeIcons.mapMarker,
                                size: 17,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Adresses',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 300,
                              ),
                              Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showCreateAdressesDialog();
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
                                          'New Adresse',
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
                        ],
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Adresse")
                            .where('idPartenaireAdresse',
                                isEqualTo: widget.partenaire['idPartenaire'])
                            .snapshots(),
                        //Can not use OrderBy and where together
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                                'Something went wrong + ${snapshot.error.toString()} + ${widget.partenaire['idPartenaire'].toString()}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> adresse =
                                  document.data()! as Map<String, dynamic>;
                              // print('$contenant');
                              return Container(
                                width: 600,
                                height: 300,
                                color: Colors.red,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                      color: Colors.white,
                                      width: 550,
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 550,
                                                color: Colors.blue,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .locationArrow,
                                                              size: 15,
                                                            ),
                                                            Text(
                                                              adresse[
                                                                  'nomPartenaireAdresse'],
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 10,
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                //Update later
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'Modify Adresse',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 100,
                                            width: 550,
                                            color: Colors.green,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .mapMarker,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      adresse['ligne1Adress'] +
                                                          ' ' +
                                                          adresse[
                                                              'codepostalAdresse'] +
                                                          ' ' +
                                                          adresse[
                                                              'villeAdresse'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons.clock,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Durée ' +
                                                          isInconnu(
                                                              text: adresse[
                                                                  'tempspassageAdresse']),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .moneyCheckAlt,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Tarif ' +
                                                          isInconnu(
                                                              text: adresse[
                                                                  'tarifpassageAdresse']) +
                                                          ' €',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .truckLoading,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Surface ' +
                                                          isInconnu(
                                                              text: adresse[
                                                                  'surfacepassageAdresse']) +
                                                          ' €',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .exclamationTriangle,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        isInconnu(
                                                            text: adresse[
                                                                'noteAdresse']),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 600,
                    height: 300,
                    color: Colors.green,
                    child: Column(
                      children: [
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
                                    FontAwesomeIcons.calendar,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Fréquences de passage',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
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
                                              'New Frequence',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 600,
                    height: 300,
                    color: Colors.green,
                    child: Column(
                      children: [
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
                                    FontAwesomeIcons.boxOpen,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Contenants et matières',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
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
                                              'New Contenant',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      )
    ])));
  }

  isInconnu({required String text}) {
    return text == '' ? 'Inconnu' : text;
  }

  showCreateAdressesDialog() {
    _nomPartenaireAdresseController.text = widget.partenaire['nomPartenaire'];
    _etageAdresseController.text = '0';
    _noteAdresseController.text = '';
    TabController adressesTabController;
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      color: Colors.blue,
                      child: Text(
                        'New Adresses',
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
                    color: Colors.green,
                    child: Form(
                        key: _createAdressesKeyForm,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _nomPartenaireAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom Adresse:',
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
                                  controller: _ligne1AdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse 1*:',
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
                                  controller: _ligne2AdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse 2:',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _codepostalAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Code Postal*:',
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
                                  controller: _villeAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Ville*:',
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
                                  controller: _paysAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Pays*:',
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
                                  controller: _latitudeAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Latitude:',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _longitudeAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Longitude:',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _etageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Étage*:',
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
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ascenseur: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _ascenseurAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _ascenseurAdresse = 'true';
                                        // id = 1;
                                        // print('$_ascenseurAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _ascenseurAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _ascenseurAdresse = 'false';
                                        // id = 2;
                                        // print('$_ascenseurAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
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
                                      controller: _noteAdresseController,
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
                                    'Passages: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _passagesAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _ascenseurAdresse = 'true';
                                        // id = 1;
                                        print('$_passagesAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _passagesAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _passagesAdresse = 'false';
                                        // id = 2;
                                        print('$_ascenseurAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
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
                                    'Facturation: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _facturationAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _facturationAdresse = 'true';
                                        // id = 1;
                                        // print('$_facturationAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _facturationAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _facturationAdresse = 'false';
                                        // id = 2;
                                        // print('$_facturationAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _tarifpassageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Prix du passage',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
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
                                  controller: _tempspassageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Temps sur place',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
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
                                  controller: _surfacepassageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Surface plancher',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
                                    }
                                  },
                                ),
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
                                _nomPartenaireAdresseController.text = '';
                                _ligne1AdresseController.text = '';
                                _ligne2AdresseController.text = '';
                                _codepostalAdresseController.text = '';
                                _villeAdresseController.text = '';
                                _paysAdresseController.text = '';
                                _latitudeAdresseController.text = '';
                                _longitudeAdresseController.text = '';
                                _etageAdresseController.text = '0';
                                _ascenseurAdresse = 'true';
                                _noteAdresseController.text = '';
                                _passagesAdresse = 'true';
                                _facturationAdresse = 'true';
                                _tarifpassageAdresseController.text = '';
                                _tempspassageAdresseController.text = '';
                                _surfacepassageAdresseController.text = '';

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
                              onTap: () async {
                                if (_createAdressesKeyForm.currentState!
                                    .validate()) {
                                  await _partenaire
                                      .where('idPartenaire',
                                          isEqualTo:
                                              widget.partenaire['idPartenaire'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _partenaire.doc(doc.id).update({
                                        'nombredeAdresses': (int.parse(
                                                    widget.partenaire[
                                                        'nombredeAdresses']) +
                                                1)
                                            .toString(),
                                      });
                                    });
                                  });
                                  await _adresse.doc(_adresse.doc().id).set({
                                    'nomPartenaireAdresse':
                                        _nomPartenaireAdresseController.text,
                                    'ligne1Adress':
                                        _ligne1AdresseController.text,
                                    'ligne2Adress':
                                        _ligne2AdresseController.text,
                                    'codepostalAdresse':
                                        _codepostalAdresseController.text,
                                    'villeAdresse':
                                        _villeAdresseController.text,
                                    'paysAdresse': _paysAdresseController.text,
                                    'latitudeAdresse':
                                        _latitudeAdresseController.text,
                                    'longitudeAdresse':
                                        _longitudeAdresseController.text,
                                    'etageAdresse':
                                        _etageAdresseController.text,
                                    '_ascenseurAdresse': _ascenseurAdresse,
                                    'noteAdresse': _noteAdresseController.text,
                                    'passagesAdresse': _passagesAdresse,
                                    'facturationAdresse': _facturationAdresse,
                                    'tarifpassageAdresse':
                                        _tarifpassageAdresseController.text,
                                    'tempspassageAdresse':
                                        _tempspassageAdresseController.text,
                                    'surfacepassageAdresse':
                                        _surfacepassageAdresseController.text,
                                    'idPartenaireAdresse':
                                        widget.partenaire['idPartenaire'],
                                    'idAdresse': _adresse.doc().id
                                  }).then((value) {
                                    _nomPartenaireAdresseController.text = '';
                                    _ligne1AdresseController.text = '';
                                    _ligne2AdresseController.text = '';
                                    _codepostalAdresseController.text = '';
                                    _villeAdresseController.text = '';
                                    _paysAdresseController.text = '';
                                    _latitudeAdresseController.text = '';
                                    _longitudeAdresseController.text = '';
                                    _etageAdresseController.text = '0';
                                    _ascenseurAdresse = 'true';
                                    _noteAdresseController.text = '';
                                    _passagesAdresse = 'true';
                                    _facturationAdresse = 'true';
                                    _tarifpassageAdresseController.text = '';
                                    _tempspassageAdresseController.text = '';
                                    _surfacepassageAdresseController.text = '';
                                    print("Adresse Added");
                                    Fluttertoast.showToast(
                                        msg: "Adresse Added",
                                        gravity: ToastGravity.TOP);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewPartenairePage(
                                                partenaire: widget.partenaire,
                                              )),
                                    ).then((value) => setState(() {}));
                                  }).catchError((error) =>
                                      print("Failed to add user: $error"));
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
                ]),
          ));
        });
  }
}
