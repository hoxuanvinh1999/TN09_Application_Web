// ignore_for_file: prefer_final_fields, unused_local_variable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/menu1/contenant_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class CreateContenantPage extends StatefulWidget {
  @override
  _CreateContenantPageState createState() => _CreateContenantPageState();
}

class _CreateContenantPageState extends State<CreateContenantPage> {
  //For Create Contenant
  final _createContenantKeyForm = GlobalKey<FormState>();
  TextEditingController _barCodeContenantController = TextEditingController();
  String _statusContenant = 'Disponible';
  String choiceTypeContenant = 'None';
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
    double page_width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      header(context: context),
      menu(context: context),
      Container(
          decoration: BoxDecoration(
            color: Color(graphique.color['default_yellow']),
            border: Border(
              bottom: BorderSide(
                  width: 1.0, color: Color(graphique.color['default_black'])),
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
                        text: graphique.languagefr['contenant_page']
                            ['nom_page'],
                        style: TextStyle(
                            color: Color(graphique.color['default_red']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ContenantPage()));
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
                      text: graphique.languagefr['create_contenant_page']
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
        alignment: Alignment(-0.9, 0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
          ),
          width: page_width,
          height: 600,
          decoration: BoxDecoration(
            color: Color(graphique.color['special_bureautique_2']),
            border: Border.all(
                width: 1.0, color: Color(graphique.color['default_black'])),
          ),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(graphique.color['main_color_1']),
                  border: Border.all(
                      width: 1.0,
                      color: Color(graphique.color['default_black'])),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      FontAwesomeIcons.boxOpen,
                      size: 17,
                      color: Color(graphique.color['main_color_2']),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['create_contenant_page']
                          ['form_title'],
                      style: TextStyle(
                        color: Color(graphique.color['main_color_2']),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 60,
                decoration: BoxDecoration(
                  color: Color(graphique.color['main_color_1']),
                  border: Border.all(
                      width: 1.0,
                      color: Color(graphique.color['default_black'])),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      FontAwesomeIcons.cog,
                      size: 15,
                      color: Color(graphique.color['main_color_2']),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['create_contenant_page']
                          ['form_subtitle'],
                      style: TextStyle(
                        color: Color(graphique.color['main_color_2']),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 300,
                width: page_width * 2 / 3,
                decoration: BoxDecoration(
                  color: Color(graphique.color['special_bureautique_2']),
                  // border: Border.all(width: 1.0),
                ),
                child: Form(
                    key: _createContenantKeyForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 400,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color(graphique.color['main_color_1']),
                            ),
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2'])),
                            cursorColor: Color(graphique.color['main_color_2']),
                            controller: _barCodeContenantController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['create_contenant_page']
                                      ['field_1_title'],
                              labelStyle: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(graphique.color['main_color_2']),
                                ),
                              ),
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
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: 400,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color(graphique.color['main_color_1']),
                            ),
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.cube,
                                size: 15,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_contenant_page']
                                      ['field_2_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(width: 10),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("TypeContenant")
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
                                          choiceTypeContenant = changedValue!;
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
                                          child: Text(
                                            document_typecontenant.id,
                                            style: TextStyle(
                                                color: Color(graphique
                                                    .color['main_color_2']),
                                                fontSize: 15),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                graphique.languagefr['create_contenant_page']
                                    ['field_3_title'],
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Color(graphique.color['default_black']),
                                    fontWeight: FontWeight.w600),
                              ),
                              //bug with Radio
                              Radio(
                                value: 'Disponible',
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
                                graphique.languagefr['create_contenant_page']
                                    ['field_3_choice_1'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                              ),
                              Radio(
                                value: 'PasDisponible',
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
                                graphique.languagefr['create_contenant_page']
                                    ['field_3_choice_2'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                width: page_width * 3 / 4,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(graphique.color['main_color_1']),
                  border: Border.all(
                      width: 1.0,
                      color: Color(graphique.color['default_black'])),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color(graphique.color['default_yellow']),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(
                            right: 10, top: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ContenantPage()));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Color(graphique.color['default_black']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                graphique.languagefr['create_contenant_page']
                                    ['button_2'],
                                style: TextStyle(
                                  color:
                                      Color(graphique.color['default_black']),
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
                            color: Color(graphique.color['default_yellow']),
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
                                DocumentReference doc_ref = FirebaseFirestore
                                    .instance
                                    .collection("TypeContenant")
                                    .doc(choiceTypeContenant);

                                DocumentSnapshot docSnap = await doc_ref.get();
                                await _typecontenant
                                    .doc(choiceTypeContenant)
                                    .update({
                                  'nombre': (int.parse(docSnap['nombre']) + 1)
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
                                  print("Contenant Added");
                                  Fluttertoast.showToast(
                                      msg: "Contenant Added",
                                      gravity: ToastGravity.TOP);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ContenantPage()));
                                }).catchError((error) =>
                                    print("Failed to add user: $error"));
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Color(graphique.color['default_black']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                graphique.languagefr['create_matieres_page']
                                    ['button_1'],
                                style: TextStyle(
                                  color:
                                      Color(graphique.color['default_black']),
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
      )
    ])));
  }
}
