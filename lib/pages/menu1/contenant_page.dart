import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/menu1/create_contenant_page.dart';

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
    // Fow width of table
    double page_width = MediaQuery.of(context).size.width * 0.5;
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
                    const SizedBox(
                      width: 40,
                    ),
                    Icon(
                      FontAwesomeIcons.home,
                      size: 12,
                      color: Color(graphique.color['default_black']),
                    ),
                    const SizedBox(width: 5),
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
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: graphique.languagefr['contenant_page']
                                ['nom_page'],
                            style: TextStyle(
                                color: Color(graphique.color['default_grey']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Align(
                alignment: const Alignment(-0.9, 0),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                  ),
                  width: page_width,
                  height: 1500,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(graphique.color['main_color_1']),
                        border: Border.all(
                            width: 1.0,
                            color: Color(graphique.color['default_black'])),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.boxOpen,
                                  size: 17,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  graphique.languagefr['contenant_page']
                                      ['table_title'],
                                  style: TextStyle(
                                    color:
                                        Color(graphique.color['main_color_2']),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: 180,
                              decoration: BoxDecoration(
                                  color:
                                      Color(graphique.color['default_yellow']),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  //showCreateContenant();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateContenantPage()));
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Color(
                                          graphique.color['default_black']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      graphique.languagefr['contenant_page']
                                          ['button_1'],
                                      style: TextStyle(
                                        color: Color(
                                            graphique.color['default_black']),
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
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: page_width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(graphique.color['main_color_1']),
                        border: Border.all(
                            width: 1.0,
                            color: Color(graphique.color['default_black'])),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            graphique.languagefr['contenant_page']
                                ['column_1_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          Text(
                            graphique.languagefr['contenant_page']
                                ['column_2_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Text(
                            graphique.languagefr['contenant_page']
                                ['column_3_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Icon(
                            FontAwesomeIcons.barcode,
                            size: 17,
                            color: Color(graphique.color['main_color_2']),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _contenantStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        // print('$snapshot');
                        return Column(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> contenant =
                                document.data()! as Map<String, dynamic>;
                            // print('$contenant');
                            return Container(
                                width: page_width,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: Color(
                                      graphique.color['special_bureautique_2']),
                                  border: Border(
                                      top: BorderSide(
                                          width: 1.0,
                                          color: Color(graphique
                                              .color['default_black'])),
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(graphique
                                              .color['default_black']))),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        width: 100,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              contenant['barCodeContenant'],
                                              style: TextStyle(
                                                color: Color(graphique
                                                    .color['default_black']),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 80),
                                        width: 100,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              contenant['typeContenant'],
                                              style: TextStyle(
                                                color: Color(graphique
                                                    .color['default_black']),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 30),
                                          width: 150,
                                          height: 50,
                                          color: Color(graphique
                                              .color['special_bureautique_2']),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              buildStatusIcon(
                                                  iconstatus: contenant[
                                                      'statusContenant']),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                contenant['statusContenant'],
                                                style: TextStyle(
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(left: 40),
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        width: 50,
                                        height: 50,
                                        child: IconButton(
                                          icon: const Icon(Icons.download),
                                          tooltip: graphique
                                                  .languagefr['contenant_page']
                                              ['icon_button_1_title'],
                                          onPressed: () {
                                            // showModifyContenantDialog(
                                            //     context: context,
                                            //     dataContenant: contenant);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
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
                                    return graphique.languagefr['warning']
                                        ['not_null'];
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
