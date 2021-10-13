import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/create_contact_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/view_contact_page.dart';
import 'package:tn09_app_web_demo/pages/view_partenaire_page.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // for partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");

  //For contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  Stream<QuerySnapshot> _contactStream = FirebaseFirestore.instance
      .collection("Contact")
      .where('idContact', isNotEqualTo: 'null')
      .snapshots();
  // null Map
  Map<String, String> nullPartenaire = {};
  // for partenaire
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
              width: 1200,
              height: 1500,
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
                            FontAwesomeIcons.user,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Contact',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 900,
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
                                              CreateContactPage()));
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
                                      'New Contact',
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
                              'Prenom et nom',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 250,
                            ),
                            Text(
                              'Telephone(s)',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                            ),
                            Text(
                              'Partenaire(s)',
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
                Container(
                  height: 1000,
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _contactStream,
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
                            Map<String, dynamic> contact =
                                document.data()! as Map<String, dynamic>;
                            return Container(
                                height:
                                    // 50 +
                                    //     double.parse(contact['nombredePartenaire']) *
                                    //         50,
                                    100,
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
                                          width: 200,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.user,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: limitString(
                                                            text: contact[
                                                                    'nomContact'] +
                                                                ' ' +
                                                                contact[
                                                                    'prenomContact'],
                                                            limit_long: 15),
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                    builder: (context) => ViewContactPage(
                                                                        partenaire:
                                                                            nullPartenaire,
                                                                        from:
                                                                            'contactpage',
                                                                        dataContact:
                                                                            contact)));
                                                              }),
                                                  ],
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
                                          width: 300,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.envelope,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                contact['emailContact'],
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
                                          width: 20,
                                        ),
                                        Container(
                                          alignment: Alignment(-1, 0.15),
                                          width: 300,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons.phone,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        contact[
                                                            'telephone1Contact'],
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
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons.phone,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        contact[
                                                            'telephone2Contact'],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          height: 50,
                                          width: 200,
                                          color: Colors.green,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _contactpartenaire
                                                .where('idContact',
                                                    isEqualTo:
                                                        contact['idContact'])
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              // print('snapshot ${snapshot.data}');
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Something went wrong');
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_link_contactpartenaire) {
                                                    Map<String, dynamic>
                                                        link_contactpartenaire =
                                                        document_link_contactpartenaire
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    // print('link_contactadresse $link_contactadresse');
                                                    return Container(
                                                      color: Colors.green,
                                                      child: StreamBuilder<
                                                          QuerySnapshot>(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Partenaire")
                                                            .where(
                                                                'idPartenaire',
                                                                isEqualTo:
                                                                    link_contactpartenaire[
                                                                        'idPartenaire'])
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    QuerySnapshot>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Something went wrong');
                                                          }

                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return CircularProgressIndicator();
                                                          }
                                                          return Column(
                                                            children: snapshot
                                                                .data!.docs
                                                                .map((DocumentSnapshot
                                                                    document_partenaire) {
                                                              Map<String,
                                                                      dynamic>
                                                                  insidedataPartenaire =
                                                                  document_partenaire
                                                                          .data()!
                                                                      as Map<
                                                                          String,
                                                                          dynamic>;

                                                              // print(
                                                              //     'insidedataContact $insidedataContact');
                                                              return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        RichText(
                                                                          text:
                                                                              TextSpan(
                                                                            children: <TextSpan>[
                                                                              TextSpan(
                                                                                  text: limitString(text: insidedataPartenaire['nomPartenaire'], limit_long: 15),
                                                                                  style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                  recognizer: TapGestureRecognizer()
                                                                                    ..onTap = () {
                                                                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ViewPartenairePage(partenaire: insidedataPartenaire)));
                                                                                    }),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                  ]);
                                                            }).toList(),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              );
                                            },
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
                                ));
                          }).toList(),
                        );
                      },
                    ),
                  ),
                )
              ]))),
    ])));
  }
}
