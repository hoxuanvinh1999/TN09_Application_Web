import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/menu2/contact_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_email.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_telephone.dart';
import 'package:tn09_app_web_demo/pages/math_function/generate_password.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_partenaire_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class ViewContactPage extends StatefulWidget {
  Map dataContact;
  Map partenaire;
  String from;
  ViewContactPage(
      {required this.partenaire,
      required this.dataContact,
      required this.from});
  @override
  _ViewContactPageState createState() => _ViewContactPageState();
}

class _ViewContactPageState extends State<ViewContactPage> {
  //For View Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  final _viewContactKeyForm = GlobalKey<FormState>();
  TextEditingController _nomContactController = TextEditingController();
  TextEditingController _prenomContractController = TextEditingController();
  TextEditingController _telephone1ContactController = TextEditingController();
  TextEditingController _telephone2ContactController = TextEditingController();
  TextEditingController _emailContactController = TextEditingController();
  TextEditingController _passwordContactController = TextEditingController();
  TextEditingController _noteContactController = TextEditingController();
  void initState() {
    _contact
        .where('idContact', isEqualTo: widget.dataContact['idContact'])
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> dataContact = doc.data()! as Map<String, dynamic>;
        _nomContactController.text = dataContact['nomContact'];
        _prenomContractController.text = dataContact['prenomContact'];
        _telephone1ContactController.text = dataContact['telephone1Contact'];
        _telephone2ContactController.text = dataContact['telephone2Contact'];
        _emailContactController.text = dataContact['emailContact'];
        _passwordContactController.text = dataContact['passwordContact'];
        _noteContactController.text = dataContact['noteContact'];
      });
    });
    super.initState();
  }

  //For partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  //for controll table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");

  @override
  Widget build(BuildContext context) {
    // For width of table
    double column1_width = MediaQuery.of(context).size.width * 0.5;
    double column2_width = MediaQuery.of(context).size.width * 0.4;
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
                        text: graphique.languagefr['contact_page']['nom_page'],
                        style: TextStyle(
                            color: Color(graphique.color['default_red']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ContactPage()));
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
                      text: graphique.languagefr['view_contact_page']
                              ['nom_page'] +
                          ': ' +
                          widget.dataContact['nomContact'] +
                          ' ' +
                          widget.dataContact['prenomContact'],
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                left: 20,
                top: 20,
                bottom: 20,
              ),
              width: column1_width,
              height: 950,
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
                        graphique.languagefr['view_contact_page']
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
                        FontAwesomeIcons.cog,
                        size: 15,
                        color: Color(graphique.color['main_color_2']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        graphique.languagefr['view_contact_page']
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
                  height: 650,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: column1_width * 2 / 3,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    // border: Border.all(width: 1.0),
                  ),
                  child: Form(
                    key: _viewContactKeyForm,
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
                            controller: _nomContactController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['view_contact_page']
                                      ['contact_form']['field_1_title'],
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
                            controller: _prenomContractController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['view_contact_page']
                                      ['contact_form']['field_2_title'],
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
                            controller: _telephone1ContactController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['view_contact_page']
                                      ['contact_form']['field_3_title'],
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
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2'])),
                            cursorColor: Color(graphique.color['main_color_2']),
                            controller: _telephone2ContactController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['view_contact_page']
                                      ['contact_form']['field_4_title'],
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
                            color:
                                Color(graphique.color['special_bureautique_1']),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2'])),
                            cursorColor: Color(graphique.color['main_color_2']),
                            controller: _emailContactController,
                            decoration: InputDecoration(
                              labelText:
                                  graphique.languagefr['view_contact_page']
                                      ['contact_form']['field_5_title'],
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
                              margin:
                                  EdgeInsets.only(top: 10, right: 10, left: 10),
                              width: 310,
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
                                readOnly: true,
                                controller: _passwordContactController,
                                decoration: InputDecoration(
                                  labelText: 'Password:',
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
                            SizedBox(
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
                                    color:
                                        Color(graphique.color['main_color_2'])),
                                cursorColor:
                                    Color(graphique.color['main_color_2']),
                                controller: _noteContactController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText:
                                      graphique.languagefr['view_contact_page']
                                          ['contact_form']['field_10_title'],
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
                              ),
                            )),
                      ],
                    ),
                  ),
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
                            onTap: () {
                              if (widget.from == 'contactpage') {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ContactPage()));
                              } else {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewPartenairePage(
                                                partenaire:
                                                    widget.partenaire)));
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
                                  graphique.languagefr['view_contact_page']
                                      ['contact_form']['button_2'],
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
                              if (_viewContactKeyForm.currentState!
                                  .validate()) {
                                await _contact
                                    .where('idContact',
                                        isEqualTo:
                                            widget.dataContact['idContact'])
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
                                      'noteContact':
                                          _noteContactController.text,
                                      'emailContact':
                                          _emailContactController.text,
                                      'passwordContact':
                                          _passwordContactController.text,
                                    }).then((value) {
                                      print("Contact Modified");
                                      Fluttertoast.showToast(
                                          msg: "Contact Modified",
                                          gravity: ToastGravity.TOP);
                                      if (widget.from == 'contactpage') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ContactPage()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPartenairePage(
                                                        partenaire: widget
                                                            .partenaire)));
                                      }
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
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  graphique.languagefr['view_contact_page']
                                      ['contact_form']['button_1'],
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
              ])),
          SizedBox(
            width: 30,
          ),
          Container(
              margin: const EdgeInsets.only(
                left: 20,
                top: 20,
                bottom: 20,
              ),
              width: column2_width,
              height: 100 +
                  double.parse(widget.dataContact['nombredePartenaire']) * 150,
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
                          FontAwesomeIcons.flag,
                          size: 17,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          graphique.languagefr['view_contact_page']
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
                    margin: EdgeInsets.only(top: 20),
                    width: column2_width * 5 / 6,
                    height:
                        double.parse(widget.dataContact['nombredePartenaire']) *
                            150,
                    color: Color(graphique.color['special_bureautique_2']),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _contactpartenaire
                          .where('idContact',
                              isEqualTo: widget.dataContact['idContact'])
                          .snapshots(),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: snapshot.data!.docs.map(
                                (DocumentSnapshot document_contactpartenaire) {
                              Map<String, dynamic> contactpartenaire =
                                  document_contactpartenaire.data()!
                                      as Map<String, dynamic>;
                              // print('$collecteur');

                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        Color(graphique.color['main_color_1']),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Color(
                                            graphique.color['default_black']))),
                                height: 50,
                                width: column2_width * 5 / 6,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _partenaire
                                      .where('idPartenaire',
                                          isEqualTo:
                                              contactpartenaire['idPartenaire'])
                                      .limit(1)
                                      .snapshots(),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: snapshot.data!.docs.map(
                                            (DocumentSnapshot
                                                document_partenaire) {
                                          Map<String, dynamic> partenaire =
                                              document_partenaire.data()!
                                                  as Map<String, dynamic>;
                                          // print('$collecteur');
                                          return Container(
                                              color: Color(graphique
                                                  .color['main_color_1']),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: partenaire[
                                                                'nomPartenaire'],
                                                            style: TextStyle(
                                                                color: Color(graphique
                                                                        .color[
                                                                    'main_color_2']),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushReplacement(MaterialPageRoute(
                                                                            builder: (context) => ViewPartenairePage(
                                                                                  partenaire: partenaire,
                                                                                )));
                                                                  }),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ))
        ],
      )
    ])));
  }
}
