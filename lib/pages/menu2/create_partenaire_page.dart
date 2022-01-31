import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/menu2/partenaire_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class CreatePartenairePage extends StatefulWidget {
  @override
  _CreatePartenairePageState createState() => _CreatePartenairePageState();
}

class _CreatePartenairePageState extends State<CreatePartenairePage> {
  // For Adresse
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
  // For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  Stream<QuerySnapshot> _partenaireStream = FirebaseFirestore.instance
      .collection("Partenaire")
      .orderBy('nomPartenaire')
      .snapshots();
  final _createPartenaireKeyForm = GlobalKey<FormState>();
  TextEditingController _nomPartenaireController = TextEditingController();
  TextEditingController _notePartenaireController = TextEditingController();
  TextEditingController _siretPartenaireController = TextEditingController();
  String _typePartenaire = 'null';
  List<String> list_type = ['PRIVE', 'PUBLIC', 'EXPERIMENTATION', 'AUTRES'];
  String _actifPartenaire = 'true';

  @override
  Widget build(BuildContext context) {
    // Fow width of form
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
                                    builder: (context) => PartenairePage()));
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
                      text: graphique.languagefr['create_partenaire_page']
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
              height: 850,
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
                        FontAwesomeIcons.flag,
                        size: 17,
                        color: Color(graphique.color['main_color_2']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        graphique.languagefr['create_partenaire_page']
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
                        graphique.languagefr['create_partenaire_page']
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
                  height: 500,
                  width: page_width * 2 / 3,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    // border: Border.all(width: 1.0),
                  ),
                  child: Form(
                      key: _createPartenaireKeyForm,
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
                              controller: _nomPartenaireController,
                              decoration: InputDecoration(
                                labelText: graphique
                                        .languagefr['create_partenaire_page']
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
                            child: TextFormField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _siretPartenaireController,
                              decoration: InputDecoration(
                                labelText: graphique
                                        .languagefr['create_partenaire_page']
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
                              validator: (value) {
                                if (value != '' &&
                                    !value!.isEmpty &&
                                    value.length != 14) {
                                  return 'It must be 14 characters long';
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
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.building,
                                  size: 15,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr[
                                            'create_partenaire_page']
                                        ['field_3_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("TypePartenaire")
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
                                            _typePartenaire = changedValue!;
                                          });
                                        },
                                        value: _typePartenaire,
                                        items: snapshot.data!.docs.map(
                                            (DocumentSnapshot
                                                document_typepartenaire) {
                                          Map<String, dynamic> typepartenaire =
                                              document_typepartenaire.data()!
                                                  as Map<String, dynamic>;
                                          return DropdownMenuItem<String>(
                                            value: typepartenaire[
                                                'idTypePartenaire'],
                                            child: Text(
                                              typepartenaire[
                                                  'nomTypePartenaire'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(graphique
                                                      .color['main_color_2']),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }),
                                // DropdownButton<String>(
                                //     onChanged: (String? changedValue) {
                                //       setState(() {
                                //         _typePartenaire = changedValue!;
                                //         // print(
                                //         //     '$_typePartenaire  $changedValue');
                                //       });
                                //     },
                                //     value: _typePartenaire,
                                //     items: list_type.map((String value) {
                                //       return DropdownMenuItem<String>(
                                //         value: value,
                                //         child: Text(
                                //           value,
                                //           style: TextStyle(
                                //               fontSize: 16,
                                //               color: Color(graphique
                                //                   .color['main_color_2']),
                                //               fontWeight: FontWeight.bold),
                                //         ),
                                //       );
                                //     }).toList()),
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
                            child: Row(
                              children: [
                                Text(
                                  graphique.languagefr['create_partenaire_page']
                                      ['field_4_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600),
                                ),
                                Radio(
                                  value: 'true',
                                  groupValue: _actifPartenaire,
                                  onChanged: (val) {
                                    setState(() {
                                      _actifPartenaire = 'true';
                                      // id = 1;
                                      // print('$_actifPartenaire');
                                    });
                                  },
                                ),
                                Text(
                                  graphique.languagefr['create_partenaire_page']
                                      ['field_4_choice_1'],
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color:
                                        Color(graphique.color['default_black']),
                                  ),
                                ),
                                Radio(
                                  value: 'false',
                                  groupValue: _actifPartenaire,
                                  onChanged: (val) {
                                    setState(() {
                                      _actifPartenaire = 'false';
                                      // id = 2;
                                      // print('$_actifPartenaire');
                                    });
                                  },
                                ),
                                Text(
                                  graphique.languagefr['create_partenaire_page']
                                      ['field_4_choice_2'],
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color:
                                        Color(graphique.color['default_black']),
                                  ),
                                ),
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
                                color: Color(
                                    graphique.color['special_bureautique_1']),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  controller: _notePartenaireController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: graphique.languagefr[
                                            'create_partenaire_page']
                                        ['field_5_title'],
                                    labelStyle: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
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
                                      builder: (context) => PartenairePage()));
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
                                  graphique.languagefr['create_partenaire_page']
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
                              if (_typePartenaire == 'null') {
                                Fluttertoast.showToast(
                                    msg: "Your Type Partenaire is Null",
                                    gravity: ToastGravity.TOP);
                              } else if (_createPartenaireKeyForm.currentState!
                                  .validate()) {
                                if (_siretPartenaireController.text.isEmpty) {
                                  _siretPartenaireController.text = '';
                                }
                                if (_notePartenaireController.text.isEmpty) {
                                  _siretPartenaireController.text = '';
                                }
                                String newIdPartenaire = _partenaire.doc().id;
                                await _adresse.doc(_adresse.doc().id).set({
                                  'nomPartenaireAdresse': 'None',
                                  'ligne1Adresse': 'null',
                                  'ligne2Adresse': 'null',
                                  'codepostalAdresse': 'null',
                                  'villeAdresse': 'null',
                                  'paysAdresse': 'null',
                                  'latitudeAdresse': '0',
                                  'longitudeAdresse': '0',
                                  'idPosition': 'null',
                                  'etageAdresse': 'null',
                                  'ascenseurAdresse': 'false',
                                  'noteAdresse': 'null',
                                  'passagesAdresse': 'false',
                                  'facturationAdresse': 'false',
                                  'tarifpassageAdresse': '0',
                                  'tempspassageAdresse': '0',
                                  'surfacepassageAdresse': '0',
                                  'idPartenaireAdresse': newIdPartenaire,
                                  'nombredeContact': '0',
                                  'idAdresse': 'null',
                                });
                                String nom_typePartenaire = '';
                                await FirebaseFirestore.instance
                                    .collection("TypePartenaire")
                                    .where('idTypePartenaire',
                                        isEqualTo: _typePartenaire)
                                    .limit(1)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs
                                      .forEach((doc_typepartenaire) async {
                                    nom_typePartenaire =
                                        doc_typepartenaire['nomTypePartenaire'];
                                    await FirebaseFirestore.instance
                                        .collection("TypePartenaire")
                                        .doc(_typePartenaire)
                                        .update({
                                      'nombre': (int.parse(doc_typepartenaire[
                                                  'nombre']) +
                                              1)
                                          .toString(),
                                    });
                                  });
                                });
                                await _partenaire.doc(newIdPartenaire).set({
                                  'nomPartenaire':
                                      _nomPartenaireController.text,
                                  'notePartenaire':
                                      _notePartenaireController.text,
                                  'siretPartenaire':
                                      _siretPartenaireController.text,
                                  'idContactPartenaire': 'null',
                                  'actifPartenaire': _actifPartenaire,
                                  'idTypePartenaire': _typePartenaire,
                                  'typePartenaire': nom_typePartenaire,
                                  'nombredeAdresses': '0',
                                  'nombredeFrequence': '0',
                                  'nombredeContact': '0',
                                  'idPartenaire': newIdPartenaire
                                }).then((value) {
                                  _nomPartenaireController.text = '';
                                  _notePartenaireController.text = '';
                                  _siretPartenaireController.text = '';
                                  print("Partenaire Added");
                                  //Will Navigator to other page later
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PartenairePage()));
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
                                  graphique.languagefr['create_partenaire_page']
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
