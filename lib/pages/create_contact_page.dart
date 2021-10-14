import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/contact_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_email.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_telephone.dart';
import 'package:tn09_app_web_demo/pages/math_function/generate_password.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';

class CreateContactPage extends StatefulWidget {
  @override
  _CreateContactPageState createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  //For Create Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  final _createContactKeyForm = GlobalKey<FormState>();
  TextEditingController _nomContactController = TextEditingController();
  TextEditingController _prenomContractController = TextEditingController();
  TextEditingController _telephone1ContactController = TextEditingController();
  TextEditingController _telephone2ContactController = TextEditingController();
  TextEditingController _emailContactController = TextEditingController();
  TextEditingController _passwordContactController = TextEditingController();
  TextEditingController _noteContactController = TextEditingController();
  bool isPrincipal = true;
  bool recoitRapport = false;
  bool recoitFacture = false;
  bool accessExtranet = false;
  String idNewContact = '';
  String newIdContactPartenaire = '';
  String choiceIdPartenaire = 'null'; //for get idPartenaire

  //For partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  //for controll table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");

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
                            FontAwesomeIcons.flag,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Create New Contact',
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
                    key: _createContactKeyForm,
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
                              value: accessExtranet,
                              onChanged: (value) {
                                setState(() {
                                  accessExtranet = !accessExtranet;
                                  print('accessExtranet $accessExtranet');
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
                              Text('Partenaire',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Partenaire")
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
                                          choiceIdPartenaire = changedValue!;
                                        });
                                      },
                                      value: choiceIdPartenaire,
                                      items: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        Map<String, dynamic> partenaire =
                                            document.data()!
                                                as Map<String, dynamic>;

                                        return DropdownMenuItem<String>(
                                          value: partenaire['idPartenaire'],
                                          child: new Text(
                                              partenaire['nomPartenaire']),
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
                            onTap: () async {
                              if (_createContactKeyForm.currentState!
                                  .validate()) {
                                idNewContact = _contact.doc().id.toString();
                                String nombredePartenaire = '0';
                                if (choiceIdPartenaire != 'null') {
                                  nombredePartenaire = '1';
                                  await _partenaire
                                      .where('idPartenaire',
                                          isEqualTo: choiceIdPartenaire)
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      if (doc['nombredeContact'] == '0') {
                                        newIdContactPartenaire = idNewContact;
                                        isPrincipal = true;
                                      } else {
                                        newIdContactPartenaire =
                                            doc['idContactPartenaire'];
                                        isPrincipal = false;
                                      }
                                      _partenaire.doc(doc.id).update({
                                        'nombredeContact':
                                            (int.parse(doc['nombredeContact']) +
                                                    1)
                                                .toString(),
                                        'idContactPartenaire':
                                            newIdContactPartenaire,
                                      });
                                    });
                                  });
                                  await _contactpartenaire
                                      .doc(_contactpartenaire.doc().id)
                                      .set({
                                    'idPartenaire': choiceIdPartenaire,
                                    'idContact': idNewContact,
                                    'isPrincipal': isPrincipal.toString(),
                                  });
                                }
                                await _contact.doc(idNewContact).set({
                                  'nomContact': _nomContactController.text,
                                  'prenomContact':
                                      _prenomContractController.text,
                                  'telephone1Contact':
                                      _telephone1ContactController.text,
                                  'telephone2Contact':
                                      _telephone2ContactController.text,
                                  'noteContact': _noteContactController.text,
                                  'emailContact': _emailContactController.text,
                                  'passwordContact':
                                      _passwordContactController.text,
                                  'accessExtranet': accessExtranet.toString(),
                                  'recoitFacture': recoitFacture.toString(),
                                  'recoitRapport': recoitRapport.toString(),
                                  'nombredePartenaire': nombredePartenaire,
                                  'idContact': idNewContact
                                }).then((value) {
                                  print("Contact Added");
                                  Fluttertoast.showToast(
                                      msg: "Contact Added",
                                      gravity: ToastGravity.TOP);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactPage()));
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
