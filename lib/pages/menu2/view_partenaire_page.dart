import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/math_function/toDouble.dart';
import 'package:tn09_app_web_demo/pages/menu2/create_adresse_full_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/create_adresse_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/conver_string_bool.dart';
import 'package:tn09_app_web_demo/pages/math_function/frequence_title.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_time_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/is_Inconnu.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/menu2/modify_addresse_multiple.dart';
import 'package:tn09_app_web_demo/pages/menu2/modify_adresse_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_contact_page.dart';
import 'package:tn09_app_web_demo/pages/widget/bool_icon.dart';
import 'package:tn09_app_web_demo/pages/widget/button_widget.dart';
import 'package:tn09_app_web_demo/pages/menu2/modify_frequence_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

import '../math_function/toMinute.dart';

class ViewPartenairePage extends StatefulWidget {
  Map partenaire;
  ViewPartenairePage({
    required this.partenaire,
  });
  @override
  _ViewPartenairePageState createState() => _ViewPartenairePageState();
}

class _ViewPartenairePageState extends State<ViewPartenairePage> {
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
  String oldtypePartenaire = '';
  List<String> list_type = ['PRIVE', 'PUBLIC', 'EXPERIMENTATION', 'AUTRES'];
  String _actifPartenaire = 'true';

  // Init Data
  void initState() {
    setState(() {
      _nomPartenaireController.text = widget.partenaire['nomPartenaire'];
      _notePartenaireController.text = widget.partenaire['notePartenaire'];
      _siretPartenaireController.text = widget.partenaire['siretPartenaire'];
      _actifPartenaire = widget.partenaire['actifPartenaire'];
      _typePartenaire = widget.partenaire['idTypePartenaire'] == ''
          ? 'null'
          : widget.partenaire['idTypePartenaire'];
      oldtypePartenaire = widget.partenaire['idTypePartenaire'] == ''
          ? 'null'
          : widget.partenaire['idTypePartenaire'];
    });
    super.initState();
  }

  Map<String, String> test = {};
  // For Relation Table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");
  // For Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");

  //for Adresse
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
  final _createAdressesKeyForm = GlobalKey<FormState>();
  TextEditingController _nomPartenaireAdresseController =
      TextEditingController();
  TextEditingController _ligne1AdresseController = TextEditingController();
  TextEditingController _ligne2AdresseController = TextEditingController();
  TextEditingController _codepostalAdresseController = TextEditingController();
  TextEditingController _villeAdresseController = TextEditingController();
  TextEditingController _paysAdresseController = TextEditingController();
  TextEditingController _latitudeAdresseController = TextEditingController();
  TextEditingController _longitudeAdresseController = TextEditingController();
  TextEditingController _etageAdresseController = TextEditingController();
  String _ascenseurAdresse = 'true';
  TextEditingController _noteAdresseController = TextEditingController();
  String _passagesAdresse = 'true';
  String _facturationAdresse = 'true';
  TextEditingController _tarifpassageAdresseController =
      TextEditingController();
  TextEditingController _tempspassageAdresseController =
      TextEditingController();
  TextEditingController _surfacepassageAdresseController =
      TextEditingController();

