// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/math_function/conver_string_bool.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_time_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/math_function/toDouble.dart';
import 'package:tn09_app_web_demo/pages/math_function/toMinute.dart';
import 'package:tn09_app_web_demo/pages/menu2/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_contact_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/widget/button_widget.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';

class ModifyAdressePartenairePage extends StatefulWidget {
  Map partenaire;
  Map dataAdresse;
  int form_start;
  ModifyAdressePartenairePage({
    Key? key,
    required this.partenaire,
    required this.dataAdresse,
    required this.form_start,
  }) : super(key: key);
  @override
  _ModifyAdressePartenairePageState createState() =>
      _ModifyAdressePartenairePageState();
}

class _ModifyAdressePartenairePageState
    extends State<ModifyAdressePartenairePage> {
  int form_number = 1;
  //forPartenaire
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
  String _typePartenaire = 'PRIVE';
  List<String> list_type = ['PRIVE', 'PUBLIC', 'EXPERIMENTATION', 'AUTRES'];
  String _actifPartenaire = 'true';

  // Init Data
  void initState() {
    setState(() {
      _nomPartenaireAdresseController.text =
          widget.dataAdresse['nomPartenaireAdresse'];
      _ligne1AdresseController.text = widget.dataAdresse['ligne1Adresse'];
      _ligne2AdresseController.text = widget.dataAdresse['ligne2Adresse'];
      _codepostalAdresseController.text =
          widget.dataAdresse['codepostalAdresse'];
      _villeAdresseController.text = widget.dataAdresse['villeAdresse'];
      _paysAdresseController.text = widget.dataAdresse['paysAdresse'];
      _latitudeAdresseController.text = widget.dataAdresse['latitudeAdresse'];
      _longitudeAdresseController.text = widget.dataAdresse['longitudeAdresse'];
      _etageAdresseController.text = widget.dataAdresse['etageAdresse'];
      _noteAdresseController.text = widget.dataAdresse['noteAdresse'];
      _tarifpassageAdresseController.text =
          widget.dataAdresse['tarifpassageAdresse'];
      _tempspassageAdresseController.text =
          widget.dataAdresse['tempspassageAdresse'];
      _surfacepassageAdresseController.text =
          widget.dataAdresse['surfacepassageAdresse'];
      _ascenseurAdresse =
          convertBool(check: widget.dataAdresse['ascenseurAdresse']);
      _passagesAdresse =
          convertBool(check: widget.dataAdresse['passagesAdresse']);
      _facturationAdresse =
          convertBool(check: widget.dataAdresse['facturationAdresse']);
      form_number = widget.form_start;
    });
    super.initState();
  }

  // For Relation Table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");
  // For Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");

  //for Modify Adresse
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
  final _modifyAdressesKeyForm = GlobalKey<FormState>();
  TextEditingController _nomPartenaireAdresseController =
      TextEditingController();
  TextEditingController _ligne1AdresseController = TextEditingController();
  TextEditingController _ligne2AdresseController = TextEditingController();
  TextEditingController _codepostalAdresseController = TextEditingController();
  TextEditingController _villeAdresseController = TextEditingController();
  TextEditingController _paysAdresseController = TextEditingController();
  TextEditingController _latitudeAdresseController = TextEditingController();
  TextEditingController _longitudeAdresseController = TextEditingController();
  TextEditingController _noteAdresseController = TextEditingController();
  TextEditingController _etageAdresseController = TextEditingController();
  bool _ascenseurAdresse = true;
  bool _passagesAdresse = true;
  bool _facturationAdresse = true;
  TextEditingController _tarifpassageAdresseController =
      TextEditingController();
  TextEditingController _tempspassageAdresseController =
      TextEditingController();
  TextEditingController _surfacepassageAdresseController =
      TextEditingController();

  //For frequence
  CollectionReference _frequence =
      FirebaseFirestore.instance.collection("Frequence");
  List<String> list_jour = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche',
  ];

  //for Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection('Vehicule');
  //for Etape
  CollectionReference _etape = FirebaseFirestore.instance.collection('Etape');
  // for control table
  CollectionReference _contactadresse =
      FirebaseFirestore.instance.collection("ContactAdresse");

  //For Add Frequence
  String choiceVehicule = 'None';
  String idVehiculeFrequence = '';
  String _jour = 'Lundi';
  TimeOfDay timeStart = TimeOfDay.now();
  TimeOfDay timeEnd = TimeOfDay.now();
  TextEditingController _frequenceTextController = TextEditingController();
  TextEditingController _frequenceTarifController = TextEditingController();

  Future pickTimeStart(
      {required BuildContext context, required TimeOfDay time}) async {
    final newTime = await showTimePicker(context: context, initialTime: time);

    if (newTime == null) {
      return;
    }
    setState(() => timeStart = newTime);
  }

  Future pickTimeEnd(
      {required BuildContext context, required TimeOfDay time}) async {
    final newTime = await showTimePicker(context: context, initialTime: time);

    if (newTime == null) {
      return;
    }
    setState(() => timeEnd = newTime);
  }

  DateTime dateMinimale = DateTime.now();
  DateTime dateMaximale = DateTime.now();

  Future pickDateMinimale(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => dateMinimale = newDate);
  }

  Future pickDateMaximale(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => dateMaximale = newDate);
  }

  @override
  Widget build(BuildContext context) {
    // For width of table
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
                        text: widget.partenaire['nomPartenaire'],
                        style: TextStyle(
                            color: Color(graphique.color['default_red']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => ViewPartenairePage(
                                          partenaire: widget.partenaire,
                                        )));
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
                      text: graphique
                                  .languagefr['modify_addresse_partenaire_page']
                              ['nom_page'] +
                          ': ' +
                          widget.dataAdresse['nomPartenaireAdresse'],
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
          decoration: BoxDecoration(
            color: Color(graphique.color['main_color_1']),
            border: Border.all(
                width: 1.0, color: Color(graphique.color['default_black'])),
          ),
          width: page_width,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (form_number == 1) {
                    null;
                  } else {
                    setState(() {
                      form_number = 1;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mapMarker,
                      color: Color(graphique.color['default_black']),
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['modify_addresse_partenaire_page']
                          ['adresse_form']['button_nom'],
                      style: TextStyle(
                        color: Color(graphique.color['default_black']),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (form_number == 2) {
                    null;
                  } else {
                    setState(() {
                      form_number = 2;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      color: Color(graphique.color['default_black']),
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['modify_addresse_partenaire_page']
                          ['horaires_form']['button_nom'],
                      style: TextStyle(
                        color: Color(graphique.color['default_black']),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (form_number == 3) {
                    null;
                  } else {
                    setState(() {
                      form_number = 3;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.users,
                      color: Color(graphique.color['default_black']),
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['modify_addresse_partenaire_page']
                          ['contact_form']['button_nom'],
                      style: TextStyle(
                        color: Color(graphique.color['default_black']),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Visibility(
        visible: form_number == 1,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Container(
            height: 1600,
            margin: const EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 20,
            ),
            width: page_width,
            decoration: BoxDecoration(
              color: Color(graphique.color['special_bureautique_2']),
              border: Border.all(
                  width: 1.0, color: Color(graphique.color['default_black'])),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: page_width,
                    alignment: const Alignment(-0.9, 0),
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Text(
                      graphique.languagefr['modify_addresse_partenaire_page']
                              ['subtitle_page'] +
                          ': ' +
                          widget.dataAdresse['nomPartenaireAdresse'],
                      style: TextStyle(
                        color: Color(graphique.color['main_color_2']),
                        fontSize: 20,
                      ),
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
                          graphique
                                  .languagefr['modify_addresse_partenaire_page']
                              ['adresse_form']['form_subtitle'],
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
                    height: 1350,
                    width: page_width,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['special_bureautique_2']),
                      // border: Border.all(width: 1.0),
                    ),
                    child: Form(
                      key: _modifyAdressesKeyForm,
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
                              controller: _nomPartenaireAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_1_title'],
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
                              controller: _ligne1AdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_2_title'],
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
                              controller: _ligne2AdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_3_title'],
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
                            child: TextFormField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _codepostalAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_4_title'],
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
                              controller: _villeAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_5_title'],
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
                              controller: _paysAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_6_title'],
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
                              controller: _latitudeAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_7_title'],
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
                            child: TextFormField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _longitudeAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_8_title'],
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
                            child: TextFormField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _etageAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_9_title'],
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_11_title'],
                                style: TextStyle(
                                  color:
                                      Color(graphique.color['default_black']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Switch(
                                value: _ascenseurAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _ascenseurAdresse = !_ascenseurAdresse;
                                    print(
                                        '_ascenseurAdresse $_ascenseurAdresse');
                                  });
                                },
                                activeTrackColor:
                                    Color(graphique.color['main_color_2']),
                                activeColor:
                                    Color(graphique.color['main_color_2']),
                              ),
                            ],
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
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _noteAdresseController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: graphique.languagefr[
                                            'modify_addresse_partenaire_page']
                                        ['adresse_form']['field_10_title'],
                                    hintStyle: TextStyle(
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_12_title'],
                                style: TextStyle(
                                  color:
                                      Color(graphique.color['default_black']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Switch(
                                value: _passagesAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _passagesAdresse = !_passagesAdresse;
                                    print('_passagesAdresse $_passagesAdresse');
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
                                graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_13_title'],
                                style: TextStyle(
                                  color:
                                      Color(graphique.color['default_black']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Switch(
                                value: _facturationAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _facturationAdresse = !_facturationAdresse;
                                    print(
                                        '_facturationAdresse $_facturationAdresse');
                                  });
                                },
                                activeTrackColor:
                                    Color(graphique.color['main_color_2']),
                                activeColor:
                                    Color(graphique.color['main_color_2']),
                              ),
                            ],
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
                              controller: _tarifpassageAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_14_title'],
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
                                if (!value!.isEmpty &&
                                    double.tryParse(value) == null) {
                                  return 'Please input a true number';
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
                              controller: _tempspassageAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_15_title'],
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
                                if (!value!.isEmpty &&
                                    double.tryParse(value) == null) {
                                  return 'Please input a true number';
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
                              controller: _surfacepassageAdresseController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['adresse_form']['field_16_title'],
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
                                if (!value!.isEmpty &&
                                    double.tryParse(value) == null) {
                                  return 'Please input a true number';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewPartenairePage(
                                          partenaire: widget.partenaire)),
                                ).then((value) => setState(() {}));
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
                                    graphique.languagefr[
                                            'modify_addresse_partenaire_page']
                                        ['adresse_form']['button_2'],
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
                        Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(graphique.color['default_yellow']),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(
                                right: 10, top: 20, bottom: 20),
                            child: GestureDetector(
                              onTap: () async {
                                if (_modifyAdressesKeyForm.currentState!
                                    .validate()) {
                                  await _frequence
                                      .where('idAdresseFrequence',
                                          isEqualTo:
                                              widget.dataAdresse['idAdresse'])
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc_frequence) {
                                      _frequence.doc(doc_frequence.id).update({
                                        'nomAdresseFrequence':
                                            _nomPartenaireAdresseController
                                                .text,
                                      });
                                    });
                                  });
                                  await _etape
                                      .where('idAdresseEtape',
                                          isEqualTo:
                                              widget.dataAdresse['idAdresse'])
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc_etape) {
                                      _etape.doc(doc_etape.id).update({
                                        'nomAdresseEtape':
                                            _nomPartenaireAdresseController
                                                .text,
                                      });
                                    });
                                  });
                                  await _adresse
                                      .where('idAdresse',
                                          isEqualTo:
                                              widget.dataAdresse['idAdresse'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _adresse.doc(doc.id).update({
                                        'nomPartenaireAdresse':
                                            _nomPartenaireAdresseController
                                                .text,
                                        'ligne1Adresse':
                                            _ligne1AdresseController.text,
                                        'ligne2Adresse':
                                            _ligne2AdresseController.text,
                                        'codepostalAdresse':
                                            _codepostalAdresseController.text,
                                        'villeAdresse':
                                            _villeAdresseController.text,
                                        'paysAdresse':
                                            _paysAdresseController.text,
                                        'latitudeAdresse':
                                            _latitudeAdresseController.text,
                                        'longitudeAdresse':
                                            _longitudeAdresseController.text,
                                        'etageAdresse':
                                            _etageAdresseController.text,
                                        'ascenseurAdresse':
                                            _ascenseurAdresse.toString(),
                                        'noteAdresse':
                                            _noteAdresseController.text,
                                        'passagesAdresse':
                                            _passagesAdresse.toString(),
                                        'facturationAdresse':
                                            _facturationAdresse.toString(),
                                        'tarifpassageAdresse':
                                            _tarifpassageAdresseController.text,
                                        'tempspassageAdresse':
                                            _tempspassageAdresseController.text,
                                        'surfacepassageAdresse':
                                            _surfacepassageAdresseController
                                                .text,
                                      }).then((value) async {
                                        await _partenaire
                                            .where('idPartenaire',
                                                isEqualTo: widget
                                                    .partenaire['idPartenaire'])
                                            .limit(1)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            Map<String, dynamic>
                                                next_partenaire = doc.data()!
                                                    as Map<String, dynamic>;
                                            print("Adresse Modified");
                                            Fluttertoast.showToast(
                                                msg: "Adresse Modified",
                                                gravity: ToastGravity.TOP);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewPartenairePage(
                                                          partenaire:
                                                              next_partenaire)),
                                            ).then((value) => setState(() {}));
                                          });
                                        });
                                      }).catchError((error) => print(
                                          "Failed to update user: $error"));
                                    });
                                  });
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
                                    graphique.languagefr[
                                            'modify_addresse_partenaire_page']
                                        ['adresse_form']['button_1'],
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
                ]),
          ),
        ),
      ),
      Visibility(
        visible: form_number == 2,
        child: Align(
            alignment: Alignment(-0.9, 0),
            child: Container(
              height: 1000,
              margin: const EdgeInsets.only(
                left: 20,
                top: 20,
                bottom: 20,
              ),
              width: page_width,
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: page_width,
                      alignment: const Alignment(-0.9, 0),
                      decoration: BoxDecoration(
                        color: Color(graphique.color['main_color_1']),
                        border: Border.all(
                            width: 1.0,
                            color: Color(graphique.color['default_black'])),
                      ),
                      child: Text(
                        graphique.languagefr['modify_addresse_partenaire_page']
                                ['subtitle_page'] +
                            ': ' +
                            widget.dataAdresse['nomPartenaireAdresse'],
                        style: TextStyle(
                          color: Color(graphique.color['main_color_2']),
                          fontSize: 20,
                        ),
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
                            graphique.languagefr[
                                    'modify_addresse_partenaire_page']
                                ['horaires_form']['form_subtitle'],
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
                      height: 700,
                      decoration: BoxDecoration(
                        color: Color(graphique.color['special_bureautique_2']),
                        // border: Border.all(width: 1.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['horaires_form']['field_1_title'] +
                                ': ' +
                                //     '${timeStart.hour}:${timeStart.minute}'
                                getTimeText(time: timeStart),
                            onClicked: () => pickTimeStart(
                                context: context, time: timeStart),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['horaires_form']['field_2_title'] +
                                ': ' +
                                // '${timeEnd.hour}:${timeEnd.minute}'
                                getTimeText(time: timeEnd),
                            onClicked: () =>
                                pickTimeEnd(context: context, time: timeEnd),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['horaires_form']['field_3_title'] +
                                ': ' +
                                getDateText(date: dateMinimale),
                            onClicked: () => pickDateMinimale(context),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['horaires_form']['field_4_title'] +
                                ': ' +
                                getDateText(date: dateMaximale),
                            onClicked: () => pickDateMaximale(context),
                          ),
                          SizedBox(
                            height: 20,
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
                              controller: _frequenceTextController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['horaires_form']['field_5_title'],
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
                            child: TextFormField(
                              style: TextStyle(
                                  color:
                                      Color(graphique.color['main_color_2'])),
                              cursorColor:
                                  Color(graphique.color['main_color_2']),
                              controller: _frequenceTarifController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'modify_addresse_partenaire_page']
                                    ['horaires_form']['field_6_title'],
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
                                  FontAwesomeIcons.calendar,
                                  size: 15,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr[
                                            'modify_addresse_partenaire_page']
                                        ['horaires_form']['field_7_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                //dropdown have bug
                                DropdownButton<String>(
                                    onChanged: (String? changedValue) {
                                      setState(() {
                                        _jour = changedValue!;
                                      });
                                    },
                                    value: _jour,
                                    items: list_jour.map((String value) {
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
                              color: Color(
                                  graphique.color['special_bureautique_1']),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.truck,
                                  size: 15,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr[
                                            'modify_addresse_partenaire_page']
                                        ['horaires_form']['field_8_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("Vehicule")
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
                                            choiceVehicule = changedValue!;
                                          });
                                        },
                                        value: choiceVehicule,
                                        items: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> vehicule =
                                              document.data()!
                                                  as Map<String, dynamic>;

                                          return DropdownMenuItem<String>(
                                              value: vehicule[
                                                  'numeroImmatriculation'],
                                              child: Row(
                                                children: [
                                                  buildVehiculeIcon(
                                                      icontype: vehicule[
                                                          'typeVehicule'],
                                                      iconcolor: vehicule[
                                                              'colorIconVehicule']
                                                          .toUpperCase(),
                                                      sizeIcon: 15.0),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    vehicule['nomVehicule'] +
                                                        ' ' +
                                                        vehicule[
                                                            'numeroImmatriculation'],
                                                    style: TextStyle(
                                                        color: Color(graphique
                                                                .color[
                                                            'main_color_2']),
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ));
                                        }).toList(),
                                      );
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
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
                                  color:
                                      Color(graphique.color['default_yellow']),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  print(getTimeText(time: timeStart));
                                  print(getTimeText(time: timeEnd));
                                  print('$choiceVehicule');
                                  print('$_jour');
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewPartenairePage(
                                                partenaire: widget.partenaire,
                                              )));
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Color(
                                          graphique.color['default_black']),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      graphique.languagefr[
                                              'modify_addresse_partenaire_page']
                                          ['horaires_form']['button_2'],
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
                          Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color:
                                      Color(graphique.color['default_yellow']),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (_frequenceTextController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please Input a frequence",
                                        gravity: ToastGravity.TOP);
                                  } else if (!_frequenceTextController
                                          .text.isEmpty &&
                                      int.tryParse(
                                              _frequenceTextController.text) ==
                                          null) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please Input a real Number for frequence",
                                        gravity: ToastGravity.TOP);
                                  } else if (dateMinimale
                                      .isAfter(dateMaximale)) {
                                    Fluttertoast.showToast(
                                        msg: "Please check your day",
                                        gravity: ToastGravity.TOP);
                                  } else if (!_frequenceTarifController
                                          .text.isEmpty &&
                                      int.tryParse(
                                              _frequenceTarifController.text) ==
                                          null) {
                                  } else if (toDouble(timeStart) >
                                      toDouble(timeEnd)) {
                                    Fluttertoast.showToast(
                                        msg: "Please check your time",
                                        gravity: ToastGravity.TOP);
                                  } else {
                                    await _partenaire
                                        .where('idPartenaire',
                                            isEqualTo: widget
                                                .partenaire['idPartenaire'])
                                        .limit(1)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        _partenaire.doc(doc.id).update({
                                          'nombredeFrequence': (int.parse(widget
                                                          .partenaire[
                                                      'nombredeFrequence']) +
                                                  1)
                                              .toString(),
                                        });
                                      });
                                    });
                                    await _vehicule
                                        .where('numeroImmatriculation',
                                            isEqualTo: choiceVehicule)
                                        .limit(1)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        idVehiculeFrequence = doc['idVehicule'];
                                      });
                                    });
                                    String newIdFrequence = _frequence.doc().id;
                                    await _frequence.doc(newIdFrequence).set({
                                      'frequence':
                                          _frequenceTextController.text,
                                      'jourFrequence': _jour,
                                      'siretPartenaire':
                                          _siretPartenaireController.text,
                                      'idContactFrequence': 'null',
                                      'idVehiculeFrequence':
                                          idVehiculeFrequence,
                                      'idAdresseFrequence':
                                          widget.dataAdresse['idAdresse'],
                                      'nomAdresseFrequence': widget
                                          .dataAdresse['nomPartenaireAdresse'],
                                      'idPartenaireFrequence':
                                          widget.partenaire['idPartenaire'],
                                      'dureeFrequence': (toMinute(timeEnd) -
                                              toMinute(timeStart))
                                          .toString(),
                                      'startFrequence':
                                          getTimeText(time: timeStart),
                                      'endFrequence':
                                          getTimeText(time: timeEnd),
                                      'tarifFrequence':
                                          _frequenceTarifController.text,
                                      'dateMinimaleFrequence':
                                          getDateText(date: dateMinimale),
                                      'dateMaximaleFrequence':
                                          getDateText(date: dateMaximale),
                                      'idFrequence': newIdFrequence
                                    }).then((value) async {
                                      await _partenaire
                                          .where('idPartenaire',
                                              isEqualTo: widget
                                                  .partenaire['idPartenaire'])
                                          .limit(1)
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          Map<String, dynamic> next_partenaire =
                                              doc.data()!
                                                  as Map<String, dynamic>;
                                          print("Frequence Added");
                                          Fluttertoast.showToast(
                                              msg: "Frequence Added",
                                              gravity: ToastGravity.TOP);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPartenairePage(
                                                      partenaire:
                                                          next_partenaire,
                                                    )),
                                          ).then((value) => setState(() {}));
                                        });
                                      });
                                    }).catchError((error) =>
                                        print("Failed to update user: $error"));
                                  }
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
                                      graphique.languagefr[
                                              'modify_addresse_partenaire_page']
                                          ['horaires_form']['button_1'],
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
                  ]),
            )),
      ),
      Visibility(
        visible: form_number == 3,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Container(
            height: 1600 +
                200 * double.parse(widget.dataAdresse['nombredeContact']),
            margin: const EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 20,
            ),
            width: page_width,
            decoration: BoxDecoration(
              color: Color(graphique.color['special_bureautique_2']),
              border: Border.all(
                  width: 1.0, color: Color(graphique.color['default_black'])),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: page_width,
                    alignment: const Alignment(-0.9, 0),
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Text(
                      graphique.languagefr['modify_addresse_partenaire_page']
                              ['subtitle_page'] +
                          ': ' +
                          widget.dataAdresse['nomPartenaireAdresse'],
                      style: TextStyle(
                        color: Color(graphique.color['main_color_2']),
                        fontSize: 20,
                      ),
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
                          graphique
                                  .languagefr['modify_addresse_partenaire_page']
                              ['contact_form']['form_subtitle'],
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
                    height: 600,
                    width: page_width * 3 / 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_green']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _contactadresse
                          .where('idAdresse',
                              isEqualTo: widget.dataAdresse['idAdresse'])
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // print('snapshot ${snapshot.data}');
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snapshot.data!.docs.map((DocumentSnapshot
                                document_link_contactadresse) {
                              Map<String, dynamic> link_contactadresse =
                                  document_link_contactadresse.data()!
                                      as Map<String, dynamic>;
                              // print('link_contactadresse $link_contactadresse');
                              return Container(
                                color: Color(graphique.color['default_green']),
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Contact")
                                      .where('idContact',
                                          isEqualTo:
                                              link_contactadresse['idContact'])
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
                                    return Column(
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        Map<String, dynamic> insidedataContact =
                                            document.data()!
                                                as Map<String, dynamic>;

                                        // print(
                                        //     'insidedataContact $insidedataContact');
                                        return Container(
                                          width: page_width * 0.6,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Color(graphique
                                                .color['default_white']),
                                            border: Border.all(
                                                width: 1.0,
                                                color: Color(graphique
                                                    .color['default_black'])),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Row(
                                                children: [
                                                  SizedBox(width: 20),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: limitString(
                                                                text: insidedataContact[
                                                                        'nomContact'] +
                                                                    ' ' +
                                                                    insidedataContact[
                                                                        'prenomContact'],
                                                                limit_long: 15),
                                                            style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_red']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                        builder: (context) => ViewContactPage(
                                                                            partenaire: widget
                                                                                .partenaire,
                                                                            from:
                                                                                'ModifyAdressePartenairePage',
                                                                            dataContact:
                                                                                insidedataContact)));
                                                                  }),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.phone,
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    insidedataContact[
                                                        'telephone1Contact'],
                                                    style: TextStyle(
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )),
                                              Container(
                                                width: 50,
                                                child: IconButton(
                                                  onPressed: () async {
                                                    await _adresse
                                                        .where('idAdresse',
                                                            isEqualTo: widget
                                                                    .dataAdresse[
                                                                'idAdresse'])
                                                        .limit(1)
                                                        .get()
                                                        .then((QuerySnapshot
                                                            querySnapshot) {
                                                      querySnapshot.docs
                                                          .forEach((doc) {
                                                        _adresse
                                                            .doc(doc.id)
                                                            .update({
                                                          'nombredeContact':
                                                              (int.parse(doc[
                                                                          'nombredeContact']) -
                                                                      1)
                                                                  .toString(),
                                                        });
                                                      });
                                                    });
                                                    _contactadresse
                                                        .where("idContact",
                                                            isEqualTo:
                                                                insidedataContact[
                                                                    'idContact'])
                                                        .where('idAdresse',
                                                            isEqualTo: widget
                                                                    .dataAdresse[
                                                                'idAdresse'])
                                                        .get()
                                                        .then((value) {
                                                      value.docs.forEach((doc) {
                                                        _contactadresse
                                                            .doc(doc.id)
                                                            .delete()
                                                            .then((value) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Contact Added",
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP);
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ModifyAdressePartenairePage(
                                                                      partenaire:
                                                                          widget
                                                                              .partenaire,
                                                                      dataAdresse:
                                                                          widget
                                                                              .dataAdresse,
                                                                      form_start:
                                                                          3)));
                                                        });
                                                      });
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    FontAwesomeIcons.minus,
                                                    size: 15,
                                                  ),
                                                  tooltip: graphique.languagefr[
                                                              'modify_addresse_partenaire_page']
                                                          ['contact_form']
                                                      ['hint_1_title'],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: page_width * 3 / 4,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_green']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    height: 600,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _contactpartenaire
                          .where('idPartenaire',
                              isEqualTo: widget.partenaire['idPartenaire'])
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // print('snapshot ${snapshot.data}');
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: snapshot.data!.docs.map((DocumentSnapshot
                                document_link_contactpartenaire) {
                              Map<String, dynamic> link_contactpartenaire =
                                  document_link_contactpartenaire.data()!
                                      as Map<String, dynamic>;
                              // print('link_contactadresse $link_contactadresse');
                              return Container(
                                color: Color(graphique.color['default_green']),
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Contact")
                                      .where('idContact',
                                          isEqualTo: link_contactpartenaire[
                                              'idContact'])
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
                                    return Column(
                                      children: snapshot.data!.docs.map(
                                          (DocumentSnapshot document_contact) {
                                        Map<String, dynamic> insidedataContact =
                                            document_contact.data()!
                                                as Map<String, dynamic>;

                                        // print(
                                        //     'insidedataContact $insidedataContact');
                                        return Container(
                                          width: page_width * 0.6,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Color(graphique
                                                .color['default_white']),
                                            border: Border.all(
                                                width: 1.0,
                                                color: Color(graphique
                                                    .color['default_black'])),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width: 300,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        limitString(
                                                            text: insidedataContact[
                                                                    'nomContact'] +
                                                                ' ' +
                                                                insidedataContact[
                                                                    'prenomContact'],
                                                            limit_long: 15),
                                                        style: TextStyle(
                                                            color: Color(graphique
                                                                    .color[
                                                                'default_red']),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons.phone,
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        insidedataContact[
                                                            'telephone1Contact'],
                                                        style: TextStyle(
                                                            color: Color(graphique
                                                                    .color[
                                                                'default_black']),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )),
                                              Container(
                                                  width: 100,
                                                  child: Row(children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        QuerySnapshot query = await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'ContactAdresse')
                                                            .where('idContact',
                                                                isEqualTo:
                                                                    insidedataContact[
                                                                        'idContact'])
                                                            .where('idAdresse',
                                                                isEqualTo: widget
                                                                        .dataAdresse[
                                                                    'idAdresse'])
                                                            .get();
                                                        if (query
                                                            .docs.isEmpty) {
                                                          await _adresse
                                                              .where(
                                                                  'idAdresse',
                                                                  isEqualTo: widget
                                                                          .dataAdresse[
                                                                      'idAdresse'])
                                                              .limit(1)
                                                              .get()
                                                              .then((QuerySnapshot
                                                                  querySnapshot) {
                                                            querySnapshot.docs
                                                                .forEach((doc) {
                                                              _adresse
                                                                  .doc(doc.id)
                                                                  .update({
                                                                'nombredeContact':
                                                                    (int.parse(doc['nombredeContact']) +
                                                                            1)
                                                                        .toString(),
                                                              });
                                                            });
                                                          });
                                                          await _contactadresse
                                                              .doc(
                                                                  _contactadresse
                                                                      .doc()
                                                                      .id)
                                                              .set({
                                                            'idAdresse': widget
                                                                    .dataAdresse[
                                                                'idAdresse'],
                                                            'idContact':
                                                                insidedataContact[
                                                                    'idContact']
                                                          }).then((value) {
                                                            print(
                                                                "Contact Added");
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Contact Added",
                                                                gravity:
                                                                    ToastGravity
                                                                        .TOP);
                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                builder: (context) => ModifyAdressePartenairePage(
                                                                    partenaire:
                                                                        widget
                                                                            .partenaire,
                                                                    dataAdresse:
                                                                        widget
                                                                            .dataAdresse,
                                                                    form_start:
                                                                        3)));
                                                          }).catchError((error) =>
                                                                  print(
                                                                      "Failed to add user: $error"));
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'It has been added already',
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        FontAwesomeIcons.plus,
                                                        size: 15,
                                                      ),
                                                      tooltip: graphique
                                                                      .languagefr[
                                                                  'modify_addresse_partenaire_page']
                                                              ['contact_form']
                                                          ['hint_2_title'],
                                                    ),
                                                  ]))
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
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
                                        builder: (context) =>
                                            ViewPartenairePage(
                                              partenaire: widget.partenaire,
                                            )));
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
                                    graphique.languagefr[
                                            'modify_addresse_partenaire_page']
                                        ['contact_form']['button_1'],
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
                ]),
          ),
        ),
      )
    ])));
  }

  //for Adresse
  CollectionReference _contenantadresse =
      FirebaseFirestore.instance.collection("ContenantAdresse");

  showAddFrequenceAdresse(
      {required BuildContext context, required Map dataAdresse}) async {
    //For Add Frequence
    String choiceVehicule = 'None';
    String idVehiculeFrequence = '';
    String _jour = 'Lundi';
    TimeOfDay timeStart = TimeOfDay.now();
    TimeOfDay timeEnd = TimeOfDay.now();
    TextEditingController _frequenceTextController = TextEditingController();
    TextEditingController _frequenceTarifController = TextEditingController();
    _frequenceTarifController.text = dataAdresse['tarifpassageAdresse'];

    Future pickTimeStart(
        {required BuildContext context, required TimeOfDay time}) async {
      final newTime = await showTimePicker(context: context, initialTime: time);

      if (newTime == null) {
        return;
      }
      setState(() => timeStart = newTime);
    }

    Future pickTimeEnd(
        {required BuildContext context, required TimeOfDay time}) async {
      final newTime = await showTimePicker(context: context, initialTime: time);

      if (newTime == null) {
        return;
      }
      setState(() => timeEnd = newTime);
    }

    DateTime dateMinimale = DateTime.now();
    DateTime dateMaximale = DateTime.now();

    Future pickDateMinimale(BuildContext context) async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (newDate == null) return;

      setState(() => dateMinimale = newDate);
    }

    Future pickDateMaximale(BuildContext context) async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (newDate == null) return;

      setState(() => dateMaximale = newDate);
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            height: 800,
            width: 800,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      color: Colors.blue,
                      child: Text(
                        'Modify Adresses ' +
                            dataAdresse['nomPartenaireAdresse'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )),
                  Divider(
                    thickness: 5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.mapMarker,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Localisation',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: null,
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Horaires',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // showModifyContactAdresse(
                          //     context: context, dataAdresse: dataAdresse);
                        },
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.users,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Contact',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    color: Colors.green,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: 'StartTime: ' +
                                //     '${timeStart.hour}:${timeStart.minute}'
                                getTimeText(time: timeStart),
                            onClicked: () => pickTimeStart(
                                context: context, time: timeStart),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: 'EndTime: ' +
                                // '${timeEnd.hour}:${timeEnd.minute}'
                                getTimeText(time: timeEnd),
                            onClicked: () =>
                                pickTimeEnd(context: context, time: timeEnd),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: 'DateMinimale: ' +
                                DateFormat('yMd')
                                    .format(dateMinimale)
                                    .toString(),
                            onClicked: () => pickDateMinimale(context),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            icon: Icons.calendar_today,
                            text: 'DateMaximale: ' +
                                DateFormat('yMd')
                                    .format(dateMaximale)
                                    .toString(),
                            onClicked: () => pickDateMaximale(context),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _frequenceTextController,
                              decoration: InputDecoration(
                                labelText:
                                    'Frequence*(Toutes les X semaines) : ',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _frequenceTarifController,
                              decoration: InputDecoration(
                                labelText: 'Tarif : ',
                              ),
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
                                  FontAwesomeIcons.calendar,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Jour',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                //dropdown have bug
                                DropdownButton<String>(
                                    onChanged: (String? changedValue) {
                                      setState(() {
                                        _jour = changedValue!;
                                      });
                                    },
                                    value: _jour,
                                    items: list_jour.map((String value) {
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
                            width: 400,
                            height: 50,
                            color: Colors.red,
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.truck,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Vehicule',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("Vehicule")
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
                                            choiceVehicule = changedValue!;
                                          });
                                        },
                                        value: choiceVehicule,
                                        items: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> vehicule =
                                              document.data()!
                                                  as Map<String, dynamic>;

                                          return DropdownMenuItem<String>(
                                            value: vehicule[
                                                'numeroImmatriculation'],
                                            child: new Text(vehicule[
                                                    'nomVehicule'] +
                                                ' ' +
                                                vehicule[
                                                    'numeroImmatriculation']),
                                          );
                                        }).toList(),
                                      );
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
                                print(getTimeText(time: timeStart));
                                print(getTimeText(time: timeEnd));
                                print('$choiceVehicule');
                                print('$_jour');
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
                                if (_frequenceTextController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Input a frequence",
                                      gravity: ToastGravity.TOP);
                                } else if (!_frequenceTextController
                                        .text.isEmpty &&
                                    int.tryParse(
                                            _frequenceTextController.text) ==
                                        null) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please Input a real Number for frequence",
                                      gravity: ToastGravity.TOP);
                                } else if (dateMinimale.isAfter(dateMaximale)) {
                                  Fluttertoast.showToast(
                                      msg: "Please check your day",
                                      gravity: ToastGravity.TOP);
                                } else if (!_frequenceTarifController
                                        .text.isEmpty &&
                                    int.tryParse(
                                            _frequenceTarifController.text) ==
                                        null) {
                                } else if (toDouble(timeStart) >
                                    toDouble(timeEnd)) {
                                  Fluttertoast.showToast(
                                      msg: "Please check your time",
                                      gravity: ToastGravity.TOP);
                                } else {
                                  await _partenaire
                                      .where('idPartenaire',
                                          isEqualTo:
                                              widget.partenaire['idPartenaire'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _partenaire.doc(doc.id).update({
                                        'nombredeFrequence': (int.parse(
                                                    widget.partenaire[
                                                        'nombredeFrequence']) +
                                                1)
                                            .toString(),
                                      });
                                    });
                                  });
                                  await _vehicule
                                      .where('numeroImmatriculation',
                                          isEqualTo: choiceVehicule)
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      idVehiculeFrequence = doc['idVehicule'];
                                    });
                                  });
                                  String newIdFrequence = _frequence.doc().id;
                                  await _frequence.doc(newIdFrequence).set({
                                    'frequence': _frequenceTextController.text,
                                    'jourFrequence': _jour,
                                    'siretPartenaire':
                                        _siretPartenaireController.text,
                                    'idContactFrequence': 'null',
                                    'idVehiculeFrequence': idVehiculeFrequence,
                                    'idAdresseFrequence':
                                        dataAdresse['idAdresse'],
                                    'nomAdresseFrequence':
                                        dataAdresse['nomPartenaireAdresse'],
                                    'idPartenaireFrequence':
                                        widget.partenaire['idPartenaire'],
                                    'dureeFrequence': (toMinute(timeEnd) -
                                            toMinute(timeStart))
                                        .toString(),
                                    'startFrequence':
                                        getTimeText(time: timeStart),
                                    'endFrequence': getTimeText(time: timeEnd),
                                    'tarifFrequence':
                                        _frequenceTarifController.text,
                                    'dateMinimaleFrequence':
                                        getDateText(date: dateMinimale),
                                    'dateMaximaleFrequence':
                                        getDateText(date: dateMaximale),
                                    'idFrequence': newIdFrequence
                                  }).then((value) async {
                                    await _partenaire
                                        .where('idPartenaire',
                                            isEqualTo: widget
                                                .partenaire['idPartenaire'])
                                        .limit(1)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        Map<String, dynamic> next_partenaire =
                                            doc.data()! as Map<String, dynamic>;
                                        print("Frequence Added");
                                        Fluttertoast.showToast(
                                            msg: "Frequence Added",
                                            gravity: ToastGravity.TOP);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ModifyAdressePartenairePage(
                                                    partenaire: next_partenaire,
                                                    dataAdresse:
                                                        widget.dataAdresse,
                                                    form_start: 1,
                                                  )),
                                        ).then((value) => setState(() {}));
                                      });
                                    });
                                  }).catchError((error) =>
                                      print("Failed to update user: $error"));
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
                ]),
          ));
        });
  }
}
