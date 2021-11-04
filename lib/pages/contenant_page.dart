import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContenantPage extends StatefulWidget {
  @override
  _ContenantPageState createState() => _ContenantPageState();
}

class _ContenantPageState extends State<ContenantPage> {
  final _createContenantKeyForm = GlobalKey<FormState>();
  TextEditingController _barCodeContenantController = TextEditingController();
  TextEditingController _statusContenantController = TextEditingController();
  String _statusContenant = 'Disponible';
  // int id = 1;
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference _contenant =
      FirebaseFirestore.instance.collection("Contenant");
  Stream<QuerySnapshot> _contenantStream = FirebaseFirestore.instance
      .collection("Contenant")
      .orderBy('barCodeContenant')
      .snapshots();
  //For Type Contenant
  CollectionReference _typecontenant =
      FirebaseFirestore.instance.collection("TypeContenant");
  String nombre = '0';
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
                            text: 'Contenant',
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
                                FontAwesomeIcons.boxOpen,
                                size: 17,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Contenant',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
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
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      showCreateContenant();
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
                                  'Code-barres',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Text(
                                  'Type',
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
                                  'Actuellement',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Icon(
                                  FontAwesomeIcons.barcode,
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
                      stream: _contenantStream,
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
                            Map<String, dynamic> contenant =
                                document.data()! as Map<String, dynamic>;
                            // print('$contenant');
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
                                          alignment: Alignment(-1, 0.15),
                                          width: 100,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Text(
                                                contenant['barCodeContenant'],
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
                                          width: 60,
                                        ),
                                        Container(
                                          alignment: Alignment(-1, 0.15),
                                          width: 100,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Text(
                                                contenant['typeContenant'],
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
                                          width: 50,
                                        ),
                                        Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 150,
                                            height: 50,
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                buildStatusIcon(
                                                    iconstatus: contenant[
                                                        'statusContenant']),
                                                Text(
                                                  contenant['statusContenant'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Container(
                                          alignment: Alignment(-1, 0.15),
                                          width: 50,
                                          height: 50,
                                          color: Colors.green,
                                          child: IconButton(
                                            icon: const Icon(Icons.download),
                                            tooltip: 'Modify Contenant',
                                            onPressed: () {
                                              // showModifyContenantDialog(
                                              //     context: context,
                                              //     dataContenant: contenant);
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
                  ]),
                ))
          ],
        ),
      ),
    );
  }

  showCreateContenant() {
    String choiceTypeContenant = 'None';
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
                        'New Contenant',
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
                        key: _createContenantKeyForm,
                        child: Column(
                          children: [
                            Container(
                              width: 400,
                              color: Colors.red,
                              child: TextFormField(
                                controller: _barCodeContenantController,
                                decoration: InputDecoration(
                                  labelText: 'Code-barres*:',
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
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("TypeContenant")
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
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
                                              choiceTypeContenant =
                                                  changedValue!;
                                            });
                                          },
                                          value: choiceTypeContenant,
                                          items: snapshot.data!.docs.map(
                                              (DocumentSnapshot
                                                  document_typecontenant) {
                                            Map<String, dynamic> typecontenant =
                                                document_typecontenant.data()!
                                                    as Map<String, dynamic>;
                                            return DropdownMenuItem<String>(
                                              value: document_typecontenant.id,
                                              child: new Text(
                                                  document_typecontenant.id),
                                            );
                                          }).toList(),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 600,
                              height: 50,
                              color: Colors.red,
                              child: Row(
                                children: [
                                  Text(
                                    'Actuellement*: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _statusContenant,
                                    onChanged: (val) {
                                      setState(() {
                                        _statusContenant = 'Disponible';
                                        // id = 1;
                                        // print('$_statusContenant');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Disponible',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _statusContenant,
                                    onChanged: (val) {
                                      setState(() {
                                        _statusContenant = 'PasDisponible';
                                        // id = 2;
                                        // print('$_statusContenant');
                                      });
                                    },
                                  ),
                                  Text(
                                    'PasDisponible',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
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
                              onTap: () {
                                _barCodeContenantController.text = '';
                                choiceTypeContenant = 'None';
                                _statusContenant = 'Disponible';
                                nombre = '0';
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
                                if (_createContenantKeyForm.currentState!
                                    .validate()) {
                                  String newIdContenant = _contenant.doc().id;
                                  if (choiceTypeContenant == 'None') {
                                    Fluttertoast.showToast(
                                        msg: "Please choice a Type Contenant",
                                        gravity: ToastGravity.TOP);
                                  } else {
                                    DocumentReference doc_ref =
                                        FirebaseFirestore.instance
                                            .collection("TypeContenant")
                                            .doc(choiceTypeContenant);

                                    DocumentSnapshot docSnap =
                                        await doc_ref.get();
                                    await _typecontenant
                                        .doc(choiceTypeContenant)
                                        .update({
                                      'nombre':
                                          (int.parse(docSnap['nombre']) + 1)
                                              .toString()
                                    });
                                    await _contenant.doc(newIdContenant).set({
                                      'barCodeContenant':
                                          _barCodeContenantController.text,
                                      'typeContenant': choiceTypeContenant,
                                      'statusContenant': _statusContenant,
                                      'idAdresse': 'null',
                                      'idAdresseContenant': 'null',
                                      'idContenant': newIdContenant
                                    }).then((value) {
                                      _barCodeContenantController.text = '';
                                      choiceTypeContenant = 'None';
                                      _statusContenant = 'Disponible';
                                      nombre = '0';
                                      print("Contenant Added");
                                      Fluttertoast.showToast(
                                          msg: "Contenant Added",
                                          gravity: ToastGravity.TOP);
                                      Navigator.of(context).pop();
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
