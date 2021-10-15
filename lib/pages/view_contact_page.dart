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
import 'package:tn09_app_web_demo/pages/math_function/check_email.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_telephone.dart';
import 'package:tn09_app_web_demo/pages/math_function/conver_string_bool.dart';
import 'package:tn09_app_web_demo/pages/math_function/generate_password.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/view_partenaire_page.dart';

class ViewContactPage extends StatefulWidget {
  Map dataContact;
  Map partenaire;
  String from;
  ViewContactPage(
      {required this.partenaire,
      required this.dataContact,
      required this.from});
  @override
  _ViewContactPageState createState() => _ViewContactPageState();
}

class _ViewContactPageState extends State<ViewContactPage> {
  //For View Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  final _viewContactKeyForm = GlobalKey<FormState>();
  TextEditingController _nomContactController = TextEditingController();
  TextEditingController _prenomContractController = TextEditingController();
  TextEditingController _telephone1ContactController = TextEditingController();
  TextEditingController _telephone2ContactController = TextEditingController();
  TextEditingController _emailContactController = TextEditingController();
  TextEditingController _passwordContactController = TextEditingController();
  TextEditingController _noteContactController = TextEditingController();
  getInputContact() async {
    await _contact
        .where('idContact', isEqualTo: widget.dataContact['idContact'])
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> dataContact = doc.data()! as Map<String, dynamic>;
        _nomContactController.text = dataContact['nomContact'];
        _prenomContractController.text = dataContact['prenomContact'];
        _telephone1ContactController.text = dataContact['telephone1Contact'];
        _telephone2ContactController.text = dataContact['telephone2Contact'];
        _emailContactController.text = dataContact['emailContact'];
        _passwordContactController.text = dataContact['passwordContact'];
        _noteContactController.text = dataContact['noteContact'];
      });
    });
  }

  //For partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  //for controll table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");

  @override
  Widget build(BuildContext context) {
    getInputContact();
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
                        text: 'Contact',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ContactPage()));
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
                      text: widget.dataContact['nomContact'] +
                          ' ' +
                          widget.dataContact['prenomContact'],
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
                            FontAwesomeIcons.user,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'View Contact',
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
                    key: _viewContactKeyForm,
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
                              if (!checkTelephone(
                                      _telephone1ContactController.text) &&
                                  _telephone1ContactController
                                      .text.isNotEmpty) {
                                return 'Telephone format is: 0xxxxxxxxx';
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
                              if (!checkTelephone(
                                      _telephone2ContactController.text) &&
                                  _telephone2ContactController
                                      .text.isNotEmpty) {
                                return 'Telephone format is: 0xxxxxxxxx';
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
                              if (!checkEmail(_emailContactController.text) &&
                                  _emailContactController.text.isNotEmpty) {
                                return 'Please Input a true Email';
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
                                readOnly: true,
                                controller: _passwordContactController,
                                decoration: InputDecoration(
                                  labelText: 'Password:',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                                onPressed: () {
                                  final password = generatePassword();
                                  _passwordContactController.text = password;
                                },
                                icon: Icon(
                                  FontAwesomeIcons.syncAlt,
                                  size: 17,
                                  color: Colors.black,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  final data = ClipboardData(
                                      text: _passwordContactController.text);
                                  Clipboard.setData(data);

                                  Fluttertoast.showToast(
                                      msg: "Password Copy",
                                      gravity: ToastGravity.TOP);

                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar();
                                },
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
                                decoration:
                                    InputDecoration.collapsed(hintText: "Note"),
                              ),
                            )),
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
                              if (widget.from == 'contactpage') {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ContactPage()));
                              } else {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewPartenairePage(
                                                partenaire:
                                                    widget.partenaire)));
                              }
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
                              if (_viewContactKeyForm.currentState!
                                  .validate()) {
                                await _contact
                                    .where('idContact',
                                        isEqualTo:
                                            widget.dataContact['idContact'])
                                    .limit(1)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    _contact.doc(doc.id).update({
                                      'nomContact': _nomContactController.text,
                                      'prenomContact':
                                          _prenomContractController.text,
                                      'telephone1Contact':
                                          _telephone1ContactController.text,
                                      'telephone2Contact':
                                          _telephone2ContactController.text,
                                      'noteContact':
                                          _noteContactController.text,
                                      'emailContact':
                                          _emailContactController.text,
                                      'passwordContact':
                                          _passwordContactController.text,
                                    }).then((value) {
                                      print("Contact Modified");
                                      Fluttertoast.showToast(
                                          msg: "Contact Modified",
                                          gravity: ToastGravity.TOP);
                                      if (widget.from == 'contactpage') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ContactPage()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPartenairePage(
                                                        partenaire: widget
                                                            .partenaire)));
                                      }
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
                    ],
                  ),
                ),
              ])))
    ])));
  }
}
