// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_email.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_telephone.dart';
import 'package:tn09_app_web_demo/pages/math_function/conver_string_bool.dart';
import 'package:tn09_app_web_demo/pages/math_function/generate_password.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/menu2/partenaire_page.dart';

class ViewContactPartenairePage extends StatefulWidget {
  Map dataPartenaire;
  ViewContactPartenairePage({
    Key? key,
    required this.dataPartenaire,
  }) : super(key: key);
  @override
  _ViewContactPartenairePageState createState() =>
      _ViewContactPartenairePageState();
}

class _ViewContactPartenairePageState extends State<ViewContactPartenairePage> {
  final auth = FirebaseAuth.instance;
  //For Send mail
  CollectionReference _mail = FirebaseFirestore.instance.collection("mail");
  //for controll table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");
  //For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");

  //For Create Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  final _modifyContactKeyForm = GlobalKey<FormState>();
  TextEditingController _nomContactController = TextEditingController();
  TextEditingController _prenomContractController = TextEditingController();
  TextEditingController _telephone1ContactController = TextEditingController();
  TextEditingController _telephone2ContactController = TextEditingController();
  TextEditingController _emailContactController = TextEditingController();
  TextEditingController _passwordContactController = TextEditingController();
  TextEditingController _noteContactController = TextEditingController();
  bool isPrincipal = true;
  bool recoitRapport = false;
  bool recoitFacture = false;
  bool accessExtranet = false;
  String idNewContact = '';
  String oldemail = '';
  String oldPassword = '';
  void initState() {
    _contact
        .where('idContact',
            isEqualTo: widget.dataPartenaire['idContactPartenaire'])
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> dataContact = doc.data()! as Map<String, dynamic>;
        setState(() {
          _nomContactController.text = dataContact['nomContact'];
          _prenomContractController.text = dataContact['prenomContact'];
          _telephone1ContactController.text = dataContact['telephone1Contact'];
          _telephone2ContactController.text = dataContact['telephone2Contact'];
          _emailContactController.text = dataContact['emailContact'];
          _passwordContactController.text = dataContact['passwordContact'];
          _noteContactController.text = dataContact['noteContact'];
          recoitRapport = convertBool(check: dataContact['recoitRapport']);
          recoitFacture = convertBool(check: dataContact['recoitFacture']);
          accessExtranet = convertBool(check: dataContact['accessExtranet']);
          isPrincipal = convertBool(check: dataContact['isPrincipal']);
          oldemail = dataContact['emailContact'];
          oldPassword = dataContact['passwordContact'];
        });
      });
    });
    super.initState();
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
                      text: graphique.languagefr['view_contact_partenaire_page']
                              ['nom_page'] +
                          ': ' +
                          widget.dataPartenaire['nomPartenaire'],
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
          height: 1100,
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
                      FontAwesomeIcons.user,
                      size: 17,
                      color: Color(graphique.color['main_color_2']),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      graphique.languagefr['view_contact_partenaire_page']
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
                      graphique.languagefr['view_contact_partenaire_page']
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
                height: 800,
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: page_width * 2 / 3,
                decoration: BoxDecoration(
                  color: Color(graphique.color['special_bureautique_2']),
                  // border: Border.all(width: 1.0),
                ),
                child: Form(
                    key: _modifyContactKeyForm,
                    child: SingleChildScrollView(
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
                              controller: _nomContactController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'view_contact_partenaire_page']
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
                              controller: _prenomContractController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'view_contact_partenaire_page']
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
                              controller: _telephone1ContactController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'view_contact_partenaire_page']
                                    ['field_3_title'],
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
                                if (!checkTelephone(
                                        _telephone1ContactController.text) &&
                                    _telephone1ContactController
                                        .text.isNotEmpty) {
                                  return 'Telephone format is: 0xxxxxxxxx';
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
                              controller: _telephone2ContactController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'view_contact_partenaire_page']
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
                              validator: (value) {
                                if (!checkTelephone(
                                        _telephone2ContactController.text) &&
                                    _telephone2ContactController
                                        .text.isNotEmpty) {
                                  return 'Telephone format is: 0xxxxxxxxx';
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
                              controller: _emailContactController,
                              decoration: InputDecoration(
                                labelText: graphique.languagefr[
                                        'view_contact_partenaire_page']
                                    ['field_5_title'],
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
                                if (!checkEmail(_emailContactController.text) &&
                                    _emailContactController.text.isNotEmpty) {
                                  return 'Please Input a true Email';
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                width: 310,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        Color(graphique.color['main_color_1']),
                                  ),
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  readOnly: true,
                                  controller: _passwordContactController,
                                  decoration: InputDecoration(
                                    labelText: graphique.languagefr[
                                            'view_contact_partenaire_page']
                                        ['field_6_title'],
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
                              ),
                              IconButton(
                                  onPressed: () {
                                    final password = generatePassword();
                                    _passwordContactController.text = password;
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.syncAlt,
                                    size: 17,
                                    color:
                                        Color(graphique.color['default_black']),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    final data = ClipboardData(
                                        text: _passwordContactController.text);
                                    Clipboard.setData(data);

                                    Fluttertoast.showToast(
                                        msg: "Password Copy",
                                        gravity: ToastGravity.TOP);

                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar();
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.copy,
                                    size: 17,
                                    color:
                                        Color(graphique.color['default_black']),
                                  ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
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
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  controller: _noteContactController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: graphique.languagefr[
                                            'view_contact_partenaire_page']
                                        ['field_7_title'],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                graphique.languagefr[
                                        'view_contact_partenaire_page']
                                    ['field_8_title'],
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
                                value: recoitFacture,
                                onChanged: (value) {
                                  setState(() {
                                    recoitFacture = !recoitFacture;
                                    print('recoitFacture $recoitFacture');
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
                                        'view_contact_partenaire_page']
                                    ['field_9_title'],
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
                                value: recoitRapport,
                                onChanged: (value) {
                                  setState(() {
                                    recoitRapport = !recoitRapport;
                                    print('recoitRapport $recoitRapport');
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
                                        'view_contact_partenaire_page']
                                    ['field_10_title'],
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
                                value: accessExtranet,
                                onChanged: (value) {
                                  setState(() {
                                    accessExtranet = !accessExtranet;
                                    print('accessExtranet $accessExtranet');
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
                                color: Color(graphique.color['default_black']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                graphique.languagefr[
                                    'view_contact_partenaire_page']['button_2'],
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
                            if (_modifyContactKeyForm.currentState!
                                .validate()) {
                              String idmail = _mail.doc().id.toString();
                              // ignore: non_constant_identifier_names
                              String email_body =
                                  'Your password is changed, your account new information is: \rEmail: ' +
                                      _emailContactController.text +
                                      '\rPassword: ' +
                                      _passwordContactController.text;
                              if (_emailContactController.text.isNotEmpty &&
                                      _passwordContactController
                                          .text.isNotEmpty &&
                                      oldemail ==
                                          _emailContactController.text &&
                                      oldPassword !=
                                          _passwordContactController.text
                                  // Case we want to change the password
                                  ) {
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                    email: _emailContactController.text,
                                    password: _passwordContactController.text,
                                  );

                                  userCredential.user
                                      ?.updatePassword(
                                          _passwordContactController.text)
                                      .then((_) async {
                                    Fluttertoast.showToast(
                                        msg: 'Successfully changed password',
                                        gravity: ToastGravity.TOP);
                                  }).catchError((error) {
                                    Fluttertoast.showToast(
                                        msg: "Password can't be changed" +
                                            ': ' +
                                            error.toString(),
                                        gravity: ToastGravity.TOP);
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    Fluttertoast.showToast(
                                        msg: 'No user found for that email',
                                        gravity: ToastGravity.TOP);
                                  } else if (e.code == 'wrong-password') {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Wrong password provided for that user',
                                        gravity: ToastGravity.TOP);
                                  }
                                }
                                await _mail.doc(idmail).set({
                                  'to': _emailContactController.text,
                                  'message': {
                                    'subject': "Hello from Les detritivores!",
                                    'text': email_body,
                                  },
                                });
                              } else if (_emailContactController.text.isNotEmpty &&
                                      _passwordContactController
                                          .text.isNotEmpty &&
                                      oldemail != _emailContactController.text
                                  // Case we want to change the email
                                  ) {
                                try {
                                  //Create Get Firebase Auth User
                                  await auth.createUserWithEmailAndPassword(
                                      email: _emailContactController.text,
                                      password:
                                          _passwordContactController.text);

                                  //Success
                                  Fluttertoast.showToast(
                                      msg: 'Account Created',
                                      gravity: ToastGravity.TOP);
                                } on FirebaseAuthException catch (error) {
                                  //String msgerror = 'Error sign up';
                                  Fluttertoast.showToast(
                                    msg: (error.message).toString(),
                                    gravity: ToastGravity.TOP,
                                  );
                                }
                                await _mail.doc(idmail).set({
                                  'to': _emailContactController.text,
                                  'message': {
                                    'subject': "Hello from Les detritivores!",
                                    'text': email_body,
                                  },
                                });
                              }
                              await _contact
                                  .where('idContact',
                                      isEqualTo: widget.dataPartenaire[
                                          'idContactPartenaire'])
                                  .limit(1)
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc) {
                                  _contact.doc(doc.id).update({
                                    'nomContact': _nomContactController.text,
                                    'prenomContact':
                                        _prenomContractController.text,
                                    'telephone1Contact':
                                        _telephone1ContactController.text,
                                    'telephone2Contact':
                                        _telephone2ContactController.text,
                                    'noteContact': _noteContactController.text,
                                    'emailContact':
                                        _emailContactController.text,
                                    'passwordContact':
                                        _passwordContactController.text,
                                    'accessExtranet': accessExtranet.toString(),
                                    'recoitFacture': recoitFacture.toString(),
                                    'recoitRapport': recoitRapport.toString(),
                                  }).then((value) {
                                    print("Contact Modified");
                                    Fluttertoast.showToast(
                                        msg: "Contact Modified",
                                        gravity: ToastGravity.TOP);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PartenairePage()));
                                  }).catchError((error) =>
                                      print("Failed to update user: $error"));
                                });
                              });
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
                                graphique.languagefr[
                                    'view_contact_partenaire_page']['button_1'],
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
      ),
    ])));
  }
}
