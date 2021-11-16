import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/contenant_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/is_numeric_function.dart';
import 'package:tn09_app_web_demo/pages/type_contenant_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class CreateTypeContenantPage extends StatefulWidget {
  @override
  _CreateTypeContenantPageState createState() =>
      _CreateTypeContenantPageState();
}

class _CreateTypeContenantPageState extends State<CreateTypeContenantPage> {
  //For Create Type Contenant
  CollectionReference _typecontenant =
      FirebaseFirestore.instance.collection("TypeContenant");
  final _createContenantKeyForm = GlobalKey<FormState>();
  TextEditingController _nomTypeContenantController = TextEditingController();
  TextEditingController _poidContenantController = TextEditingController();
  TextEditingController _limitPoidContenantController = TextEditingController();
  TextEditingController _noteContenantController = TextEditingController();
  bool prepare = false;
  bool collecte = false;
  bool pesee = false;

  @override
  Widget build(BuildContext context) {
    // Fow width of table
    double page_width = MediaQuery.of(context).size.width * 0.5;
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
                                    builder: (context) => ContenantPage()));
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
                        text: graphique.languagefr['type_contenant_page']
                            ['nom_page'],
                        style: TextStyle(
                            color: Color(graphique.color['default_red']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => TypeContenantPage()));
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
                      text: graphique.languagefr['create_type_contenant_page']
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
                        FontAwesomeIcons.cubes,
                        size: 17,
                        color: Color(graphique.color['main_color_2']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        graphique.languagefr['create_type_contenant_page']
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
                        graphique.languagefr['create_type_contenant_page']
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
                  height: 600,
                  width: page_width * 2 / 3,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    // border: Border.all(width: 1.0),
                  ),
                  child: Form(
                    key: _createContenantKeyForm,
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
                            controller: _nomTypeContenantController,
                            decoration: InputDecoration(
                              labelText: graphique
                                      .languagefr['create_type_contenant_page']
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
                              } else if (value.contains('/')) {
                                // fix later
                                return 'This name can not have /';
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
                            controller: _poidContenantController,
                            decoration: InputDecoration(
                              labelText: graphique
                                      .languagefr['create_type_contenant_page']
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
                              } else if (!isNumericUsing_tryParse(value)) {
                                // fix later
                                return 'This must be a number';
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
                            controller: _limitPoidContenantController,
                            decoration: InputDecoration(
                              labelText: graphique
                                      .languagefr['create_type_contenant_page']
                                  ['field_3_title'],
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
                              if (value!.isNotEmpty &&
                                  !isNumericUsing_tryParse(value)) {
                                return 'This must be a number';
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
                              color: Color(
                                  graphique.color['special_bureautique_1']),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                style: TextStyle(
                                    color:
                                        Color(graphique.color['main_color_2'])),
                                cursorColor:
                                    Color(graphique.color['main_color_2']),
                                controller: _noteContenantController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: graphique.languagefr[
                                          'create_type_contenant_page']
                                      ['field_4_title'],
                                  hintStyle: TextStyle(
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              graphique.languagefr['create_type_contenant_page']
                                  ['field_5_title'],
                              style: TextStyle(
                                color: Color(graphique.color['default_black']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Switch(
                              value: collecte,
                              onChanged: (value) {
                                setState(() {
                                  collecte = !collecte;
                                  print('collecte $collecte');
                                });
                              },
                              activeTrackColor:
                                  Color(graphique.color['main_color_2']),
                              activeColor:
                                  Color(graphique.color['main_color_2']),
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
                              graphique.languagefr['create_type_contenant_page']
                                  ['field_6_title'],
                              style: TextStyle(
                                color: Color(graphique.color['default_black']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Switch(
                              value: prepare,
                              onChanged: (value) {
                                setState(() {
                                  prepare = !prepare;
                                  print('prepare $prepare');
                                });
                              },
                              activeTrackColor:
                                  Color(graphique.color['main_color_2']),
                              activeColor:
                                  Color(graphique.color['main_color_2']),
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
                              graphique.languagefr['create_type_contenant_page']
                                  ['field_7_title'],
                              style: TextStyle(
                                color: Color(graphique.color['default_black']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Switch(
                              value: pesee,
                              onChanged: (value) {
                                setState(() {
                                  pesee = !pesee;
                                  print('pesee $pesee');
                                });
                              },
                              activeTrackColor:
                                  Color(graphique.color['main_color_2']),
                              activeColor:
                                  Color(graphique.color['main_color_2']),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                                      builder: (context) =>
                                          TypeContenantPage()));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                                const SizedBox(
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
                              if (_createContenantKeyForm.currentState!
                                  .validate()) {
                                QuerySnapshot query = await FirebaseFirestore
                                    .instance
                                    .collection('TypeContenant')
                                    .where('nomTypeContenant',
                                        isEqualTo: _nomTypeContenantController
                                            .text
                                            .toLowerCase()
                                            .replaceAll(' ', ''))
                                    .get();
                                if (query.docs.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "We had this type Contenant",
                                      gravity: ToastGravity.TOP);
                                } else {
                                  String idNewTypeContenant =
                                      _nomTypeContenantController.text;
                                  await _typecontenant
                                      .doc(idNewTypeContenant)
                                      .set({
                                    'nomTypeContenant':
                                        _nomTypeContenantController.text
                                            .toLowerCase()
                                            .replaceAll(' ', ''),
                                    'poidContenant':
                                        _poidContenantController.text,
                                    'noteContenant':
                                        _noteContenantController.text,
                                    'limitpoidContenant':
                                        _limitPoidContenantController.text,
                                    'pesee': pesee.toString(),
                                    'collecte': collecte.toString(),
                                    'prepare': prepare.toString(),
                                    'nombre': '0',
                                    'idTypeContenant': idNewTypeContenant
                                  }).then((value) {
                                    print("Type Contenant Added");
                                    Fluttertoast.showToast(
                                        msg: "Type Contenant Added",
                                        gravity: ToastGravity.TOP);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TypeContenantPage()));
                                  }).catchError((error) =>
                                          print("Failed to add user: $error"));
                                }
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                                const SizedBox(
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
}