  //for modify Adresse
  final _modifyAdressesKeyForm = GlobalKey<FormState>();
  TextEditingController _nomPartenaireAdresseModifyController =
      TextEditingController();
  TextEditingController _ligne1AdresseModifyController =
      TextEditingController();
  TextEditingController _ligne2AdresseModifyController =
      TextEditingController();
  TextEditingController _codepostalAdresseModifyController =
      TextEditingController();
  TextEditingController _villeAdresseModifyController = TextEditingController();
  TextEditingController _paysAdresseModifyController = TextEditingController();
  TextEditingController _latitudeAdresseModifyController =
      TextEditingController();
  TextEditingController _longitudeAdresseModifyController =
      TextEditingController();
  TextEditingController _etageAdresseModifyController = TextEditingController();
  TextEditingController _noteAdresseModifyController = TextEditingController();
  TextEditingController _tarifpassageAdresseModifyController =
      TextEditingController();
  TextEditingController _tempspassageAdresseModifyController =
      TextEditingController();
  TextEditingController _surfacepassageAdresseModifyController =
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
  //for Contenant
  CollectionReference _contenant =
      FirebaseFirestore.instance.collection("Contenant");
  //for Etape
  CollectionReference _etape = FirebaseFirestore.instance.collection('Etape');
  // build Vehicule for Frequence
  Widget buildVehiculeFrequence({required idVehiculeFrequence}) {
    if (idVehiculeFrequence == 'null') {
      return Container(
        width: 550,
        height: 20,
        color: Color(graphique.color['default_green']),
        child: Row(
          children: [
            SizedBox(width: 20),
            Icon(
              FontAwesomeIcons.truck,
              size: 15,
              color: Color(graphique.color['default_red']),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Inconnu',
              style: TextStyle(
                color: Color(graphique.color['default_black']),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Vehicule")
            .where('idVehicule', isEqualTo: idVehiculeFrequence)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> vehicule =
                  document.data()! as Map<String, dynamic>;
              return Container(
                width: MediaQuery.of(context).size.width * 0.45 * 0.9,
                height: 20,
                color: Color(graphique.color['default_green']),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    buildVehiculeIcon(
                        icontype: vehicule['typeVehicule'],
                        iconcolor: vehicule['colorIconVehicule'].toUpperCase(),
                        sizeIcon: 15.0),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      vehicule['nomVehicule'],
                      style: TextStyle(
                        color: Color(graphique.color['default_black']),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // For width of table
    double column1_width = MediaQuery.of(context).size.width * 0.45;
    double column2_width = MediaQuery.of(context).size.width * 0.45;

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
                      text: graphique.languagefr['view_partenaire_page']
                              ['nom_page'] +
                          ': ' +
                          widget.partenaire['nomPartenaire'],
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
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //Partenaire Form
            Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),
                width: column1_width,
                height: 750,
                decoration: BoxDecoration(
                  color: Color(graphique.color['special_bureautique_2']),
                  border: Border.all(
                      width: 1.0,
                      color: Color(graphique.color['default_black'])),
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
                      children: [
                        const SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.flag,
                          size: 17,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          graphique.languagefr['view_partenaire_page']
                              ['partenaire_form']['nom_form'],
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
                          graphique.languagefr['view_partenaire_page']
                              ['partenaire_form']['form_subtitle'],
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
                    width: column1_width * 2 / 3,
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
                                          .languagefr['view_partenaire_page']
                                      ['partenaire_form']['field_1_title'],
                                  labelStyle: TextStyle(
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
                                          .languagefr['view_partenaire_page']
                                      ['partenaire_form']['field_2_title'],
                                  labelStyle: TextStyle(
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
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      graphique.languagefr[
                                              'view_partenaire_page']
                                          ['partenaire_form']['field_3_title'],
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
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
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
                                            Map<String, dynamic>
                                                typepartenaire =
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }),
                                  // DropdownButton<String>(
                                  //   onChanged: (String? changedValue) {
                                  //     setState(() {
                                  //       _typePartenaire = changedValue!;
                                  //       // print(
                                  //       //     '$_typePartenaire  $changedValue');
                                  //     });
                                  //   },
                                  //   value: _typePartenaire,
                                  //   items: list_type.map((String value) {
                                  //     return new DropdownMenuItem<String>(
                                  //       value: value,
                                  //       child: Text(
                                  //         value,
                                  //         style: TextStyle(
                                  //             fontSize: 16,
                                  //             color: Color(graphique
                                  //                 .color['main_color_2']),
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //     );
                                  //   }).toList(),
                                  // ),
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
                                    graphique.languagefr['view_partenaire_page']
                                        ['partenaire_form']['field_4_title'],
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
                                    graphique.languagefr['view_partenaire_page']
                                        ['partenaire_form']['field_4_choice_1'],
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(
                                          graphique.color['default_black']),
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
                                    graphique.languagefr['view_partenaire_page']
                                        ['partenaire_form']['field_4_choice_2'],
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(
                                          graphique.color['default_black']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        Color(graphique.color['main_color_1']),
                                  ),
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
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
                                              'view_partenaire_page']
                                          ['partenaire_form']['field_5_title'],
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
                    width: column1_width * 3 / 4,
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
                              onTap: () async {
                                if (_typePartenaire == 'null') {
                                  Fluttertoast.showToast(
                                      msg: "Your Type Partenaire is Null",
                                      gravity: ToastGravity.TOP);
                                } else if (_createPartenaireKeyForm
                                    .currentState!
                                    .validate()) {
                                  String new_nomTypePartenaire = '';
                                  if (_typePartenaire != oldtypePartenaire) {
                                    await FirebaseFirestore.instance
                                        .collection("TypePartenaire")
                                        .where('idTypePartenaire',
                                            isEqualTo: _typePartenaire)
                                        .limit(1)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs
                                          .forEach((doc_typepartenaire) async {
                                        new_nomTypePartenaire =
                                            doc_typepartenaire[
                                                'nomTypePartenaire'];
                                        await FirebaseFirestore.instance
                                            .collection("TypePartenaire")
                                            .doc(_typePartenaire)
                                            .update({
                                          'nombre': (int.parse(
                                                      doc_typepartenaire[
                                                          'nombre']) +
                                                  1)
                                              .toString(),
                                        });
                                      });
                                    });
                                    await FirebaseFirestore.instance
                                        .collection("TypePartenaire")
                                        .where('idTypePartenaire',
                                            isEqualTo: oldtypePartenaire)
                                        .limit(1)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs
                                          .forEach((doc_typepartenaire) async {
                                        await FirebaseFirestore.instance
                                            .collection("TypePartenaire")
                                            .doc(doc_typepartenaire.id)
                                            .update({
                                          'nombre': (int.parse(
                                                      doc_typepartenaire[
                                                          'nombre']) -
                                                  1)
                                              .toString(),
                                        });
                                      });
                                    });
                                  }
                                  await _partenaire
                                      .where('idPartenaire',
                                          isEqualTo:
                                              widget.partenaire['idPartenaire'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _partenaire.doc(doc.id).update({
                                        'nomPartenaire':
                                            _nomPartenaireController.text,
                                        'notePartenaire':
                                            _notePartenaireController.text,
                                        'siretPartenaire':
                                            _siretPartenaireController.text,
                                        'idContactPartenaire': 'null',
                                        'actifPartenaire': _actifPartenaire,
                                        'idTypePartenaire': _typePartenaire,
                                        'typePartenaire': new_nomTypePartenaire,
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
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Update Information Partenaire",
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
                                      }).catchError((error) => print(
                                          "Failed to update user: $error"));
                                    });
                                  });
                                }
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
                                    graphique.languagefr['view_partenaire_page']
                                        ['partenaire_form']['button_1'],
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
                ])),
            //Contact Form
            Container(
              height: 300 +
                  100 * double.parse(widget.partenaire['nombredeContact']),
              margin: const EdgeInsets.only(
                left: 20,
                top: 20,
                bottom: 20,
              ),
              width: column1_width,
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
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.users,
                          size: 17,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          graphique.languagefr['view_partenaire_page']
                              ['contact_form']['nom_form'],
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
                          FontAwesomeIcons.users,
                          size: 15,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          graphique.languagefr['view_partenaire_page']
                              ['contact_form']['column_1_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Text(
                          graphique.languagefr['view_partenaire_page']
                              ['contact_form']['column_2_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          graphique.languagefr['view_partenaire_page']
                              ['contact_form']['column_3_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          graphique.languagefr['view_partenaire_page']
                              ['contact_form']['column_4_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          graphique.languagefr['view_partenaire_page']
                              ['contact_form']['column_5_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("ContactPartenaire")
                        .where('idPartenaire',
                            isEqualTo: widget.partenaire['idPartenaire'])
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      return Column(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> link_contactpartenaire =
                              document.data()! as Map<String, dynamic>;

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(graphique.color['main_color_1']),
                              border: Border.all(
                                  width: 1.0,
                                  color:
                                      Color(graphique.color['default_black'])),
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Contact")
                                  .where('idContact',
                                      isEqualTo:
                                          link_contactpartenaire['idContact'])
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
                                    Map<String, dynamic> dataContact = document
                                        .data()! as Map<String, dynamic>;

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 20),
                                          Container(
                                            width: 100,
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: limitString(
                                                          text: dataContact[
                                                                  'nomContact'] +
                                                              ' ' +
                                                              dataContact[
                                                                  'prenomContact'],
                                                          limit_long: 15),
                                                      style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_red']),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                  builder: (context) => ViewContactPage(
                                                                      partenaire:
                                                                          widget
                                                                              .partenaire,
                                                                      from:
                                                                          'viewpartenairepage',
                                                                      dataContact:
                                                                          dataContact)));
                                                            }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 100),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            color: Color(graphique
                                                .color['main_color_1']),
                                            child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection(
                                                      "ContactPartenaire")
                                                  .where('idPartenaire',
                                                      isEqualTo:
                                                          widget.partenaire[
                                                              'idPartenaire'])
                                                  .where('idContact',
                                                      isEqualTo: dataContact[
                                                          'idContact'])
                                                  .limit(1)
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Something went wrong');
                                                }

                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                }
                                                // print('$snapshot');
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_link_contactpartenaire) {
                                                    Map<String, dynamic>
                                                        link_datacontactpartenaire =
                                                        document_link_contactpartenaire
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    // print('$contenant');
                                                    return Container(
                                                        color: Color(graphique
                                                                .color[
                                                            'main_color_1']),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              icon: buildBoolIcon(
                                                                  check: convertBool(
                                                                      check: link_datacontactpartenaire[
                                                                          'isPrincipal']),
                                                                  sizeIcon: 15),
                                                              tooltip: graphique
                                                                              .languagefr[
                                                                          'view_partenaire_page']
                                                                      [
                                                                      'contact_form']
                                                                  [
                                                                  'hint_text_1'],
                                                              onPressed:
                                                                  () async {
                                                                if (convertBool(
                                                                    check: link_datacontactpartenaire[
                                                                        'isPrincipal'])) {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "It's already principale",
                                                                      gravity:
                                                                          ToastGravity
                                                                              .TOP);
                                                                } else {
                                                                  await _contactpartenaire
                                                                      .where(
                                                                          'idPartenaire',
                                                                          isEqualTo: widget.partenaire[
                                                                              'idPartenaire'])
                                                                      // .where(
                                                                      //     'idContact',
                                                                      //     isNotEqualTo: dataContact[
                                                                      //         'idContact'])
                                                                      .get()
                                                                      .then((QuerySnapshot
                                                                          querySnapshot) {
                                                                    querySnapshot
                                                                        .docs
                                                                        .forEach(
                                                                            (doc) {
                                                                      _contactpartenaire
                                                                          .doc(doc
                                                                              .id)
                                                                          .update({
                                                                        'isPrincipal':
                                                                            'false'
                                                                      });
                                                                    });
                                                                  });
                                                                  await _contactpartenaire
                                                                      .where(
                                                                          'idContact',
                                                                          isEqualTo: dataContact[
                                                                              'idContact'])
                                                                      .where(
                                                                          'idPartenaire',
                                                                          isEqualTo: widget.partenaire[
                                                                              'idPartenaire'])
                                                                      .get()
                                                                      .then((QuerySnapshot
                                                                          querySnapshot) {
                                                                    querySnapshot
                                                                        .docs
                                                                        .forEach(
                                                                            (doc) {
                                                                      _contactpartenaire
                                                                          .doc(doc
                                                                              .id)
                                                                          .update({
                                                                        'isPrincipal':
                                                                            'true'
                                                                      });
                                                                    });
                                                                  });

                                                                  //update principal contact inside partenaire
                                                                  await _partenaire
                                                                      .where(
                                                                          'idPartenaire',
                                                                          isEqualTo: widget.partenaire[
                                                                              'idPartenaire'])
                                                                      .limit(1)
                                                                      .get()
                                                                      .then((QuerySnapshot
                                                                          querySnapshot) {
                                                                    querySnapshot
                                                                        .docs
                                                                        .forEach(
                                                                            (doc) {
                                                                      _partenaire
                                                                          .doc(doc
                                                                              .id)
                                                                          .update({
                                                                        'idContactPartenaire':
                                                                            link_contactpartenaire['idContact']
                                                                      });
                                                                    });
                                                                  });
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Information Modified",
                                                                      gravity:
                                                                          ToastGravity
                                                                              .TOP);
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            ViewPartenairePage(
                                                                              partenaire: widget.partenaire,
                                                                            )),
                                                                  ).then((value) =>
                                                                      setState(
                                                                          () {}));
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ));
                                                  }).toList(),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 50),
                                          IconButton(
                                            icon: buildBoolIcon(
                                                check: convertBool(
                                                    check: dataContact[
                                                        'recoitRapport']),
                                                sizeIcon: 15),
                                            tooltip: graphique.languagefr[
                                                    'view_partenaire_page']
                                                ['contact_form']['hint_text_1'],
                                            onPressed: () async {
                                              await _contact
                                                  .where('idContact',
                                                      isEqualTo: dataContact[
                                                          'idContact'])
                                                  .limit(1)
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  _contact.doc(doc.id).update({
                                                    'recoitRapport': (!convertBool(
                                                            check: dataContact[
                                                                'recoitRapport']))
                                                        .toString(),
                                                  }).then((value) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Information Modified",
                                                        gravity:
                                                            ToastGravity.TOP);
                                                  }).catchError((error) => print(
                                                      "Failed to update user: $error"));
                                                });
                                              });
                                            },
                                          ),
                                          SizedBox(width: 50),
                                          IconButton(
                                            icon: buildBoolIcon(
                                                check: convertBool(
                                                    check: dataContact[
                                                        'recoitFacture']),
                                                sizeIcon: 15),
                                            tooltip: graphique.languagefr[
                                                    'view_partenaire_page']
                                                ['contact_form']['hint_text_1'],
                                            onPressed: () async {
                                              await _contact
                                                  .where('idContact',
                                                      isEqualTo: dataContact[
                                                          'idContact'])
                                                  .limit(1)
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  _contact.doc(doc.id).update({
                                                    'recoitFacture': (!convertBool(
                                                            check: dataContact[
                                                                'recoitFacture']))
                                                        .toString(),
                                                  }).then((value) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Information Modified",
                                                        gravity:
                                                            ToastGravity.TOP);
                                                  }).catchError((error) => print(
                                                      "Failed to update user: $error"));
                                                });
                                              });
                                            },
                                          ),
                                          SizedBox(width: 40),
                                          IconButton(
                                            icon: buildBoolIcon(
                                                check: convertBool(
                                                    check: dataContact[
                                                        'accessExtranet']),
                                                sizeIcon: 15),
                                            tooltip: graphique.languagefr[
                                                    'view_partenaire_page']
                                                ['contact_form']['hint_text_1'],
                                            onPressed: () async {
                                              await _contact
                                                  .where('idContact',
                                                      isEqualTo: dataContact[
                                                          'idContact'])
                                                  .limit(1)
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  _contact.doc(doc.id).update({
                                                    'accessExtranet': (!convertBool(
                                                            check: dataContact[
                                                                'accessExtranet']))
                                                        .toString(),
                                                  }).then((value) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Information Modified",
                                                        gravity:
                                                            ToastGravity.TOP);
                                                  }).catchError((error) => print(
                                                      "Failed to update user: $error"));
                                                });
                                              });
                                            },
                                          ),
                                          SizedBox(width: 20),
                                          IconButton(
                                            icon: Icon(FontAwesomeIcons.trash,
                                                size: 15,
                                                color: Color(graphique
                                                    .color['default_black'])),
                                            tooltip: graphique.languagefr[
                                                    'view_partenaire_page']
                                                ['contact_form']['hint_text_2'],
                                            onPressed: () async {
                                              await _contact
                                                  .where('idContact',
                                                      isEqualTo: dataContact[
                                                          'idContact'])
                                                  .limit(1)
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  _contact.doc(doc.id).update({
                                                    'nombredePartenaire':
                                                        (int.parse(doc[
                                                                    'nombredePartenaire']) -
                                                                1)
                                                            .toString(),
                                                  });
                                                });
                                              });
                                              await _partenaire
                                                  .where('idPartenaire',
                                                      isEqualTo:
                                                          widget.partenaire[
                                                              'idPartenaire'])
                                                  .limit(1)
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  _partenaire
                                                      .doc(doc.id)
                                                      .update({
                                                    'nombredeContact':
                                                        (int.parse(doc[
                                                                    'nombredeContact']) -
                                                                1)
                                                            .toString(),
                                                  }).then((value) {
                                                    if (doc['nombredeContact'] ==
                                                        '0') {
                                                      _partenaire
                                                          .doc(doc.id)
                                                          .update({
                                                        'idContactPartenaire':
                                                            'null',
                                                      });
                                                    }
                                                  });
                                                });
                                              });
                                              await _contactpartenaire
                                                  .where('idContact',
                                                      isEqualTo: dataContact[
                                                          'idContact'])
                                                  .where('idPartenaire',
                                                      isEqualTo:
                                                          widget.partenaire[
                                                              'idPartenaire'])
                                                  .limit(1)
                                                  .get()
                                                  .then((QuerySnapshot
                                                      querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  _contactpartenaire
                                                      .doc(doc.id)
                                                      .delete()
                                                      .then((value) async {
                                                    await _adresse
                                                        .where(
                                                            'idPartenaireAdresse',
                                                            isEqualTo: widget
                                                                    .partenaire[
                                                                'idPartenaire'])
                                                        .get()
                                                        .then((QuerySnapshot
                                                            querySnapshot) {
                                                      querySnapshot.docs.forEach(
                                                          (docAdresse) async {
                                                        QuerySnapshot query =
                                                            await _contactadresse
                                                                .where(
                                                                    'idAdresse',
                                                                    isEqualTo:
                                                                        docAdresse[
                                                                            'idAdresse'])
                                                                .where(
                                                                    'idContact',
                                                                    isEqualTo:
                                                                        dataContact[
                                                                            'idContact'])
                                                                .get();
                                                        if (query
                                                            .docs.isNotEmpty) {
                                                          _adresse
                                                              .doc(
                                                                  docAdresse.id)
                                                              .update({
                                                            'nombredeContact':
                                                                (int.parse(docAdresse[
                                                                            'nombredeContact']) -
                                                                        1)
                                                                    .toString(),
                                                          });
                                                          await _contactadresse
                                                              .where(
                                                                  'idAdresse',
                                                                  isEqualTo:
                                                                      docAdresse[
                                                                          'idAdresse'])
                                                              .where(
                                                                  'idContact',
                                                                  isEqualTo:
                                                                      dataContact[
                                                                          'idContact'])
                                                              .get()
                                                              .then((QuerySnapshot
                                                                  querySnapshot) {
                                                            querySnapshot.docs
                                                                .forEach(
                                                                    (doccontactadresse) {
                                                              _contactadresse
                                                                  .doc(
                                                                      doccontactadresse
                                                                          .id)
                                                                  .delete();
                                                            });
                                                          });
                                                        }
                                                      });
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Information Modified",
                                                        gravity:
                                                            ToastGravity.TOP);
                                                  }).catchError((error) => print(
                                                          "Failed to update user: $error"));
                                                });
                                              });
                                            },
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
                      );
                    },
                  ),
                ],
              ),
            )
          ]),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 200 +
                      300 * double.parse(widget.partenaire['nombredeAdresses']),
                  margin: const EdgeInsets.only(
                    right: 20,
                    top: 20,
                    bottom: 20,
                  ),
                  width: column2_width,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(
                                    FontAwesomeIcons.mapMarker,
                                    size: 17,
                                    color:
                                        Color(graphique.color['main_color_2']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['view_partenaire_page']
                                        ['adresse_form']['nom_form'],
                                    style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontSize: 17,
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
                                  right: 10,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // showCreateAdressesDialog();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateAdresseFullPage(
                                                  partenaire: widget.partenaire,
                                                )));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(
                                            graphique.color['default_black']),
                                      ),
                                      Text(
                                        graphique.languagefr[
                                                'view_partenaire_page']
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
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Adresse")
                              .where('idPartenaireAdresse',
                                  isEqualTo: widget.partenaire['idPartenaire'])
                              .orderBy('nomPartenaireAdresse')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('${snapshot.error.toString()}');
                              return Text(
                                  'Something went wrong + ${snapshot.error.toString()} + ${widget.partenaire['idPartenaire'].toString()}');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> adresse =
                                    document.data()! as Map<String, dynamic>;
                                if (adresse['idAdresse'] == 'null') {
                                  return SizedBox.shrink();
                                }
                                // print('$contenant');
                                return Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  width: column2_width * 0.9,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color:
                                        Color(graphique.color['main_color_1']),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Color(
                                            graphique.color['default_black'])),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Color(
                                            graphique.color['main_color_1']),
                                        width: column2_width * 0.9,
                                        height: 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: column2_width * 0.9,
                                              decoration: BoxDecoration(
                                                color: Color(graphique
                                                    .color['default_blue']),
                                                border: Border(
                                                  bottom: BorderSide(
                                                    width: 1.0,
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .locationArrow,
                                                          size: 15,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          adresse[
                                                              'nomPartenaireAdresse'],
                                                          style: TextStyle(
                                                            color: Color(graphique
                                                                    .color[
                                                                'default_black']),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_yellow']),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // showModifyAdressDialog(
                                                          //     context: context,
                                                          //     dataAdresse:
                                                          //         adresse);
                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                          //     builder: (context) =>
                                                          //         ModifyAdressePartenairePage(
                                                          //             partenaire:
                                                          //                 widget
                                                          //                     .partenaire,
                                                          //             dataAdresse:
                                                          //                 adresse,
                                                          //             form_start:
                                                          //                 1)));
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ModifyAddresseMultiple(
                                                                      partenaire:
                                                                          widget
                                                                              .partenaire,
                                                                      dataAdresse:
                                                                          adresse,
                                                                      form_start:
                                                                          1)));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color: Color(graphique
                                                                      .color[
                                                                  'default_black']),
                                                            ),
                                                            Text(
                                                              graphique.languagefr[
                                                                          'view_partenaire_page']
                                                                      [
                                                                      'adresse_form']
                                                                  [
                                                                  'sub_form_button_1'],
                                                              style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 40),
                                              height: 100,
                                              width: column2_width * 0.9,
                                              decoration: BoxDecoration(
                                                color: Color(graphique
                                                    .color['default_green']),
                                                border: Border(
                                                  top: BorderSide(
                                                    width: 1.0,
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 1.0,
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .mapMarker,
                                                        size: 15,
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        adresse['ligne1Adresse'] +
                                                            ' ' +
                                                            adresse[
                                                                'codepostalAdresse'] +
                                                            ' ' +
                                                            adresse[
                                                                'villeAdresse'],
                                                        style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons.clock,
                                                        size: 15,
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Durée ' +
                                                            isInconnu(
                                                                text: adresse[
                                                                    'tempspassageAdresse']) +
                                                            ' min',
                                                        style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .moneyCheckAlt,
                                                        size: 15,
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Tarif ' +
                                                            isInconnu(
                                                                text: adresse[
                                                                    'tarifpassageAdresse']) +
                                                            ' €',
                                                        style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .truckLoading,
                                                        size: 15,
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Surface ' +
                                                            isInconnu(
                                                                text: adresse[
                                                                    'surfacepassageAdresse']) +
                                                            ' €',
                                                        style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .exclamationTriangle,
                                                          size: 15,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          isInconnu(
                                                              text: adresse[
                                                                  'noteAdresse']),
                                                          style: TextStyle(
                                                            color: Color(graphique
                                                                    .color[
                                                                'default_black']),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          })
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 100 +
                            300 *
                                double.parse(
                                    widget.partenaire['nombredeFrequence']),
                        margin: const EdgeInsets.only(
                          right: 20,
                          top: 20,
                          bottom: 20,
                        ),
                        width: column2_width,
                        decoration: BoxDecoration(
                          color:
                              Color(graphique.color['special_bureautique_2']),
                          border: Border.all(
                              width: 1.0,
                              color: Color(graphique.color['default_black'])),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(graphique.color['main_color_1']),
                                border: Border.all(
                                    width: 1.0,
                                    color: Color(
                                        graphique.color['default_black'])),
                              ),
                              margin: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 17,
                                          color: Color(
                                              graphique.color['main_color_2']),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          graphique.languagefr[
                                                  'view_partenaire_page']
                                              ['frequence_form']['nom_form'],
                                          style: TextStyle(
                                            color: Color(graphique
                                                .color['main_color_2']),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Color(graphique
                                              .color['default_yellow']),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          //Update later
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              graphique.languagefr[
                                                      'view_partenaire_page'][
                                                  'frequence_form']['button_1'],
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
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Frequence")
                                    .where('idPartenaireFrequence',
                                        isEqualTo:
                                            widget.partenaire['idPartenaire'])
                                    .orderBy('nomAdresseFrequence')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    print('${snapshot.error.toString()}');
                                    return Text(
                                        'Something went wrong + ${snapshot.error.toString()} + ${widget.partenaire['idPartenaire'].toString()}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      Map<String, dynamic> frequence = document
                                          .data()! as Map<String, dynamic>;
                                      // print('$contenant');
                                      if (frequence['idFrequence'] == 'null') {
                                        return SizedBox.shrink();
                                      }
                                      return Container(
                                        width: column2_width * 0.9,
                                        height: 300,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: column2_width * 0.9,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  color: Color(graphique
                                                      .color['main_color_1']),
                                                  border: Border.all(
                                                    width: 1.0,
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
                                                  )),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: column2_width * 0.9,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_blue']),
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .check,
                                                                size: 15,
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_green']),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                titleFrequence(
                                                                    frequence:
                                                                        frequence[
                                                                            'frequence'],
                                                                    jourFrequence:
                                                                        frequence[
                                                                            'jourFrequence']),
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        graphique.color[
                                                                            'default_black']),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            width: 180,
                                                            decoration: BoxDecoration(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_yellow']),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 10,
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                // modifyFrequence(
                                                                //     dataFrequence:
                                                                //         frequence);
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ModifyFrequencePartenairePage(
                                                                          partenaire: widget
                                                                              .partenaire,
                                                                          dataFrequence:
                                                                              frequence)),
                                                                ).then((value) =>
                                                                    setState(
                                                                        () {}));
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        graphique
                                                                            .color['default_black']),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    graphique.languagefr['view_partenaire_page']
                                                                            [
                                                                            'frequence_form']
                                                                        [
                                                                        'sub_form_button_1'],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          graphique
                                                                              .color['default_black']),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 120,
                                                    width: column2_width * 0.9,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_green']),
                                                      border: Border(
                                                        top: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                      ),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .locationArrow,
                                                              size: 15,
                                                              color: Color(graphique
                                                                      .color[
                                                                  'default_black']),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              frequence[
                                                                  'nomAdresseFrequence'],
                                                              style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        buildVehiculeFrequence(
                                                            idVehiculeFrequence:
                                                                frequence[
                                                                    'idVehiculeFrequence']),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .clock,
                                                              size: 15,
                                                              color: Color(graphique
                                                                      .color[
                                                                  'default_black']),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Durée ' +
                                                                  frequence[
                                                                      'dureeFrequence'] +
                                                                  ' min',
                                                              style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .moneyCheckAlt,
                                                              size: 15,
                                                              color: Color(graphique
                                                                      .color[
                                                                  'default_black']),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Tarif ' +
                                                                  isInconnu(
                                                                      text: frequence[
                                                                          'tarifFrequence']) +
                                                                  ' €',
                                                              style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 16,
                                                              ),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .calendarWeek,
                                                                size: 15,
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .greaterThanEqual,
                                                                size: 15,
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                frequence[
                                                                    'dateMinimaleFrequence'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(graphique
                                                                          .color[
                                                                      'default_black']),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .calendarWeek,
                                                                size: 15,
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .lessThanEqual,
                                                                size: 15,
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                frequence[
                                                                    'dateMaximaleFrequence'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(graphique
                                                                          .color[
                                                                      'default_black']),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ]),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 300 +
                            double.parse(
                                    widget.partenaire['nombredeAdresses']) *
                                500,
                        margin: const EdgeInsets.only(
                          right: 20,
                          top: 20,
                          bottom: 20,
                        ),
                        width: column2_width,
                        decoration: BoxDecoration(
                          color:
                              Color(graphique.color['special_bureautique_2']),
                          border: Border.all(
                              width: 1.0,
                              color: Color(graphique.color['default_black'])),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(graphique.color['main_color_1']),
                                border: Border.all(
                                  width: 1.0,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Row(children: [
                                    SizedBox(width: 20),
                                    Icon(
                                      FontAwesomeIcons.boxOpen,
                                      size: 17,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      graphique.languagefr[
                                              'view_partenaire_page']
                                          ['contenant_form']['nom_form'],
                                      style: TextStyle(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ])),
                                  Container(
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Color(graphique
                                              .color['default_yellow']),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          //Update later
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              graphique.languagefr[
                                                      'view_partenaire_page'][
                                                  'contenant_form']['button_1'],
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
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Adresse")
                                    .where('idPartenaireAdresse',
                                        isEqualTo:
                                            widget.partenaire['idPartenaire'])
                                    .orderBy('nomPartenaireAdresse')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                        'Something went wrong + ${snapshot.error.toString()} + ${widget.partenaire['idPartenaire'].toString()}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      Map<String, dynamic> adresse = document
                                          .data()! as Map<String, dynamic>;
                                      TextEditingController
                                          _typeContenantController =
                                          TextEditingController();
                                      TextEditingController _quality =
                                          TextEditingController();
                                      String choiceType = 'None';
                                      // print('$contenant');
                                      if (adresse['idAdresse'] == 'null') {
                                        return SizedBox.shrink();
                                      }
                                      return Container(
                                        width: column2_width,
                                        height: 600,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              width: column2_width * 0.9,
                                              height: 500,
                                              decoration: BoxDecoration(
                                                color: Color(graphique
                                                    .color['main_color_1']),
                                                border: Border.all(
                                                  width: 1.0,
                                                  color: Color(graphique
                                                      .color['default_black']),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: column2_width * 0.9,
                                                    color: Color(graphique
                                                        .color['default_blue']),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .boxOpen,
                                                              size: 15,
                                                              color: Color(graphique
                                                                      .color[
                                                                  'default_black']),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              adresse['nomPartenaireAdresse'] +
                                                                  ': ',
                                                              style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Informations sur les contenant',
                                                              style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'default_black']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // This is a Button
                                                        // Container(
                                                        //     width: 150,
                                                        //     decoration: BoxDecoration(
                                                        //         color: Colors
                                                        //             .yellow,
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //                 10)),
                                                        //     margin:
                                                        //         const EdgeInsets
                                                        //             .only(
                                                        //       right: 10,
                                                        //     ),
                                                        //     child:
                                                        //         GestureDetector(
                                                        //       onTap: () {
                                                        //         // AddContenantAdressDialog(
                                                        //         //     context:
                                                        //         //         context,
                                                        //         //     dataAdresse:
                                                        //         //         adresse);
                                                        //       },
                                                        //       child: Row(
                                                        //         children: [
                                                        //           Icon(
                                                        //             Icons
                                                        //                 .add,
                                                        //             color: Colors
                                                        //                 .white,
                                                        //           ),
                                                        //           SizedBox(
                                                        //             width:
                                                        //                 10,
                                                        //           ),
                                                        //           Text(
                                                        //             'Add Contenant',
                                                        //             style:
                                                        //                 TextStyle(
                                                        //               color:
                                                        //                   Colors.black,
                                                        //               fontSize:
                                                        //                   15,
                                                        //               fontWeight:
                                                        //                   FontWeight.bold,
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //     )),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    height: 40,
                                                    width: column2_width * 0.8,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_green']),
                                                      border: Border(
                                                        top: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        left: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        right: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .locationArrow,
                                                          size: 15,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          graphique.languagefr[
                                                                      'view_partenaire_page']
                                                                  [
                                                                  'contenant_form']
                                                              [
                                                              'sub_column_1_title'],
                                                          style: TextStyle(
                                                            color: Color(graphique
                                                                    .color[
                                                                'default_black']),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: column2_width * 0.8,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_red']),
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        left: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        right: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                      ),
                                                    ),
                                                    height: 150,
                                                    child: StreamBuilder<
                                                            QuerySnapshot>(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Contenant")
                                                            .where(
                                                                'idAdresseContenant',
                                                                isEqualTo: adresse[
                                                                    'idAdresse'])
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    QuerySnapshot>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Something went wrong');
                                                          }

                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return CircularProgressIndicator();
                                                          }
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              children: snapshot
                                                                  .data!.docs
                                                                  .map((DocumentSnapshot
                                                                      document_contenant) {
                                                                Map<String,
                                                                        dynamic>
                                                                    insidedataContenant =
                                                                    document_contenant
                                                                            .data()!
                                                                        as Map<
                                                                            String,
                                                                            dynamic>;

                                                                return SingleChildScrollView(
                                                                  child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                                width: 200,
                                                                                child: Row(children: [
                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    limitString(text: insidedataContenant['typeContenant'] + ' ' + insidedataContenant['barCodeContenant'], limit_long: 30),
                                                                                    style: TextStyle(color: Color(graphique.color['default_black']), fontSize: 15, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ])),
                                                                            Container(
                                                                              width: 80,
                                                                              child: Row(
                                                                                children: [
                                                                                  IconButton(
                                                                                      onPressed: () async {
                                                                                        await _contenant.where('idContenant', isEqualTo: insidedataContenant['idContenant']).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                          querySnapshot.docs.forEach((doc) {
                                                                                            _contenant.doc(doc.id).update({
                                                                                              'idAdresseContenant': 'null',
                                                                                            });
                                                                                          });
                                                                                        });
                                                                                        String typeConenant = insidedataContenant['typeContenant'].replaceAll(' ', '').toLowerCase();
                                                                                        await _contenantadresse.where('idAdresse', isEqualTo: adresse['idAdresse']).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                          querySnapshot.docs.forEach((doc) {
                                                                                            int check_type_exist = 0;
                                                                                            int save_position = 0;
                                                                                            for (int i = 1; i <= int.parse(doc['nombredetype']); i++) {
                                                                                              if (typeConenant == doc['${i.toString()}'].substring(0, doc['$i'].indexOf('/'))) {
                                                                                                print('${doc['${i.toString()}'].substring(0, doc['$i'].indexOf('/'))}');
                                                                                                check_type_exist = 1;
                                                                                                save_position = i;
                                                                                              }
                                                                                            }
                                                                                            String _quality = doc['${save_position.toString()}'].substring(doc['$save_position'].indexOf('/') + 1);
                                                                                            _contenantadresse.doc(doc.id).update({
                                                                                              '${save_position.toString()}': typeConenant + '/' + (int.parse(_quality) - 1).toString(),
                                                                                            }).then((value) {
                                                                                              print("Contenant Updated");
                                                                                              Fluttertoast.showToast(msg: "Contenant Updated", gravity: ToastGravity.TOP);
                                                                                            }).catchError((error) => print("Failed to add user: $error"));
                                                                                          });
                                                                                        });
                                                                                      },
                                                                                      icon: Icon(
                                                                                        FontAwesomeIcons.minus,
                                                                                        size: 15,
                                                                                        color: Color(graphique.color['default_black']),
                                                                                      ))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ]),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          );
                                                        }),
                                                  ),

                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    height: 40,
                                                    width: column2_width * 0.8,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_green']),
                                                      border: Border(
                                                        top: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        left: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        right: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .locationArrow,
                                                                  size: 15,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'Availabe Contenant',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            //This is a button
                                                            // Container(
                                                            //     width: 150,
                                                            //     decoration: BoxDecoration(
                                                            //         color: Colors
                                                            //             .yellow,
                                                            //         borderRadius:
                                                            //             BorderRadius
                                                            //                 .circular(
                                                            //                     10)),
                                                            //     margin:
                                                            //         const EdgeInsets
                                                            //             .only(
                                                            //       right: 10,
                                                            //     ),
                                                            //     child:
                                                            //         GestureDetector(
                                                            //       onTap: () {
                                                            //         // AddContenantAdressDialog(
                                                            //         //     context:
                                                            //         //         context,
                                                            //         //     dataAdresse:
                                                            //         //         adresse);
                                                            //       },
                                                            //       child: Row(
                                                            //         children: [
                                                            //           Icon(
                                                            //             Icons.add,
                                                            //             color: Colors
                                                            //                 .white,
                                                            //           ),
                                                            //           SizedBox(
                                                            //             width: 10,
                                                            //           ),
                                                            //           Text(
                                                            //             'Add Contenant',
                                                            //             style:
                                                            //                 TextStyle(
                                                            //               color: Colors
                                                            //                   .black,
                                                            //               fontSize:
                                                            //                   15,
                                                            //               fontWeight:
                                                            //                   FontWeight
                                                            //                       .bold,
                                                            //             ),
                                                            //           ),
                                                            //         ],
                                                            //       ),
                                                            //     )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    width: column2_width * 0.8,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_red']),
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        left: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                        right: BorderSide(
                                                          width: 1.0,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                        ),
                                                      ),
                                                    ),
                                                    child: StreamBuilder<
                                                        QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Contenant")
                                                          .where(
                                                              'idAdresseContenant',
                                                              isEqualTo: 'null')
                                                          .snapshots(),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                        if (snapshot.hasError) {
                                                          return Text(
                                                              'Something went wrong');
                                                        }

                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return CircularProgressIndicator();
                                                        }
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            children: snapshot
                                                                .data!.docs
                                                                .map((DocumentSnapshot
                                                                    document_contenant) {
                                                              Map<String,
                                                                      dynamic>
                                                                  insidedataContenant =
                                                                  document_contenant
                                                                          .data()!
                                                                      as Map<
                                                                          String,
                                                                          dynamic>;

                                                              return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              200,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(limitString(text: insidedataContenant['typeContenant'] + ' ' + insidedataContenant['barCodeContenant'], limit_long: 30), style: TextStyle(color: Color(graphique.color['default_black']), fontSize: 15, fontWeight: FontWeight.bold)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              80,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              IconButton(
                                                                                  onPressed: () async {
                                                                                    await _contenant.where('idContenant', isEqualTo: insidedataContenant['idContenant']).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                      querySnapshot.docs.forEach((doc) {
                                                                                        _contenant.doc(doc.id).update({
                                                                                          'idAdresseContenant': adresse['idAdresse'],
                                                                                        });
                                                                                      });
                                                                                    });
                                                                                    String typeConenant = insidedataContenant['typeContenant'].replaceAll(' ', '').toLowerCase();
                                                                                    QuerySnapshot query = await FirebaseFirestore.instance.collection('TypeContenant').where('nomTypeContenant', isEqualTo: typeConenant).get();

                                                                                    await _contenantadresse.where('idAdresse', isEqualTo: adresse['idAdresse']).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                      querySnapshot.docs.forEach((doc) {
                                                                                        int check_type_exist = 0;
                                                                                        int save_position = 0;
                                                                                        for (int i = 1; i <= int.parse(doc['nombredetype']); i++) {
                                                                                          if (typeConenant == doc['${i.toString()}'].substring(0, doc['$i'].indexOf('/'))) {
                                                                                            print('${doc['${i.toString()}'].substring(0, doc['$i'].indexOf('/'))}');
                                                                                            check_type_exist = 1;
                                                                                            save_position = i;
                                                                                          }
                                                                                        }

                                                                                        if (check_type_exist == 1) {
                                                                                          String _quality = doc['${save_position.toString()}'].substring(doc['$save_position'].indexOf('/') + 1);
                                                                                          _contenantadresse.doc(doc.id).update({
                                                                                            '${save_position.toString()}': typeConenant + '/' + (int.parse(_quality) + 1).toString(),
                                                                                          }).then((value) {
                                                                                            print("Contenant Updated");
                                                                                            Fluttertoast.showToast(msg: "Contenant Updated", gravity: ToastGravity.TOP);
                                                                                          }).catchError((error) => print("Failed to add user: $error"));
                                                                                        } else {
                                                                                          _contenantadresse.doc(doc.id).update({
                                                                                            '${int.parse(doc['nombredetype']) + 1}': typeConenant + '/' + '1',
                                                                                            'nombredetype': (int.parse(doc['nombredetype']) + 1).toString(),
                                                                                          }).then((value) {
                                                                                            print("Contenant Added");
                                                                                            Fluttertoast.showToast(msg: "Contenant Added", gravity: ToastGravity.TOP);
                                                                                          }).catchError((error) => print("Failed to add user: $error"));
                                                                                        }
                                                                                      });
                                                                                    });
                                                                                  },
                                                                                  icon: Icon(
                                                                                    FontAwesomeIcons.plus,
                                                                                    size: 15,
                                                                                    color: Color(graphique.color['default_black']),
                                                                                  ))
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                  ]);
                                                            }).toList(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Test After
                                                  // Container(
                                                  //     width: 500,
                                                  //     height: 200,
                                                  //     color: Colors.red,
                                                  //     child: Column(
                                                  //       children: [
                                                  //         Container(
                                                  //           height: 40,
                                                  //           color: Colors.blue,
                                                  //           child: Column(
                                                  //             children: [
                                                  //               SizedBox(
                                                  //                 height: 3,
                                                  //               ),
                                                  //               Row(
                                                  //                 children: [
                                                  //                   SizedBox(
                                                  //                       width: 20),
                                                  //                   Icon(
                                                  //                     FontAwesomeIcons
                                                  //                         .boxOpen,
                                                  //                     size: 15,
                                                  //                   ),
                                                  //                   SizedBox(
                                                  //                     width: 10,
                                                  //                   ),
                                                  //                   Text(
                                                  //                     'Update New Contenant',
                                                  //                     style:
                                                  //                         TextStyle(
                                                  //                       color: Colors
                                                  //                           .black,
                                                  //                       fontSize:
                                                  //                           15,
                                                  //                       fontWeight:
                                                  //                           FontWeight
                                                  //                               .bold,
                                                  //                     ),
                                                  //                   ),
                                                  //                 ],
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 3,
                                                  //               ),
                                                  //               const Divider(
                                                  //                 thickness: 5,
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //         Container(
                                                  //             width: 500,
                                                  //             child: Form(
                                                  //                 child: Row(
                                                  //               children: [
                                                  //                 SizedBox(
                                                  //                     width: 10),
                                                  //                 // Container(
                                                  //                 //   width: 120,
                                                  //                 //   color:
                                                  //                 //       Colors.red,
                                                  //                 //   child: StreamBuilder<
                                                  //                 //           QuerySnapshot>(
                                                  //                 //       stream: FirebaseFirestore
                                                  //                 //           .instance
                                                  //                 //           .collection(
                                                  //                 //               "TypeContenant")
                                                  //                 //           .snapshots(),
                                                  //                 //       builder: (BuildContext
                                                  //                 //               context,
                                                  //                 //           AsyncSnapshot<QuerySnapshot>
                                                  //                 //               snapshot) {
                                                  //                 //         if (snapshot
                                                  //                 //             .hasError) {
                                                  //                 //           return Text(
                                                  //                 //               'Something went wrong');
                                                  //                 //         }

                                                  //                 //         if (snapshot
                                                  //                 //                 .connectionState ==
                                                  //                 //             ConnectionState
                                                  //                 //                 .waiting) {
                                                  //                 //           return CircularProgressIndicator();
                                                  //                 //         }
                                                  //                 //         return DropdownButton(
                                                  //                 //           onChanged:
                                                  //                 //               (String?
                                                  //                 //                   changedValue) {
                                                  //                 //             setState(
                                                  //                 //                 () {
                                                  //                 //               choiceType =
                                                  //                 //                   changedValue!;
                                                  //                 //             });
                                                  //                 //           },
                                                  //                 //           value:
                                                  //                 //               choiceType,
                                                  //                 //           items: snapshot
                                                  //                 //               .data!
                                                  //                 //               .docs
                                                  //                 //               .map((DocumentSnapshot
                                                  //                 //                   document) {
                                                  //                 //             Map<String, dynamic>
                                                  //                 //                 typecontenant =
                                                  //                 //                 document.data()! as Map<String, dynamic>;

                                                  //                 //             return DropdownMenuItem<
                                                  //                 //                 String>(
                                                  //                 //               value:
                                                  //                 //                   typecontenant['nomTypeContenant'],
                                                  //                 //               child:
                                                  //                 //                   Text(typecontenant['nomTypeContenant']),
                                                  //                 //             );
                                                  //                 //           }).toList(),
                                                  //                 //         );
                                                  //                 //       }),
                                                  //                 // ),
                                                  //                 Container(
                                                  //                   width: 100,
                                                  //                   color:
                                                  //                       Colors.red,
                                                  //                   child:
                                                  //                       TextFormField(
                                                  //                     controller:
                                                  //                         _typeContenantController,
                                                  //                     decoration:
                                                  //                         InputDecoration(
                                                  //                       labelText:
                                                  //                           'Type',
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 SizedBox(
                                                  //                     width: 20),
                                                  //                 Container(
                                                  //                   width: 100,
                                                  //                   color:
                                                  //                       Colors.red,
                                                  //                   child:
                                                  //                       TextFormField(
                                                  //                     controller:
                                                  //                         _quality,
                                                  //                     decoration:
                                                  //                         InputDecoration(
                                                  //                       labelText:
                                                  //                           'Nombre',
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 SizedBox(
                                                  //                     width: 20),
                                                  //                 Container(
                                                  //                   width: 100,
                                                  //                   color:
                                                  //                       Colors.red,
                                                  //                   child:
                                                  //                       IconButton(
                                                  //                     onPressed:
                                                  //                         () async {
                                                  //                       QuerySnapshot query = await FirebaseFirestore
                                                  //                           .instance
                                                  //                           .collection(
                                                  //                               'TypeContenant')
                                                  //                           .where(
                                                  //                               'nomTypeContenant',
                                                  //                               isEqualTo:
                                                  //                                   _typeContenantController.text.toLowerCase())
                                                  //                           .get();
                                                  //                       if (
                                                  //                           //(choiceType ==
                                                  //                           //     'None'
                                                  //                           _typeContenantController.text.isEmpty ||
                                                  //                               _typeContenantController.text ==
                                                  //                                   '') {
                                                  //                         Fluttertoast.showToast(
                                                  //                             msg:
                                                  //                                 'Please Input a type',
                                                  //                             gravity:
                                                  //                                 ToastGravity.TOP);
                                                  //                       } else if (query
                                                  //                           .docs
                                                  //                           .isEmpty) {
                                                  //                         Fluttertoast.showToast(
                                                  //                             msg:
                                                  //                                 'Please Write an available type',
                                                  //                             gravity:
                                                  //                                 ToastGravity.TOP);
                                                  //                       } else if (_quality
                                                  //                               .text
                                                  //                               .isEmpty ||
                                                  //                           !isNumericUsing_tryParse(_quality
                                                  //                               .text) ||
                                                  //                           _quality.text ==
                                                  //                               '0') {
                                                  //                         Fluttertoast.showToast(
                                                  //                             msg:
                                                  //                                 'Please Input a real number',
                                                  //                             gravity:
                                                  //                                 ToastGravity.TOP);
                                                  //                       } else {
                                                  //                         await _contenantadresse
                                                  //                             .where(
                                                  //                                 'idAdresse',
                                                  //                                 isEqualTo: adresse[
                                                  //                                     'idAdresse'])
                                                  //                             .limit(
                                                  //                                 1)
                                                  //                             .get()
                                                  //                             .then((QuerySnapshot
                                                  //                                 querySnapshot) {
                                                  //                           querySnapshot
                                                  //                               .docs
                                                  //                               .forEach((doc) {
                                                  //                             int check_type_exist =
                                                  //                                 0;
                                                  //                             int save_position =
                                                  //                                 0;
                                                  //                             for (int i = 1;
                                                  //                                 i <= int.parse(doc['nombredetype']);
                                                  //                                 i++) {
                                                  //                               if (_typeContenantController.text.toLowerCase() ==
                                                  //                                   doc['${i.toString()}'].substring(0, doc['$i'].indexOf('/'))) {
                                                  //                                 print('${doc['${i.toString()}'].substring(0, doc['$i'].indexOf('/'))}');
                                                  //                                 check_type_exist = 1;
                                                  //                                 save_position = i;
                                                  //                               }
                                                  //                             }
                                                  //                             if (check_type_exist ==
                                                  //                                 1) {
                                                  //                               _contenantadresse.doc(doc.id).update({
                                                  //                                 '${save_position.toString()}': _typeContenantController.text.toLowerCase() + '/' + _quality.text,
                                                  //                               }).then(
                                                  //                                   (value) {
                                                  //                                 print("Contenant Updated");
                                                  //                                 _quality.text = '0';
                                                  //                                 _typeContenantController.text = '';
                                                  //                                 Fluttertoast.showToast(msg: "Contenant Updated", gravity: ToastGravity.TOP);
                                                  //                               }).catchError((error) =>
                                                  //                                   print("Failed to add user: $error"));
                                                  //                             } else {
                                                  //                               _contenantadresse.doc(doc.id).update({
                                                  //                                 '${int.parse(doc['nombredetype']) + 1}': _typeContenantController.text.toLowerCase() + '/' + _quality.text,
                                                  //                                 'nombredetype': (int.parse(doc['nombredetype']) + 1).toString(),
                                                  //                               }).then(
                                                  //                                   (value) {
                                                  //                                 print("Contenant Added");
                                                  //                                 _quality.text = '0';
                                                  //                                 _typeContenantController.text = '';
                                                  //                                 Fluttertoast.showToast(msg: "Contenant Added", gravity: ToastGravity.TOP);
                                                  //                               }).catchError((error) =>
                                                  //                                   print("Failed to add user: $error"));
                                                  //                             }
                                                  //                           });
                                                  //                         });
                                                  //                       }
                                                  //                     },
                                                  //                     icon:
                                                  //                         const Icon(
                                                  //                       FontAwesomeIcons
                                                  //                           .plus,
                                                  //                       size: 15,
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //               ],
                                                  //             )))
                                                  //       ],
                                                  //     )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ])));
  }

  //for Adresse
  CollectionReference _contenantadresse =
      FirebaseFirestore.instance.collection("ContenantAdresse");
  showCreateAdressesDialog() {
    _nomPartenaireAdresseController.text = widget.partenaire['nomPartenaire'];
    _latitudeAdresseController.text = '';
    _longitudeAdresseController.text = '';
    _etageAdresseController.text = '0';
    _noteAdresseController.text = '';
    TabController adressesTabController;
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      color: Colors.blue,
                      child: Text(
                        'New Adresses',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )),
                  Divider(
                    thickness: 5,
                  ),
                  Container(
                    height: 350,
                    color: Colors.green,
                    child: Form(
                        key: _createAdressesKeyForm,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _nomPartenaireAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom Adresse:',
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
                                  controller: _ligne1AdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse 1*:',
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
                                  controller: _ligne2AdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse 2:',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _codepostalAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Code Postal*:',
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
                                  controller: _villeAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Ville*:',
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
                                  controller: _paysAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Pays*:',
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
                                  controller: _latitudeAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Latitude:',
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
                                  controller: _longitudeAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Longitude:',
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
                                  controller: _etageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Étage*:',
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
                                    'Ascenseur: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _ascenseurAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _ascenseurAdresse = 'true';
                                        // id = 1;
                                        // print('$_ascenseurAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _ascenseurAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _ascenseurAdresse = 'false';
                                        // id = 2;
                                        // print('$_ascenseurAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 400,
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _noteAdresseController,
                                      maxLines: 4,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Note"),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Passages: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _passagesAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _passagesAdresse = 'true';
                                        // id = 1;
                                        print('$_passagesAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _passagesAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _passagesAdresse = 'false';
                                        // id = 2;
                                        print('$_passagesAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
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
                                    'Facturation: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _facturationAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _facturationAdresse = 'true';
                                        // id = 1;
                                        // print('$_facturationAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _facturationAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _facturationAdresse = 'false';
                                        // id = 2;
                                        // print('$_facturationAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _tarifpassageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Prix du passage',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
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
                                  controller: _tempspassageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Temps sur place',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
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
                                  controller: _surfacepassageAdresseController,
                                  decoration: InputDecoration(
                                    labelText: 'Surface plancher',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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
                                _nomPartenaireAdresseController.text = '';
                                _ligne1AdresseController.text = '';
                                _ligne2AdresseController.text = '';
                                _codepostalAdresseController.text = '';
                                _villeAdresseController.text = '';
                                _paysAdresseController.text = '';
                                _latitudeAdresseController.text = '';
                                _longitudeAdresseController.text = '';
                                _etageAdresseController.text = '0';
                                _ascenseurAdresse = 'true';
                                _noteAdresseController.text = '';
                                _passagesAdresse = 'true';
                                _facturationAdresse = 'true';
                                _tarifpassageAdresseController.text = '';
                                _tempspassageAdresseController.text = '';
                                _surfacepassageAdresseController.text = '';

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
                                if (_createAdressesKeyForm.currentState!
                                    .validate()) {
                                  await _partenaire
                                      .where('idPartenaire',
                                          isEqualTo:
                                              widget.partenaire['idPartenaire'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _partenaire.doc(doc.id).update({
                                        'nombredeAdresses': (int.parse(
                                                    widget.partenaire[
                                                        'nombredeAdresses']) +
                                                1)
                                            .toString(),
                                      });
                                    });
                                  });
                                  String newidAdresse = _adresse.doc().id;
                                  await _contenantadresse
                                      .doc(newidAdresse)
                                      .set({
                                    'idAdresse': newidAdresse,
                                    'nombredetype': '0'
                                  });
                                  await _frequence
                                      .doc(_frequence.doc().id)
                                      .set({
                                    'frequence': 1,
                                    'jourFrequence': 'Lundi',
                                    'siretPartenaire': '',
                                    'idContactFrequence': 'null',
                                    'idVehiculeFrequence': 'null',
                                    'idAdresseFrequence': newidAdresse,
                                    'nomAdresseFrequence':
                                        _nomPartenaireAdresseController.text,
                                    'idPartenaireFrequence':
                                        widget.partenaire['idPartenaire'],
                                    'dureeFrequence': '0',
                                    'startFrequence': '00:00',
                                    'endFrequence': '00:00',
                                    'tarifFrequence': '0',
                                    'dateMinimaleFrequence': '19/10/2021',
                                    'dateMaximaleFrequence': '19/10/2021',
                                    'idFrequence': 'null'
                                  });
                                  await _adresse.doc(newidAdresse).set({
                                    'nomPartenaireAdresse':
                                        _nomPartenaireAdresseController.text,
                                    'ligne1Adresse':
                                        _ligne1AdresseController.text,
                                    'ligne2Adresse':
                                        _ligne2AdresseController.text,
                                    'codepostalAdresse':
                                        _codepostalAdresseController.text,
                                    'villeAdresse':
                                        _villeAdresseController.text,
                                    'paysAdresse': _paysAdresseController.text,
                                    'latitudeAdresse':
                                        _latitudeAdresseController.text,
                                    'longitudeAdresse':
                                        _longitudeAdresseController.text,
                                    'idPosition': 'null',
                                    'etageAdresse':
                                        _etageAdresseController.text,
                                    'ascenseurAdresse': _ascenseurAdresse,
                                    'noteAdresse': _noteAdresseController.text,
                                    'passagesAdresse': _passagesAdresse,
                                    'facturationAdresse': _facturationAdresse,
                                    'tarifpassageAdresse':
                                        _tarifpassageAdresseController.text,
                                    'tempspassageAdresse':
                                        _tempspassageAdresseController.text,
                                    'surfacepassageAdresse':
                                        _surfacepassageAdresseController.text,
                                    'idPartenaireAdresse':
                                        widget.partenaire['idPartenaire'],
                                    'nombredeContact': '0',
                                    'idAdresse': newidAdresse,
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
                                        print("Adresse Added");
                                        Fluttertoast.showToast(
                                            msg: "Adresse Added",
                                            gravity: ToastGravity.TOP);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewPartenairePage(
                                                    partenaire: next_partenaire,
                                                  )),
                                        ).then((value) => setState(() {}));
                                      });
                                    });
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
                ]),
          ));
        });
  }

  showModifyAdressDialog(
      {required BuildContext context, required Map dataAdresse}) {
    _nomPartenaireAdresseModifyController.text =
        dataAdresse['nomPartenaireAdresse'];
    _ligne1AdresseModifyController.text = dataAdresse['ligne1Adresse'];
    _ligne2AdresseModifyController.text = dataAdresse['ligne2Adresse'];
    _codepostalAdresseModifyController.text = dataAdresse['codepostalAdresse'];
    _villeAdresseModifyController.text = dataAdresse['villeAdresse'];
    _paysAdresseModifyController.text = dataAdresse['paysAdresse'];
    _latitudeAdresseModifyController.text = dataAdresse['latitudeAdresse'];
    _longitudeAdresseModifyController.text = dataAdresse['longitudeAdresse'];
    _etageAdresseModifyController.text = dataAdresse['etageAdresse'];
    String _ascenseurModifyAdresse = dataAdresse['ascenseurAdresse'];
    _noteAdresseModifyController.text = dataAdresse['noteAdresse'];
    String _passagesModifyAdresse = dataAdresse['passagesAdresse'];
    String _facturationModifyAdresse = dataAdresse['facturationAdresse'];
    _tarifpassageAdresseModifyController.text =
        dataAdresse['tarifpassageAdresse'];
    _tempspassageAdresseModifyController.text =
        dataAdresse['tempspassageAdresse'];
    _surfacepassageAdresseModifyController.text =
        dataAdresse['surfacepassageAdresse'];
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
                        onPressed: null,
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          showAddFrequenceAdresse(
                              context: context, dataAdresse: dataAdresse);
                        },
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
                          showModifyContactAdresse(
                              context: context, dataAdresse: dataAdresse);
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
                    child: Form(
                        key: _modifyAdressesKeyForm,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller:
                                      _nomPartenaireAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom Adresse:',
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
                                  controller: _ligne1AdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse 1*:',
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
                                  controller: _ligne2AdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse 2:',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller:
                                      _codepostalAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Code Postal*:',
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
                                  controller: _villeAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Ville*:',
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
                                  controller: _paysAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Pays*:',
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
                                  controller: _latitudeAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Latitude:',
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
                                  controller: _longitudeAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Longitude:',
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
                                  controller: _etageAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Étage*:',
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
                                    'Ascenseur: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _ascenseurModifyAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _ascenseurModifyAdresse = 'true';
                                        // id = 1;
                                        // print('$_ascenseurModifyAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _ascenseurModifyAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _ascenseurModifyAdresse = 'false';
                                        // id = 2;
                                        // print('$_ascenseurModifyAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 400,
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _noteAdresseModifyController,
                                      maxLines: 4,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Note"),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Passages: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _passagesModifyAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _passagesModifyAdresse = 'true';
                                        // id = 1;
                                        print('true $_passagesModifyAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _passagesModifyAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _passagesModifyAdresse = 'false';
                                        // id = 2;
                                        print('false $_passagesModifyAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
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
                                    'Facturation: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  //bug with Radio
                                  Radio(
                                    value: 1,
                                    groupValue: _facturationModifyAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _facturationModifyAdresse = 'true';
                                        // id = 1;
                                        // print('$_facturationAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Oui',
                                    style: new TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _facturationModifyAdresse,
                                    onChanged: (val) {
                                      setState(() {
                                        _facturationModifyAdresse = 'false';
                                        // id = 2;
                                        // print('$_facturationAdresse');
                                      });
                                    },
                                  ),
                                  Text(
                                    'Non',
                                    style: new TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller:
                                      _tarifpassageAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Prix du passage',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
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
                                  controller:
                                      _tempspassageAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Temps sur place',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
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
                                  controller:
                                      _surfacepassageAdresseModifyController,
                                  decoration: InputDecoration(
                                    labelText: 'Surface plancher',
                                  ),
                                  validator: (value) {
                                    if (!value!.isEmpty &&
                                        double.tryParse(value) == null) {
                                      return 'Please input a true number';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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
                                if (_modifyAdressesKeyForm.currentState!
                                    .validate()) {
                                  await _frequence
                                      .where('idAdresseFrequence',
                                          isEqualTo: dataAdresse['idAdresse'])
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc_frequence) {
                                      _frequence.doc(doc_frequence.id).update({
                                        'nomAdresseFrequence':
                                            _nomPartenaireAdresseModifyController
                                                .text,
                                      });
                                    });
                                  });
                                  await _etape
                                      .where('idAdresseEtape',
                                          isEqualTo: dataAdresse['idAdresse'])
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc_etape) {
                                      _etape.doc(doc_etape.id).update({
                                        'nomAdresseEtape':
                                            _nomPartenaireAdresseModifyController
                                                .text,
                                      });
                                    });
                                  });
                                  await _adresse
                                      .where('idAdresse',
                                          isEqualTo: dataAdresse['idAdresse'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _adresse.doc(doc.id).update({
                                        'nomPartenaireAdresse':
                                            _nomPartenaireAdresseModifyController
                                                .text,
                                        'ligne1Adresse':
                                            _ligne1AdresseModifyController.text,
                                        'ligne2Adresse':
                                            _ligne2AdresseModifyController.text,
                                        'codepostalAdresse':
                                            _codepostalAdresseModifyController
                                                .text,
                                        'villeAdresse':
                                            _villeAdresseModifyController.text,
                                        'paysAdresse':
                                            _paysAdresseModifyController.text,
                                        'latitudeAdresse':
                                            _latitudeAdresseModifyController
                                                .text,
                                        'longitudeAdresse':
                                            _longitudeAdresseModifyController
                                                .text,
                                        'etageAdresse':
                                            _etageAdresseModifyController.text,
                                        'ascenseurAdresse':
                                            _ascenseurModifyAdresse,
                                        'noteAdresse':
                                            _noteAdresseModifyController.text,
                                        'passagesAdresse':
                                            _passagesModifyAdresse,
                                        'facturationAdresse':
                                            _facturationModifyAdresse,
                                        'tarifpassageAdresse':
                                            _tarifpassageAdresseModifyController
                                                .text,
                                        'tempspassageAdresse':
                                            _tempspassageAdresseModifyController
                                                .text,
                                        'surfacepassageAdresse':
                                            _surfacepassageAdresseModifyController
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
                                                            next_partenaire,
                                                      )),
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

  showAddFrequenceAdresse(
      {required BuildContext context, required Map dataAdresse}) async {
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
                          showModifyAdressDialog(
                              context: context, dataAdresse: dataAdresse);
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
                          showModifyContactAdresse(
                              context: context, dataAdresse: dataAdresse);
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
                                                  ViewPartenairePage(
                                                    partenaire: next_partenaire,
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

  modifyFrequence({required Map dataFrequence}) {
    String choiceVehicule = 'None';
    String idVehiculeFrequence = '';
    String _jour = dataFrequence['jourFrequence'];
    TimeOfDay timeStart = TimeOfDay(
        hour: int.parse(dataFrequence['startFrequence'].substring(0, 2)),
        minute: int.parse(dataFrequence['startFrequence'].substring(3)));
    TimeOfDay timeEnd = TimeOfDay(
        hour: int.parse(dataFrequence['endFrequence'].substring(0, 2)),
        minute: int.parse(dataFrequence['endFrequence'].substring(3)));
    TextEditingController _frequenceTextController =
        TextEditingController(text: dataFrequence['frequence']);
    TextEditingController _frequenceTarifController =
        TextEditingController(text: dataFrequence['tarifFrequence']);

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

    // DateTime dateMinimale = DateTime(
    //     int.parse(dataFrequence['dateMinimaleFrequence'].substring(6)),
    //     int.parse(dataFrequence['dateMinimaleFrequence'].substring(3, 5)),
    //     int.parse(dataFrequence['dateMinimaleFrequence'].substring(0, 2)));
    // DateTime dateMaximale = DateTime(
    //     int.parse(dataFrequence['dateMaximaleFrequence'].substring(6)),
    //     int.parse(dataFrequence['dateMaximaleFrequence'].substring(3, 5)),
    //     int.parse(dataFrequence['dateMaximaleFrequence'].substring(0, 2)));
    DateTime dateMinimale = DateTime.now();
    DateTime dateMaximale = DateTime.now();

    Future pickDateMinimale(BuildContext context) async {
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
                        'Modify Frequence ' +
                            dataFrequence['nomAdresseFrequence'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )),
                  Divider(
                    thickness: 5,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 350,
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
                                print(
                                    '${DateFormat('yMd').format(dateMaximale).toString()}');
                                print(
                                    '${DateFormat('yMd').format(dateMinimale).toString()}');
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
                                  await _frequence
                                      .where('idFrequence',
                                          isEqualTo:
                                              dataFrequence['idFrequence'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _frequence.doc(doc.id).update({
                                        'frequence':
                                            _frequenceTextController.text,
                                        'jourFrequence': _jour,
                                        'siretPartenaire':
                                            _siretPartenaireController.text,
                                        'idContactFrequence': 'null',
                                        'idVehiculeFrequence':
                                            idVehiculeFrequence,
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
                                            print("Frequence Modified");
                                            Fluttertoast.showToast(
                                                msg: "Frequence Modified",
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

  // for control table
  CollectionReference _contactadresse =
      FirebaseFirestore.instance.collection("ContactAdresse");
  // Modify Contact of Adresse function
  showModifyContactAdresse(
      {required BuildContext context, required Map dataAdresse}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            height: 600 + 200 * double.parse(dataAdresse['nombredeContact']),
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
                          showModifyAdressDialog(
                              context: context, dataAdresse: dataAdresse);
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          showAddFrequenceAdresse(
                              context: context, dataAdresse: dataAdresse);
                        },
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
                        onPressed: null,
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
                    height: 200,
                    width: 600,
                    color: Colors.green,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _contactadresse
                          .where('idAdresse',
                              isEqualTo: dataAdresse['idAdresse'])
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
                                color: Colors.white,
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
                                        return Column(children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width: 400,
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
                                                                    limit_long:
                                                                        15),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () {
                                                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                            builder: (context) => ViewContactPage(
                                                                                partenaire: widget.partenaire,
                                                                                from: 'viewpartenairepage',
                                                                                dataContact: insidedataContact)));
                                                                      }),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons.phone,
                                                        color: Colors.black,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        insidedataContact[
                                                            'telephone1Contact'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                width: 50,
                                                child: IconButton(
                                                  onPressed: () async {
                                                    await _adresse
                                                        .where('idAdresse',
                                                            isEqualTo:
                                                                dataAdresse[
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
                                                            isEqualTo:
                                                                dataAdresse[
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
                                                          Navigator.of(context)
                                                              .pop();
                                                          showModifyContactAdresse(
                                                              context: context,
                                                              dataAdresse:
                                                                  dataAdresse);
                                                        });
                                                      });
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    FontAwesomeIcons.minus,
                                                    size: 15,
                                                  ),
                                                  tooltip: 'Remove Contact',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ]);
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 600,
                    height: 100,
                    color: Colors.blue,
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
                                color: Colors.green,
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
                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .phone,
                                                            color: Colors.black,
                                                            size: 15,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            insidedataContact[
                                                                'telephone1Contact'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
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
                                                                .where(
                                                                    'idContact',
                                                                    isEqualTo:
                                                                        insidedataContact[
                                                                            'idContact'])
                                                                .where(
                                                                    'idAdresse',
                                                                    isEqualTo:
                                                                        dataAdresse[
                                                                            'idAdresse'])
                                                                .get();
                                                            if (query
                                                                .docs.isEmpty) {
                                                              await _adresse
                                                                  .where(
                                                                      'idAdresse',
                                                                      isEqualTo:
                                                                          dataAdresse[
                                                                              'idAdresse'])
                                                                  .limit(1)
                                                                  .get()
                                                                  .then((QuerySnapshot
                                                                      querySnapshot) {
                                                                querySnapshot
                                                                    .docs
                                                                    .forEach(
                                                                        (doc) {
                                                                  _adresse
                                                                      .doc(doc
                                                                          .id)
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
                                                                'idAdresse':
                                                                    dataAdresse[
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
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showModifyContactAdresse(
                                                                    context:
                                                                        context,
                                                                    dataAdresse:
                                                                        dataAdresse);
                                                              }).catchError(
                                                                      (error) =>
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
                                                            FontAwesomeIcons
                                                                .plus,
                                                            size: 15,
                                                          ),
                                                          tooltip:
                                                              'Add Contact',
                                                        ),
                                                      ]))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ]);
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
                          width: 600,
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
                      ],
                    ),
                  ),
                ]),
          ));
        });
  }
}
