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
import 'package:tn09_app_web_demo/pages/menu1/collecteur_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/menu1/vehicule_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class CreateCollecteurPage extends StatefulWidget {
  @override
  _CreateCollecteurPageState createState() => _CreateCollecteurPageState();
}

class _CreateCollecteurPageState extends State<CreateCollecteurPage> {
  //For Create Collecteur
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _createCollecteurKeyForm = GlobalKey<FormState>();
  String _siteCollecteur = 'Bordeaux';
  List<String> list_site = ['Bordeaux', 'Paris', 'Lille'];
  TextEditingController _nomCollecteurController = TextEditingController();
  TextEditingController _prenomCollecteurController = TextEditingController();
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");

  // For get Date
  DateTime date = DateTime.now();

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
              Icon(
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
                            color: Color(graphique.color['default_red']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => VehiculePage()));
                          }),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
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
                      text: graphique.languagefr['create_collecteur_page']
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
        alignment: const Alignment(-0.9, 0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
          ),
          width: page_width,
          height: 800,
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
                    const SizedBox(width: 20),
                    Icon(
                      FontAwesomeIcons.user,
                      size: 17,
                      color: Color(graphique.color['main_color_2']),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['create_collecteur_page']
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
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      FontAwesomeIcons.cog,
                      size: 15,
                      color: Color(graphique.color['main_color_2']),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['create_collecteur_page']
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
                height: 450,
                width: page_width * 2 / 3,
                decoration: BoxDecoration(
                  color: Color(graphique.color['special_bureautique_2']),
                  // border: Border.all(width: 1.0),
                ),
                child: Form(
                    key: _createCollecteurKeyForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2'])),
                            cursorColor: Color(graphique.color['main_color_2']),
                            controller: _nomCollecteurController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['create_collecteur_page']
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
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2'])),
                            cursorColor: Color(graphique.color['main_color_2']),
                            controller: _prenomCollecteurController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['create_collecteur_page']
                                      ['field_2_title'],
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
                              Icon(
                                Icons.place,
                                size: 15,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_collecteur_page']
                                      ['field_3_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                width: 10,
                              ),
                              DropdownButton<String>(
                                  onChanged: (String? changedValue) {
                                    setState(() {
                                      _siteCollecteur = changedValue!;
                                      // print('$_siteCollecteur  $changedValue');
                                    });
                                  },
                                  value: _siteCollecteur,
                                  items: list_site.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Color(
                                              graphique.color['main_color_2']),
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  }).toList()),
                            ],
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
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 15,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  MediaQuery.of(context).size.width >= 900
                                      ? graphique.languagefr[
                                              'create_collecteur_page']
                                          ['field_4_title']
                                      : '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                width: 10,
                              ),
                              // ignore: sized_box_for_whitespace
                              Container(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                    onPressed: () {
                                      pickDate(context);
                                    },
                                    child: Text(
                                      getDateText(date: date),
                                      style: TextStyle(
                                          color: Color(
                                              graphique.color['default_black']),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                        ),
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
                                    builder: (context) => CollecteurPage()));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Color(graphique.color['default_black']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                graphique.languagefr['create_collecteur_page']
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
                            if (_createCollecteurKeyForm.currentState!
                                .validate()) {
                              String newIdCollecteur = _collecteur.doc().id;
                              await _collecteur.doc(newIdCollecteur).set({
                                'nomCollecteur': _nomCollecteurController.text,
                                'prenomCollecteur':
                                    _prenomCollecteurController.text,
                                'siteCollecteur': _siteCollecteur,
                                'datedeNaissance': getDateText(date: date),
                                'idCollecteur': newIdCollecteur,
                              }).then((value) {
                                print("Vehicule Added");
                                Fluttertoast.showToast(
                                    msg: "Collecteur Added",
                                    gravity: ToastGravity.TOP);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CollecteurPage()));
                              }).catchError((error) =>
                                  print("Failed to add user: $error"));
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Color(graphique.color['default_black']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                graphique.languagefr['create_collecteur_page']
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
