import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/create_matiere_page.dart';
import 'package:tn09_app_web_demo/pages/modify_matiere_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class MatieresPage extends StatefulWidget {
  @override
  _MatieresPageState createState() => _MatieresPageState();
}

class _MatieresPageState extends State<MatieresPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // For Matiere
  CollectionReference _matiere =
      FirebaseFirestore.instance.collection("Matiere");

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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                                    color:
                                        Color(graphique.color['default_red']),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
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
                              text: graphique.languagefr['matieres_page']
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
                  ),
                )),
            Align(
              alignment: Alignment(-0.9, 0),
              child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                  ),
                  width: page_width,
                  height: 1000,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(graphique.color['main_color_1']),
                          border: Border.all(
                              width: 1.0,
                              color: Color(graphique.color['default_black'])),
                        ),
                        width: page_width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.tags,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Matières collectées ',
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
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Color(
                                        graphique.color['default_yellow']),
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.only(
                                    right: 10, top: 20, bottom: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateMatierePage()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(
                                            graphique.color['default_black']),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'New Matiere',
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
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['matieres_page']
                                        ['column_1_title'],
                                    style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 360),
                              child: Text(
                                graphique.languagefr['matieres_page']
                                    ['column_2_title'],
                                style: TextStyle(
                                  color: Color(graphique.color['main_color_2']),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 200),
                              child: Text(
                                graphique.languagefr['matieres_page']
                                    ['column_3_title'],
                                style: TextStyle(
                                  color: Color(graphique.color['main_color_2']),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _matiere.orderBy('nomMatiere').snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('${snapshot.error.toString()}');
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            // print('$snapshot');

                            return SingleChildScrollView(
                              child: Column(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> matiere =
                                      document.data()! as Map<String, dynamic>;
                                  // print('$collecteur');
                                  if (matiere['idMatiere'] == 'null') {
                                    return SizedBox.shrink();
                                  } else if (matiere['idMatiereParente'] !=
                                      'null') {
                                    return Container(
                                      width: page_width,
                                      height: 100,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      decoration: BoxDecoration(
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
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
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Icon(
                                                FontAwesomeIcons.tag,
                                                size: 15,
                                                color: Color(int.parse(
                                                    matiere['colorMatiere'])),
                                              )),
                                          Container(
                                              width: 200,
                                              margin: EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: matiere[
                                                                'nomMatiere'],
                                                            style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushReplacement(MaterialPageRoute(
                                                                            builder: (context) => ModifyMatierePage(
                                                                                  dataMatiere: matiere,
                                                                                )));
                                                                  }),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .levelDownAlt,
                                                          size: 12,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: StreamBuilder<
                                                              QuerySnapshot>(
                                                            stream: _matiere
                                                                .where(
                                                                    'idMatiere',
                                                                    isEqualTo:
                                                                        matiere[
                                                                            'idMatiereParente'])
                                                                .limit(1)
                                                                .snapshots(),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                print(
                                                                    '${snapshot.error.toString()}');
                                                                return Text(
                                                                    'Something went wrong');
                                                              }

                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return CircularProgressIndicator();
                                                              }
                                                              // print('$snapshot');

                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: snapshot
                                                                    .data!.docs
                                                                    .map((DocumentSnapshot
                                                                        document_MatiereParente) {
                                                                  Map<String,
                                                                          dynamic>
                                                                      matiereParente =
                                                                      document_MatiereParente
                                                                              .data()!
                                                                          as Map<
                                                                              String,
                                                                              dynamic>;
                                                                  return Container(
                                                                    child:
                                                                        RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: <
                                                                            TextSpan>[
                                                                          TextSpan(
                                                                              text: matiereParente['nomMatiere'],
                                                                              style: TextStyle(
                                                                                color: Color(graphique.color['default_black']),
                                                                                fontSize: 15,
                                                                              ),
                                                                              recognizer: TapGestureRecognizer()
                                                                                ..onTap = () {
                                                                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                                      builder: (context) => ModifyMatierePage(
                                                                                            dataMatiere: matiereParente,
                                                                                          )));
                                                                                }),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 250),
                                            child: Text(
                                              matiere['referenceMatiere'] == ''
                                                  ? 'N/A'
                                                  : matiere['referenceMatiere'],
                                              style: TextStyle(
                                                color: Color(graphique
                                                    .color['default_black']),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 280),
                                            child: Text(
                                              matiere['traitementMatiere'] ==
                                                      null
                                                  ? 'N/A'
                                                  : matiere[
                                                      'traitementMatiere'],
                                              style: TextStyle(
                                                color: Color(graphique
                                                    .color['default_black']),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 80),
                                            width: 30,
                                            color: Color(graphique.color[
                                                'special_bureautique_2']),
                                            child: IconButton(
                                              icon: const Icon(Icons.edit),
                                              tooltip: 'Modify Matiere',
                                              onPressed: () {
                                                //print('Modify Matiere');
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ModifyMatierePage(
                                                                  dataMatiere:
                                                                      matiere,
                                                                )));
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            width: 50,
                                            color: Color(graphique.color[
                                                'special_bureautique_2']),
                                            child: IconButton(
                                              icon: const Icon(
                                                  FontAwesomeIcons.truck),
                                              tooltip:
                                                  'Historique des collectes',
                                              onPressed: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: page_width,
                                      height: 80,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      decoration: BoxDecoration(
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Icon(
                                                FontAwesomeIcons.tag,
                                                size: 15,
                                                color: Color(int.parse(
                                                    matiere['colorMatiere'])),
                                              )),
                                          Container(
                                            width: 200,
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          matiere['nomMatiere'],
                                                      style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ModifyMatierePage(
                                                                                dataMatiere: matiere,
                                                                              )));
                                                            }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 250),
                                            child: Text(
                                              matiere['referenceMatiere'] == ''
                                                  ? 'N/A'
                                                  : matiere['referenceMatiere'],
                                              style: TextStyle(
                                                color: Color(graphique
                                                    .color['default_black']),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 280),
                                            child: Text(
                                              matiere['traitementMatiere'] ==
                                                      null
                                                  ? 'N/A'
                                                  : matiere[
                                                      'traitementMatiere'],
                                              style: TextStyle(
                                                color: Color(graphique
                                                    .color['default_black']),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 80),
                                            width: 30,
                                            color: Color(graphique.color[
                                                'special_bureautique_2']),
                                            child: IconButton(
                                              icon: const Icon(Icons.edit),
                                              tooltip: 'Modify Matiere',
                                              onPressed: () {
                                                //print('Modify Matiere');
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ModifyMatierePage(
                                                                  dataMatiere:
                                                                      matiere,
                                                                )));
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            width: 50,
                                            color: Color(graphique.color[
                                                'special_bureautique_2']),
                                            child: IconButton(
                                              icon: const Icon(
                                                  FontAwesomeIcons.truck),
                                              tooltip:
                                                  'Historique des collectes',
                                              onPressed: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                }).toList(),
                              ),
                            );
                          },
                        ),
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
