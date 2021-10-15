import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/create_type_contenant_page.dart';

class TypeContenantPage extends StatefulWidget {
  @override
  _TypeContenantPageState createState() => _TypeContenantPageState();
}

class _TypeContenantPageState extends State<TypeContenantPage> {
  final _createContenantKeyForm = GlobalKey<FormState>();
  String _typeContenant = 'Bac 120L';
  List<String> list_type = ['Bac 120L', 'Bac 100L', 'Bac 80L'];
  TextEditingController _barCodeContenantController = TextEditingController();
  TextEditingController _statusContenantController = TextEditingController();
  String _statusContenant = 'Disponible';
  // int id = 1;
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference _typecontenant =
      FirebaseFirestore.instance.collection("TypeContenant");
  Stream<QuerySnapshot> _typecontenantStream = FirebaseFirestore.instance
      .collection("TypeContenant")
      .where('idTypeContenant', isNotEqualTo: 'None')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context: context),
            menu(context: context),
            SizedBox(height: 20),
            Align(
                alignment: Alignment(-0.9, 0),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 1000,
                  height: 1000,
                  color: Colors.green,
                  child: Column(children: [
                    Container(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.objectGroup,
                                      size: 17,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Type Contenant',
                                      style: TextStyle(
                                        color: Colors.black,
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
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateTypeContenantPage()));
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
                                          'New Type Contenant',
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
                                  'Nom du Type',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                Text(
                                  'Collecte',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'Prepare',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'Pesée',
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
                                  FontAwesomeIcons.weight,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Icon(
                                  FontAwesomeIcons.weightHanging,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Limit',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  FontAwesomeIcons.boxOpen,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Nombre',
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
                      stream: _typecontenantStream,
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
                              .map((DocumentSnapshot document_typecontenant) {
                            Map<String, dynamic> typecontenant =
                                document_typecontenant.data()!
                                    as Map<String, dynamic>;
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
                                          width: 200,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Text(
                                                document_typecontenant.id,
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
                                          width: 30,
                                        ),
                                        Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.green,
                                            child: buildStatusIcon(
                                                iconstatus:
                                                    typecontenant['collecte'])),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.green,
                                            child: buildStatusIcon(
                                                iconstatus:
                                                    typecontenant['prepare'])),
                                        SizedBox(
                                          width: 70,
                                        ),
                                        Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.green,
                                            child: buildStatusIcon(
                                                iconstatus:
                                                    typecontenant['pesee'])),
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Container(
                                          alignment: Alignment(-1, 0.15),
                                          width: 80,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Text(
                                                typecontenant['poidContenant'] +
                                                    ' kg',
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
                                          width: 30,
                                        ),
                                        Container(
                                          alignment: Alignment(-1, 0.15),
                                          width: 80,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Text(
                                                typecontenant[
                                                        'limitpoidContenant'] +
                                                    ' kg',
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
                                          width: 50,
                                          height: 50,
                                          color: Colors.green,
                                          child: Row(
                                            children: [
                                              Text(
                                                typecontenant['nombre'],
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
                                          width: 30,
                                        ),
                                        Container(
                                          alignment: Alignment(-1, 0.15),
                                          width: 50,
                                          height: 50,
                                          color: Colors.green,
                                          child: IconButton(
                                            icon: const Icon(Icons.edit),
                                            tooltip: 'Modify Type Contenant',
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

  Widget buildStatusIcon({required String iconstatus}) {
    switch (iconstatus) {
      case 'true':
        {
          return Icon(
            FontAwesomeIcons.check,
            size: 17,
            color: Colors.black,
          );
        }
      case 'false':
        {
          return Icon(
            FontAwesomeIcons.ban,
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
