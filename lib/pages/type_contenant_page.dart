import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/contenant_page.dart';
import 'package:tn09_app_web_demo/pages/create_type_contenant_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

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
    // Fow width of table
    double page_width = MediaQuery.of(context).size.width * 0.8;
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
                    const SizedBox(
                      width: 5,
                    ),
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
                    const Icon(
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
                                  color: Color(graphique.color['default_red']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ContenantPage()));
                                }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
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
                            text: graphique.languagefr['type_contenant_page']
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 240,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.cubes,
                                      size: 17,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      graphique
                                              .languagefr['type_contenant_page']
                                          ['table_title'],
                                      style: TextStyle(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          graphique.color['default_yellow']),
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
                                          color: Color(
                                              graphique.color['default_black']),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          graphique.languagefr[
                                                  'type_contenant_page']
                                              ['button_1'],
                                          style: TextStyle(
                                            color: Color(graphique
                                                .color['default_black']),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
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
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            graphique.languagefr['type_contenant_page']
                                ['column_1_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 130,
                          ),
                          Text(
                            graphique.languagefr['type_contenant_page']
                                ['column_2_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            graphique.languagefr['type_contenant_page']
                                ['column_3_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Text(
                            graphique.languagefr['type_contenant_page']
                                ['column_4_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Icon(
                            FontAwesomeIcons.weight,
                            size: 17,
                            color: Color(graphique.color['main_color_2']),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Icon(
                            FontAwesomeIcons.weightHanging,
                            size: 17,
                            color: Color(graphique.color['main_color_2']),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            graphique.languagefr['type_contenant_page']
                                ['column_5_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
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
                            color: Color(graphique.color['main_color_2']),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            graphique.languagefr['type_contenant_page']
                                ['column_6_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              width: page_width,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Color(
                                    graphique.color['special_bureautique_2']),
                                border: Border(
                                    top: BorderSide(
                                        width: 1.0,
                                        color: Color(
                                            graphique.color['default_black'])),
                                    bottom: BorderSide(
                                        width: 1.0,
                                        color: Color(
                                            graphique.color['default_black']))),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      width: 200,
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
                                            document_typecontenant.id,
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
                                        margin: const EdgeInsets.only(left: 30),
                                        width: 50,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: buildStatusIcon(
                                            iconstatus:
                                                typecontenant['collecte'])),
                                    Container(
                                        margin: const EdgeInsets.only(left: 60),
                                        width: 50,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: buildStatusIcon(
                                            iconstatus:
                                                typecontenant['prepare'])),
                                    Container(
                                        margin: const EdgeInsets.only(left: 70),
                                        width: 50,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: buildStatusIcon(
                                            iconstatus:
                                                typecontenant['pesee'])),
                                    Container(
                                      margin: const EdgeInsets.only(left: 80),
                                      width: 80,
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
                                            typecontenant['poidContenant'] +
                                                ' kg',
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
                                      margin: const EdgeInsets.only(left: 30),
                                      width: 80,
                                      height: 50,
                                      color: Color(graphique
                                          .color['special_bureautique_2']),
                                      child: Row(
                                        children: [
                                          Text(
                                            typecontenant[
                                                    'limitpoidContenant'] +
                                                ' kg',
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
                                      margin: const EdgeInsets.only(left: 50),
                                      width: 50,
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
                                            typecontenant['nombre'],
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
                                      margin: const EdgeInsets.only(left: 30),
                                      width: 50,
                                      height: 50,
                                      color: Color(graphique
                                          .color['special_bureautique_2']),
                                      child: IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: Color(
                                            graphique.color['default_black']),
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
                              ),
                            );
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
