import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/menu1/contenant_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/menu2/create_type_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/partenaire_page.dart';

class TypePartenairePage extends StatefulWidget {
  @override
  _TypePartenairePageState createState() => _TypePartenairePageState();
}

class _TypePartenairePageState extends State<TypePartenairePage> {
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference _typepartenaire =
      FirebaseFirestore.instance.collection("TypePartenaire");
  Stream<QuerySnapshot> _typepartenaireStream = FirebaseFirestore.instance
      .collection("TypePartenaire")
      .where('idTypePartenaire', isNotEqualTo: 'null')
      .snapshots();
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
                              text: graphique.languagefr['partenaire_page']
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
                                              PartenairePage()));
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
                            text: graphique.languagefr['type_partenaire_page']
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
                  height: 1000,
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
                                      FontAwesomeIcons.flagCheckered,
                                      size: 17,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      graphique.languagefr[
                                              'type_partenaire_page']
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
                                                  CreateTypePartenairePage()));
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
                                                  'type_partenaire_page']
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
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            graphique.languagefr['type_partenaire_page']
                                ['column_1_title'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 200,
                          ),
                          Text(
                            graphique.languagefr['type_partenaire_page']
                                ['column_2_title'],
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
                      stream: _typepartenaireStream,
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
                              .map((DocumentSnapshot document_typepartenaire) {
                            Map<String, dynamic> typepartenaire =
                                document_typepartenaire.data()!
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 50),
                                      alignment: Alignment.centerLeft,
                                      width: 250,
                                      height: 50,
                                      color: Color(graphique
                                          .color['special_bureautique_2']),
                                      child: Text(
                                          typepartenaire['nomTypePartenaire'],
                                          style: TextStyle(
                                              color: Color(graphique
                                                  .color['default_black']),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 50),
                                      alignment: Alignment.centerLeft,
                                      width: 100,
                                      height: 50,
                                      color: Color(graphique
                                          .color['special_bureautique_2']),
                                      child: Text(typepartenaire['nombre'],
                                          style: TextStyle(
                                              color: Color(graphique
                                                  .color['default_black']),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
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
}
