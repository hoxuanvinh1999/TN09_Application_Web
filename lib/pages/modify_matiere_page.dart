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

class ModifyMatierePage extends StatefulWidget {
  Map dataMatiere;
  ModifyMatierePage({
    Key? key,
    required this.dataMatiere,
  }) : super(key: key);
  @override
  _ModifyMatierePageState createState() => _ModifyMatierePageState();
}

class _ModifyMatierePageState extends State<ModifyMatierePage> {
  // For Partenaire
  CollectionReference _matiere =
      FirebaseFirestore.instance.collection("Matiere");

  final _modifyMatiereKeyForm = GlobalKey<FormState>();
  TextEditingController _nomMatiereController = TextEditingController();
  TextEditingController _nomMatiereEnglishController = TextEditingController();
  TextEditingController _referenceMatiereController = TextEditingController();
  TextEditingController _colorMatiereController = TextEditingController();
  Color _colorMatiere = Colors.white;
  String matiereparente = 'null';
  late String _actifMatiere;
  void initState() {
    setState(() {
      _nomMatiereController.text = widget.dataMatiere['nomMatiere'];
      _nomMatiereEnglishController.text =
          widget.dataMatiere['nomEnglishMatiere'];
      _referenceMatiereController.text = widget.dataMatiere['referenceMatiere'];
      _colorMatiere = Color(int.parse(widget.dataMatiere['colorMatiere']));
      _colorMatiereController.text = widget.dataMatiere['colorMatiere'];
      _actifMatiere = widget.dataMatiere['actifMatiere'];
      matiereparente = widget.dataMatiere['idMatiereParente'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      header(context: context),
      menu(context: context),
      Container(
          color: Colors.yellow,
          width: double.infinity,
          height: 40,
          child: Row(
            children: [
              SizedBox(
                width: 40,
              ),
              Icon(
                FontAwesomeIcons.home,
                size: 12,
              ),
              SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Home',
                        style: TextStyle(
                            color: Colors.red,
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
                        text: 'Matiere',
                        style: TextStyle(
                            color: Colors.red,
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
                      text: 'Modify Matiere',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          )),
      SizedBox(height: 20),
      Align(
          alignment: Alignment(-0.9, 0),
          child: Container(
              margin: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width * 0.6,
              height: 800,
              color: Colors.green,
              child: Column(children: [
                Container(
                  height: 60,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(
                            FontAwesomeIcons.tags,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Create New Matiere',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
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
                    ],
                  ),
                ),
                Container(
                    height: 60,
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
                            Icon(
                              FontAwesomeIcons.cog,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              ' Informations et paramètres',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
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
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: Colors.blue,
                  child: Form(
                      key: _modifyMatiereKeyForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
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
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            color: Colors.red,
                            child: TextField(
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
                                labelText: 'Nom en Anglais :',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            height: 50,
                            color: Colors.red,
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.tag,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Matière parente',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
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
                                            child:
                                                new Text(matiere['nomMatiere']),
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
                            color: Colors.red,
                            child: TextFormField(
                              controller: _referenceMatiereController,
                              decoration: InputDecoration(
                                labelText: 'Reference:',
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 400,
                              height: 50,
                              color: Colors.red,
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.tag,
                                    size: 15,
                                    color: _colorMatiere,
                                  ),
                                  Text(
                                    'Color:',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment(-0.8, 0),
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
                                          'Pick Color',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 100,
                                    color: Colors.red,
                                    child: TextFormField(
                                      controller: _colorMatiereController,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Code:',
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 400,
                            height: 50,
                            color: Colors.red,
                            child: Row(
                              children: [
                                Text(
                                  'Actif*: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
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
                                  'Actif',
                                  style: new TextStyle(fontSize: 17.0),
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
                                  'PasActif',
                                  style: new TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
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
                        width: 250,
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
                                      builder: (context) => MatieresPage()));
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
                              if (_modifyMatiereKeyForm.currentState!
                                  .validate()) {
                                await _matiere
                                    .doc(widget.dataMatiere['idMatiere'])
                                    .update({
                                  'nomMatiere': _nomMatiereController.text,
                                  'nomEnglishMatiere':
                                      _nomMatiereEnglishController.text,
                                  'idMatiereParente': matiereparente,
                                  'actifMatiere': _actifMatiere,
                                  'colorMatiere': _colorMatiereController.text,
                                  'referenceMatiere':
                                      _referenceMatiereController.text,
                                }).then((value) {
                                  print("Matiere Mofified");
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
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Modify',
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
              ])))
    ])));
  }

  pickColor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Select Color For Tag Matiere'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorPicker(
                      pickerColor: _colorMatiere,
                      onColorChanged: (color) {
                        setState(() {
                          this._colorMatiere = color;
                          _colorMatiereController.text =
                              _colorMatiere.toString().substring(6, 16);
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text(
                      'Select',
                      style: TextStyle(fontSize: 15),
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
