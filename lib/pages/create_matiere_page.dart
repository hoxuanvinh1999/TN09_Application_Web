import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/matieres_page.dart';
import 'package:translator/translator.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class CreateMatierePage extends StatefulWidget {
  @override
  _CreateMatierePageState createState() => _CreateMatierePageState();
}

class _CreateMatierePageState extends State<CreateMatierePage> {
  // For Partenaire
  CollectionReference _matiere =
      FirebaseFirestore.instance.collection("Matiere");

  final _createMatiereKeyForm = GlobalKey<FormState>();
  TextEditingController _nomMatiereController = TextEditingController();
  TextEditingController _nomMatiereEnglishController = TextEditingController();
  TextEditingController _referenceMatiereController =
      TextEditingController(text: '');
  TextEditingController _colorMatiereController =
      TextEditingController(text: '0xffffffff');
  Color _colorMatiere = Color(graphique.color['default_white']);
  String matiereparente = 'null';
  String _actifMatiere = 'true';

  @override
  Widget build(BuildContext context) {
    // Fow width of table
    double page_width = MediaQuery.of(context).size.width * 0.7;
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
                        text: graphique.languagefr['matieres_page']['nom_page'],
                        style: TextStyle(
                            color: Color(graphique.color['default_red']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MatieresPage()));
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
                      text: graphique.languagefr['create_matieres_page']
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
              height: 900,
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(children: [
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
                      SizedBox(width: 20),
                      Icon(
                        FontAwesomeIcons.tags,
                        size: 17,
                        color: Color(graphique.color['main_color_2']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        graphique.languagefr['create_matieres_page']
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
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        FontAwesomeIcons.cog,
                        size: 15,
                        color: Color(graphique.color['main_color_2']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        graphique.languagefr['create_matieres_page']
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 550,
                  width: page_width * 2 / 3,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    // border: Border.all(width: 1.0),
                  ),
                  child: Form(
                      key: _createMatiereKeyForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(graphique.color['main_color_1']),
                              ),
                              color: Color(
                                  graphique.color['special_bureautique_1']),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _nomMatiereController,
                              onChanged: (String value) {
                                GoogleTranslator()
                                    .translate(value, from: 'fr', to: 'en')
                                    .then((value) {
                                  setState(() {
                                    _nomMatiereEnglishController.text =
                                        value.toString();
                                  });
                                });
                              },
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_matieres_page']
                                        ['field_1_title'],
                                labelStyle: TextStyle(
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Color(graphique.color['main_color_2']),
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(graphique.color['main_color_1']),
                              ),
                              color: Color(
                                  graphique.color['special_bureautique_1']),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _nomMatiereEnglishController,
                              // onChanged: (String value) {
                              //   GoogleTranslator()
                              //       .translate(value, from: 'en', to: 'fr')
                              //       .then((value) {
                              //     setState(() {
                              //       _nomMatiereController.text =
                              //           value.toString();
                              //     });
                              //   });
                              // },
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_matieres_page']
                                        ['field_2_title'],
                                labelStyle: TextStyle(
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(graphique.color['main_color_1']),
                              ),
                              color: Color(
                                  graphique.color['special_bureautique_1']),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.tag,
                                  size: 15,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr['create_matieres_page']
                                        ['field_3_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("Matiere")
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
                                            matiereparente = changedValue!;
                                          });
                                        },
                                        value: matiereparente,
                                        items: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> matiere =
                                              document.data()!
                                                  as Map<String, dynamic>;

                                          return DropdownMenuItem<String>(
                                            value: matiere['idMatiere'],
                                            child: Text(
                                              matiere['nomMatiere'],
                                              style: TextStyle(
                                                  color: Color(graphique
                                                      .color['main_color_2'])),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(graphique.color['main_color_1']),
                              ),
                              color: Color(
                                  graphique.color['special_bureautique_1']),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _referenceMatiereController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_matieres_page']
                                        ['field_4_title'],
                                labelStyle: TextStyle(
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 400,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(graphique.color['main_color_1']),
                                ),
                                color: Color(
                                    graphique.color['special_bureautique_1']),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.tag,
                                    size: 15,
                                    color: _colorMatiere,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['create_matieres_page']
                                        ['field_5_title'],
                                    style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: const Alignment(-0.8, 0),
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: _colorMatiere,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: GestureDetector(
                                        onTap: () {
                                          pickColor(context);
                                        },
                                        child: Text(
                                          graphique.languagefr[
                                                  'create_matieres_page']
                                              ['field_5_button'],
                                          style: TextStyle(
                                            color: Color(graphique
                                                .color['main_color_2']),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Color(
                                            graphique.color['main_color_1']),
                                      ),
                                      color: Color(graphique
                                          .color['special_bureautique_1']),
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: Color(
                                              graphique.color['main_color_2'])),
                                      cursorColor: Color(
                                          graphique.color['main_color_2']),
                                      controller: _colorMatiereController,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: graphique.languagefr[
                                                'create_matieres_page']
                                            ['field_5_subtitle'],
                                        labelStyle: TextStyle(
                                          color: Color(
                                              graphique.color['main_color_2']),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(graphique
                                                .color['main_color_2']),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: const Alignment(-0.8, 0),
                            width: 400,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(graphique.color['main_color_1']),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  graphique.languagefr['create_matieres_page']
                                      ['field_6_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600),
                                ),
                                Radio(
                                  value: 'true',
                                  groupValue: _actifMatiere,
                                  onChanged: (val) {
                                    setState(() {
                                      _actifMatiere = 'true';
                                    });
                                  },
                                ),
                                Text(
                                  graphique.languagefr['create_matieres_page']
                                      ['field_6_choice_1'],
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(
                                          graphique.color['default_black']),
                                      fontWeight: FontWeight.bold),
                                ),
                                Radio(
                                  value: 'false',
                                  groupValue: _actifMatiere,
                                  onChanged: (val) {
                                    setState(() {
                                      _actifMatiere = 'false';
                                    });
                                  },
                                ),
                                Text(
                                  graphique.languagefr['create_matieres_page']
                                      ['field_6_choice_2'],
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(
                                          graphique.color['default_black']),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  width: 800,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['main_color_1']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
                      ),
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
                                      builder: (context) => MatieresPage()));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  graphique.languagefr['create_matieres_page']
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
                              if (_createMatiereKeyForm.currentState!
                                  .validate()) {
                                String newIdMatiere = _matiere.doc().id;
                                await _matiere.doc(newIdMatiere).set({
                                  'nomMatiere': _nomMatiereController.text,
                                  'nomEnglishMatiere':
                                      _nomMatiereEnglishController.text,
                                  'idMatiereParente': matiereparente,
                                  'actifMatiere': _actifMatiere,
                                  'colorMatiere': _colorMatiereController.text,
                                  'referenceMatiere':
                                      _referenceMatiereController.text,
                                  'idMatiere': newIdMatiere
                                }).then((value) {
                                  print("Matiere Added");
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MatieresPage()));
                                }).catchError((error) =>
                                    print("Failed to add user: $error"));
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  graphique.languagefr['create_matieres_page']
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
              ])))
    ])));
  }

  pickColor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                graphique.languagefr['create_matieres_page']
                    ['field_5_form_title'],
                style:
                    TextStyle(color: Color(graphique.color['default_black'])),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorPicker(
                      pickerColor: _colorMatiere,
                      onColorChanged: (color) {
                        setState(() {
                          // ignore: unnecessary_this
                          this._colorMatiere = color;
                          _colorMatiereController.text =
                              _colorMatiere.toString().substring(6, 16);
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text(
                      graphique.languagefr['create_matieres_page']
                          ['field_5_form_button'],
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(graphique.color['default_blue'])),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ));
  }
}
