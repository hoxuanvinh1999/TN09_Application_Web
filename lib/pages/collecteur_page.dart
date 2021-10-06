import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollecteurPage extends StatefulWidget {
  @override
  _CollecteurPageState createState() => _CollecteurPageState();
}

class _CollecteurPageState extends State<CollecteurPage> {
  final _createCollecteurKeyForm = GlobalKey<FormState>();
  final _modifyCollecteurKeyForm = GlobalKey<FormState>();
  String _siteCollecteur = 'Bordeaux';
  List<String> list_site = ['Bordeaux', 'Etc', 'ectcect'];
  TextEditingController _nomCollecteurController = TextEditingController();
  TextEditingController _prenomCollecteurController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  Stream<QuerySnapshot> _collecteurStream = FirebaseFirestore.instance
      .collection("Collecteur")
      .orderBy('nomCollecteur')
      .snapshots();

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
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 25),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            menu(context: context),
            SizedBox(height: 20),
            Align(
              alignment: Alignment(-0.9, 0),
              child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 600,
                  height: 600,
                  color: Colors.green,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Collecteur',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 280,
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
                                        showDialog(
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
                                                          alignment: Alignment(
                                                              -0.9, 0),
                                                          color: Colors.blue,
                                                          child: Text(
                                                            'New Collecteur',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                            key:
                                                                _createCollecteurKeyForm,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: 400,
                                                                  color: Colors
                                                                      .red,
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _nomCollecteurController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Nom* :',
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
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
                                                                  color: Colors
                                                                      .red,
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _prenomCollecteurController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Prenom* :',
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
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
                                                                  height: 50,
                                                                  color: Colors
                                                                      .red,
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .place,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          'Site',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w600)),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      //dropdown have bug
                                                                      DropdownButton<
                                                                              String>(
                                                                          onChanged: (String?
                                                                              changedValue) {
                                                                            setState(() {
                                                                              _siteCollecteur = changedValue!;
                                                                              print('$_siteCollecteur  $changedValue');
                                                                            });
                                                                          },
                                                                          value:
                                                                              _siteCollecteur,
                                                                          items:
                                                                              list_site.map((String value) {
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
                                                                  height: 100,
                                                                  color: Colors
                                                                      .blue,
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .calendar_today_rounded,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          'Date de Naissance',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w600)),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            150,
                                                                        color: Colors
                                                                            .red,
                                                                        child: ElevatedButton(
                                                                            onPressed: () {
                                                                              pickDate(context);
                                                                            },
                                                                            child: Text(
                                                                              DateFormat('yMd').format(date).toString(),
                                                                              style: TextStyle(color: Colors.black, fontSize: 15),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
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
                                                                    color: Colors
                                                                        .yellow,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        top: 20,
                                                                        bottom:
                                                                            20),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    _nomCollecteurController
                                                                        .text = '';
                                                                    _prenomCollecteurController
                                                                        .text = '';
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Cancel',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                            Container(
                                                                width: 150,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .yellow,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        top: 20,
                                                                        bottom:
                                                                            20),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    _collecteur.add({
                                                                      'nomCollecteur':
                                                                          _nomCollecteurController
                                                                              .text,
                                                                      'prenomCollecteur':
                                                                          _prenomCollecteurController
                                                                              .text,
                                                                      'siteCollecteur':
                                                                          _siteCollecteur,
                                                                      'datedeNaissance': DateFormat(
                                                                              'yMd')
                                                                          .format(
                                                                              date)
                                                                          .toString(),
                                                                    }).then(
                                                                        (value) {
                                                                      _nomCollecteurController
                                                                          .text = '';
                                                                      _prenomCollecteurController
                                                                          .text = '';
                                                                      print(
                                                                          "Collecteur Added");
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }).catchError(
                                                                        (error) =>
                                                                            print("Failed to add user: $error"));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Save',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
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
                                            'New Collecteur',
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
                                  Text(
                                    'Nom',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Text(
                                    'Sites',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                              SizedBox(
                                height: 15,
                              )
                            ],
                          )),
                      StreamBuilder<QuerySnapshot>(
                        stream: _collecteurStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          // print('$snapshot');
                          return Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> collecteur =
                                  document.data()! as Map<String, dynamic>;
                              // print('$collecteur');
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
                                          Container(
                                            alignment: Alignment.topLeft,
                                            width: 200,
                                            height: 50,
                                            color: Colors.green,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  collecteur['nomCollecteur'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  collecteur[
                                                      'prenomCollecteur'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 200,
                                            height: 50,
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.place,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  collecteur['siteCollecteur'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 50,
                                            height: 50,
                                            color: Colors.green,
                                            child: IconButton(
                                              icon: const Icon(Icons.edit),
                                              tooltip: 'Modify Collecteur',
                                              onPressed: () {
                                                //update later
                                              },
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
                                    ],
                                  ));
                            }).toList(),
                          );
                        },
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
