import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/contenant_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/is_numeric_function.dart';
import 'package:tn09_app_web_demo/pages/type_contenant_page.dart';

class CreateTypeContenantPage extends StatefulWidget {
  @override
  _CreateTypeContenantPageState createState() =>
      _CreateTypeContenantPageState();
}

class _CreateTypeContenantPageState extends State<CreateTypeContenantPage> {
  //For Create Type Contenant
  CollectionReference _typecontenant =
      FirebaseFirestore.instance.collection("TypeContenant");
  final _createContenantKeyForm = GlobalKey<FormState>();
  TextEditingController _nomTypeContenantController = TextEditingController();
  TextEditingController _poidContenantController = TextEditingController();
  TextEditingController _limitPoidContenantController = TextEditingController();
  TextEditingController _noteContenantController = TextEditingController();
  bool prepare = false;
  bool collecte = false;
  bool pesee = false;

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
                        text: 'Contenant',
                        style: TextStyle(
                            color: Colors.red,
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
                        text: 'Type Contenant',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => TypeContenantPage()));
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
                      text: 'Create New Type Contenant',
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
              height: 900,
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
                            'Create New Type Contenant',
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
                  height: 600,
                  width: 800,
                  color: Colors.blue,
                  child: Form(
                    key: _createContenantKeyForm,
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          color: Colors.red,
                          child: TextFormField(
                            controller: _nomTypeContenantController,
                            decoration: InputDecoration(
                              labelText: 'Nom du type*:',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '') {
                                return 'This can not be null';
                              } else if (value.contains('/')) {
                                return 'This name can not have /';
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
                            controller: _poidContenantController,
                            decoration: InputDecoration(
                              labelText: 'Poid*:',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '') {
                                return 'This can not be null';
                              } else if (!isNumericUsing_tryParse(value)) {
                                return 'This must be a number';
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
                            controller: _limitPoidContenantController,
                            decoration: InputDecoration(
                              labelText: 'Limit Poid:',
                            ),
                            validator: (value) {
                              if (value!.isNotEmpty &&
                                  !isNumericUsing_tryParse(value)) {
                                return 'This must be a number';
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
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _noteContenantController,
                                maxLines: 4,
                                decoration:
                                    InputDecoration.collapsed(hintText: "Note"),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Collecter',
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
                              value: collecte,
                              onChanged: (value) {
                                setState(() {
                                  collecte = !collecte;
                                  print('collecte $collecte');
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
                              'Préparer',
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
                              value: prepare,
                              onChanged: (value) {
                                setState(() {
                                  prepare = !prepare;
                                  print('prepare $prepare');
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
                              'Pesée',
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
                              value: pesee,
                              onChanged: (value) {
                                setState(() {
                                  pesee = !pesee;
                                  print('pesee $pesee');
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
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) => ContactPage()));
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
                                QuerySnapshot query = await FirebaseFirestore
                                    .instance
                                    .collection('TypeContenant')
                                    .where('nomTypeContenant',
                                        isEqualTo: _nomTypeContenantController
                                            .text
                                            .toLowerCase()
                                            .replaceAll(' ', ''))
                                    .get();
                                if (query.docs.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg: " We had this type Contenant",
                                      gravity: ToastGravity.TOP);
                                } else {
                                  String idNewTypeContenant =
                                      _nomTypeContenantController.text;
                                  await _typecontenant
                                      .doc(idNewTypeContenant)
                                      .set({
                                    'nomTypeContenant':
                                        _nomTypeContenantController.text
                                            .toLowerCase()
                                            .replaceAll(' ', ''),
                                    'poidContenant':
                                        _poidContenantController.text,
                                    'noteContenant':
                                        _noteContenantController.text,
                                    'limitpoidContenant':
                                        _limitPoidContenantController.text,
                                    'pesee': pesee.toString(),
                                    'collecte': collecte.toString(),
                                    'prepare': prepare.toString(),
                                    'nombre': '0',
                                    'idTypeContenant': idNewTypeContenant
                                  }).then((value) {
                                    print("Type Contenant Added");
                                    Fluttertoast.showToast(
                                        msg: "Type Contenant Added",
                                        gravity: ToastGravity.TOP);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TypeContenantPage()));
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
