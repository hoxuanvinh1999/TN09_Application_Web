// ignore_for_file: prefer_final_fields, unused_local_variable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/contenant_page.dart';
import 'package:tn09_app_web_demo/pages/type_contenant_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/vehicule_page.dart';

class CreateVehiculePage extends StatefulWidget {
  @override
  _CreateVehiculePageState createState() => _CreateVehiculePageState();
}

class _CreateVehiculePageState extends State<CreateVehiculePage> {
  //For Create Vehicule
  final _createVehiculeKeyForm = GlobalKey<FormState>();
  String _siteVehicule = 'Bordeaux';
  int _orderVehicule = 1;
  List<String> list_site = ['Bordeaux', 'Paris', 'Lille'];
  List<int> list_order = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  TextEditingController _nomVehiculeController = TextEditingController();
  TextEditingController _numeroImmatriculationVehicule =
      TextEditingController();
  TextEditingController _typeVehiculeController = TextEditingController();
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  Stream<QuerySnapshot> _vehiculeStream = FirebaseFirestore.instance
      .collection("Vehicule")
      .orderBy('orderVehicule')
      .snapshots();
  //For Pick Color
  Color _colorVehicule = Color(graphique.color['default_white']);
  pickColor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                graphique.languagefr['create_vehicule_page']
                    ['field_6_form_title'],
                style:
                    TextStyle(color: Color(graphique.color['default_black'])),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorPicker(
                      pickerColor: _colorVehicule,
                      onColorChanged: (color) {
                        setState(() {
                          // ignore: unnecessary_this
                          this._colorVehicule = color;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text(
                      graphique.languagefr['create_vehicule_page']
                          ['field_6_form_button'],
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
                        text: graphique.languagefr['vehicule_page']['nom_page'],
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
                      text: graphique.languagefr['create_vehicule_page']
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
                    SizedBox(width: 20),
                    Icon(
                      FontAwesomeIcons.boxOpen,
                      size: 17,
                      color: Color(graphique.color['main_color_2']),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['create_vehicule_page']
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
                      graphique.languagefr['create_vehicule_page']
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
                    key: _createVehiculeKeyForm,
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
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2'])),
                            cursorColor: Color(graphique.color['main_color_2']),
                            controller: _nomVehiculeController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['create_vehicule_page']
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
                          margin: EdgeInsets.symmetric(vertical: 10),
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
                            controller: _numeroImmatriculationVehicule,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['create_vehicule_page']
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
                              if (value == null || value.isEmpty) {
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
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2'])),
                            cursorColor: Color(graphique.color['main_color_2']),
                            controller: _typeVehiculeController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['create_vehicule_page']
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
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_vehicule_page']
                                      ['field_4_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                  onChanged: (String? changedValue) {
                                    setState(() {
                                      _siteVehicule = changedValue!;
                                      // print(
                                      //     '$_siteVehicule  $changedValue');
                                    });
                                  },
                                  value: _siteVehicule,
                                  items: list_site.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color: Color(graphique
                                                .color['main_color_2']),
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList()),
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
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.sortNumericDown,
                                size: 15,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_vehicule_page']
                                      ['field_5_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              DropdownButton<int>(
                                  onChanged: (int? changedValue) {
                                    setState(() {
                                      _orderVehicule = changedValue!;
                                      // print(
                                      //     '$_orderVehicule  $changedValue');
                                    });
                                  },
                                  value: _orderVehicule,
                                  items: list_order.map((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(
                                        '$value',
                                        style: TextStyle(
                                            color: Color(graphique
                                                .color['main_color_2']),
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList()),
                            ],
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
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.fillDrip,
                                size: 15,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_vehicule_page']
                                      ['field_6_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              Container(
                                  alignment: Alignment(-0.8, 0),
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: _colorVehicule,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                      pickColor(context);
                                    },
                                    child: Text(
                                      graphique.languagefr[
                                              'create_vehicule_page']
                                          ['field_6_button'],
                                      style: TextStyle(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
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
                                    builder: (context) => VehiculePage()));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Color(graphique.color['default_black']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                graphique.languagefr['create_vehicule_page']
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
                            if (_createVehiculeKeyForm.currentState!
                                .validate()) {
                              if (_typeVehiculeController.text == '') {
                                _typeVehiculeController.text = 'null';
                              }
                              String newidVehicule = _vehicule.doc().id;
                              await _vehicule.doc(newidVehicule).set({
                                'nomVehicule': _nomVehiculeController.text,
                                'numeroImmatriculation':
                                    _numeroImmatriculationVehicule.text,
                                'siteVehicule': _siteVehicule,
                                'typeVehicule':
                                    _typeVehiculeController.text.toLowerCase(),
                                'orderVehicule': _orderVehicule.toString(),
                                'colorIconVehicule':
                                    _colorVehicule.toString().substring(6, 16),
                                'idVehicule': newidVehicule
                              }).then((value) {
                                print("Vehicule Added");
                                Fluttertoast.showToast(
                                    msg: "Vehicule Added",
                                    gravity: ToastGravity.TOP);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => VehiculePage()));
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
            ],
          ),
        ),
      )
    ])));
  }
}
