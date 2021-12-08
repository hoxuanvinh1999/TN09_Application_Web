// ignore_for_file: prefer_final_fields, unnecessary_null_comparison, unused_local_variable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/menu1/create_collecteur_page.dart';
import 'package:tn09_app_web_demo/pages/menu1/modify_collecteur_page.dart';

class CollecteurPage extends StatefulWidget {
  @override
  _CollecteurPageState createState() => _CollecteurPageState();
}

class _CollecteurPageState extends State<CollecteurPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _createCollecteurKeyForm = GlobalKey<FormState>();
  final _modifyCollecteurKeyForm = GlobalKey<FormState>();
  String _siteCollecteur = 'Bordeaux';
  List<String> list_site = ['Bordeaux', 'Paris', 'Lille'];
  TextEditingController _nomCollecteurController = TextEditingController();
  TextEditingController _prenomCollecteurController = TextEditingController();
  TextEditingController _nomModifyCollecteurController =
      TextEditingController();
  TextEditingController _prenomModifyCollecteurController =
      TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  Stream<QuerySnapshot> _collecteurStream = FirebaseFirestore.instance
      .collection("Collecteur")
      .orderBy('nomCollecteur')
      .snapshots();

  DateTime date = DateTime.now();

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 25),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  @override
  Widget build(BuildContext context) {
    // Fow width of table
    double page_width = MediaQuery.of(context).size.width * 0.5;
    // inputData();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context: context),
            menu(
              context: context,
            ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            text: graphique.languagefr['collecteur_page']
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
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  width: page_width,
                  height: 2000,
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
                                    Icons.people,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['collecteur_page']
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
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Color(
                                        graphique.color['default_yellow']),
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.only(
                                    right: 10, top: 20, bottom: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    // showCreateCollecteur();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateCollecteurPage()));
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
                                        graphique.languagefr['collecteur_page']
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
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: page_width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(graphique.color['main_color_1']),
                          border: Border.all(
                              width: 1.0,
                              color: Color(graphique.color['default_black'])),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                graphique.languagefr['collecteur_page']
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
                                graphique.languagefr['collecteur_page']
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
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _collecteurStream,
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
                                  Map<String, dynamic> collecteur =
                                      document.data()! as Map<String, dynamic>;
                                  // print('$collecteur');
                                  if (collecteur['idCollecteur'] == 'null') {
                                    return const SizedBox.shrink();
                                  }
                                  return Container(
                                    width: page_width,
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
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            width: 200,
                                            height: 50,
                                            color: Color(graphique.color[
                                                'special_bureautique_2']),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  collecteur['nomCollecteur'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  collecteur[
                                                      'prenomCollecteur'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            height: 50,
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            color: Color(graphique.color[
                                                'special_bureautique_2']),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.place,
                                                  color: Color(graphique
                                                      .color['default_black']),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  collecteur['siteCollecteur'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            color: Color(graphique.color[
                                                'special_bureautique_2']),
                                            child: IconButton(
                                              icon: const Icon(Icons.edit),
                                              color: Color(graphique
                                                  .color['default_black']),
                                              tooltip: graphique.languagefr[
                                                      'collecteur_page']
                                                  ['icon_button_1_title'],
                                              onPressed: () {
                                                // showModifyCollecteurDialog(
                                                //     context: context,
                                                //     dataCollecteur: collecteur);
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ModifyCollecteurPage(
                                                                  dataCollecteur:
                                                                      collecteur,
                                                                )));
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
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

  showCreateCollecteur() {
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
                        'New Collecteur',
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
                        key: _createCollecteurKeyForm,
                        child: Column(
                          children: [
                            Container(
                              width: 400,
                              color: Colors.red,
                              child: TextFormField(
                                controller: _nomCollecteurController,
                                decoration: InputDecoration(
                                  labelText: 'Nom* :',
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
                              color: Colors.red,
                              child: TextFormField(
                                controller: _prenomCollecteurController,
                                decoration: InputDecoration(
                                  labelText: 'Prenom* :',
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
                                  Text('Site',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  //dropdown have bug
                                  DropdownButton<String>(
                                      onChanged: (String? changedValue) {
                                        setState(() {
                                          _siteCollecteur = changedValue!;
                                          print(
                                              '$_siteCollecteur  $changedValue');
                                        });
                                      },
                                      value: _siteCollecteur,
                                      items: list_site.map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList()),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              //Date de naissance still bug
                              width: 400,
                              height: 100,
                              color: Colors.blue,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Date de Naissance',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 50,
                                    width: 150,
                                    color: Colors.red,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          pickDate(context);
                                        },
                                        child: Text(
                                          DateFormat('yMd')
                                              .format(date)
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        )),
                                  )
                                ],
                              ),
                            ),
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
                                _nomCollecteurController.text = '';
                                _prenomCollecteurController.text = '';
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
                                if (_createCollecteurKeyForm.currentState!
                                    .validate()) {
                                  String newIdCollecteur = _collecteur.doc().id;
                                  await _collecteur.doc(newIdCollecteur).set({
                                    'nomCollecteur':
                                        _nomCollecteurController.text,
                                    'prenomCollecteur':
                                        _prenomCollecteurController.text,
                                    'siteCollecteur': _siteCollecteur,
                                    'datedeNaissance': DateFormat('yMd')
                                        .format(date)
                                        .toString(),
                                    'idCollecteur': newIdCollecteur,
                                  }).then((value) {
                                    _nomCollecteurController.text = '';
                                    _prenomCollecteurController.text = '';
                                    print("Collecteur Added");
                                    Navigator.of(context).pop();
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

  showModifyCollecteurDialog(
      {required BuildContext context, required Map dataCollecteur}) {
    String siteModifyCollecteur = dataCollecteur['siteCollecteur'];
    _nomModifyCollecteurController.text = dataCollecteur['nomCollecteur'];
    _prenomModifyCollecteurController.text = dataCollecteur['prenomCollecteur'];
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
                        'Modify Collecteur',
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
                        key: _modifyCollecteurKeyForm,
                        child: Column(
                          children: [
                            Container(
                              width: 400,
                              color: Colors.red,
                              child: TextFormField(
                                controller: _nomModifyCollecteurController,
                                decoration: InputDecoration(
                                  labelText: 'Nom* :',
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
                              color: Colors.red,
                              child: TextFormField(
                                controller: _prenomModifyCollecteurController,
                                decoration: InputDecoration(
                                  labelText: 'Prenom* :',
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
                                  Text('Site',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  //dropdown have bug
                                  DropdownButton<String>(
                                      onChanged: (String? changedValue) {
                                        setState(() {
                                          _siteCollecteur = changedValue!;
                                          print(
                                              '$_siteCollecteur  $changedValue');
                                        });
                                      },
                                      value: _siteCollecteur,
                                      items: list_site.map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList()),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              //Date de naissance still bug
                              width: 400,
                              height: 100,
                              color: Colors.blue,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Date de Naissance',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 50,
                                    width: 150,
                                    color: Colors.red,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          pickDate(context);
                                        },
                                        child: Text(
                                          DateFormat('yMd')
                                              .format(date)
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        )),
                                  )
                                ],
                              ),
                            ),
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
                                _nomModifyCollecteurController.text = '';
                                _prenomModifyCollecteurController.text = '';
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
                                //Update data
                                await _collecteur
                                    .where('idCollecteur',
                                        isEqualTo:
                                            dataCollecteur['idCollecteur'])
                                    .limit(1)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    _collecteur.doc(doc.id).update({
                                      'nomCollecteur':
                                          _nomModifyCollecteurController.text,
                                      'prenomCollecteur':
                                          _prenomModifyCollecteurController
                                              .text,
                                      'siteCollecteur': _siteCollecteur,
                                      'datedeNaissance': DateFormat('yMd')
                                          .format(date)
                                          .toString(),
                                    }).then((value) {
                                      _nomModifyCollecteurController.text = '';
                                      _prenomModifyCollecteurController.text =
                                          '';
                                      print("Collecteur Update");
                                      Navigator.of(context).pop();
                                    }).catchError((error) =>
                                        print("Failed to update user: $error"));
                                  });
                                });
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
}
