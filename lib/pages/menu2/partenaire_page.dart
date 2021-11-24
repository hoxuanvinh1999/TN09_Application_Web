import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/menu2/add_contact_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/create_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_email.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_telephone.dart';
import 'package:tn09_app_web_demo/pages/math_function/conver_string_bool.dart';
import 'package:tn09_app_web_demo/pages/math_function/generate_password.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_contact_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_partenaire_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class PartenairePage extends StatefulWidget {
  @override
  _PartenairePageState createState() => _PartenairePageState();
}

class _PartenairePageState extends State<PartenairePage> {
  //for controll table
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");
  //For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  Stream<QuerySnapshot> _partenaireStream = FirebaseFirestore.instance
      .collection("Partenaire")
      .orderBy('nomPartenaire')
      .snapshots();
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
                      text: graphique.languagefr['partenaire_page']['nom_page'],
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
              ),
              width: page_width,
              height: 1500,
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Color(graphique.color['main_color_1']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.flag,
                              size: 17,
                              color: Color(graphique.color['main_color_2']),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              graphique.languagefr['partenaire_page']
                                  ['table_title'],
                              style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 180,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              //showCreateContenant();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreatePartenairePage()));
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
                                  graphique.languagefr['partenaire_page']
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
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: page_width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['main_color_1']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.building,
                          size: 17,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          graphique.languagefr['partenaire_page']
                              ['column_2_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          graphique.languagefr['partenaire_page']
                              ['column_3_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                        ),
                        Text(
                          graphique.languagefr['partenaire_page']
                              ['column_4_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _partenaireStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    // print('$snapshot');
                    return Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> partenaire =
                            document.data()! as Map<String, dynamic>;
                        // print('$vehicule');
                        if (partenaire['idPartenaire'] == 'null') {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          width: page_width,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color:
                                Color(graphique.color['special_bureautique_2']),
                            border: Border(
                                top: BorderSide(
                                    width: 1.0,
                                    color: Color(
                                        graphique.color['default_black'])),
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color(
                                        graphique.color['default_black']))),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                buildTypePartenaireIcon(
                                    typePartenaire:
                                        partenaire['typePartenaire']),
                                SizedBox(
                                  width: 30,
                                ),
                                buildStatusPartenaireIcon(
                                    actifPartenaire:
                                        partenaire['actifPartenaire']),
                                Container(
                                    margin: const EdgeInsets.only(left: 120),
                                    alignment: Alignment.centerLeft,
                                    width: 300,
                                    height: 50,
                                    color: Color(graphique
                                        .color['special_bureautique_2']),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: partenaire['nomPartenaire'],
                                              style: TextStyle(
                                                  color: Color(graphique
                                                      .color['default_black']),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewPartenairePage(
                                                                    partenaire:
                                                                        partenaire,
                                                                  )));
                                                }),
                                        ],
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 100),
                                    alignment: Alignment.centerLeft,
                                    width: 50,
                                    height: 50,
                                    color: Color(graphique
                                        .color['special_bureautique_2']),
                                    child: contactPartenaire(
                                        dataPartenaire: partenaire))
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ]))),
    ])));
  }

  Widget buildTypePartenaireIcon({required String typePartenaire}) {
    // print('$typePartenaire');
    switch (typePartenaire) {
      case 'prive':
        {
          return Tooltip(
            message: typePartenaire,
            child: Icon(
              FontAwesomeIcons.building,
              size: 17,
            ),
          );
        }

      case 'Public':
        {
          return Tooltip(
            message: typePartenaire,
            child: Icon(
              FontAwesomeIcons.city,
              size: 17,
            ),
          );
        }
      case 'Experimentation':
        {
          return Tooltip(
            message: typePartenaire,
            child: Icon(
              FontAwesomeIcons.flask,
              size: 17,
            ),
          );
        }
      default:
        {
          return Tooltip(
            message: typePartenaire,
            child: Icon(
              FontAwesomeIcons.flag,
              size: 17,
            ),
          );
        }
    }
  }

  Widget buildStatusPartenaireIcon({required String actifPartenaire}) {
    // print('$typePartenaire');
    switch (actifPartenaire) {
      case 'true':
        {
          return Tooltip(
            message: 'Actif',
            child: Icon(
              FontAwesomeIcons.check,
              size: 17,
            ),
          );
        }

      case 'false':
        {
          return Tooltip(
            message: 'PasActif',
            child: Icon(
              FontAwesomeIcons.times,
              size: 17,
            ),
          );
        }
      default:
        {
          return Tooltip(
            message: 'PasActif',
            child: Icon(
              FontAwesomeIcons.times,
              size: 17,
            ),
          );
        }
    }
  }

  Widget contactPartenaire({required dataPartenaire}) {
    switch (dataPartenaire['idContactPartenaire']) {
      case 'null':
        {
          return IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              size: 17,
            ),
            tooltip: graphique.languagefr['partenaire_page']
                ['icon_button_1_title_1'],
            onPressed: () {
              //addContactPartenaire(dataPartenaire: dataPartenaire);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AddContactPartenairePage(
                        dataPartenaire: dataPartenaire,
                      )));
            },
          );
        }
      default:
        {
          return IconButton(
            icon: const Icon(
              FontAwesomeIcons.user,
              size: 17,
            ),
            tooltip: graphique.languagefr['partenaire_page']
                ['icon_button_1_title_2'],
            onPressed: () {
              // viewContactPartenaire(dataPartenaire: dataPartenaire);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ViewContactPartenairePage(
                        dataPartenaire: dataPartenaire,
                      )));
            },
          );
        }
    }
  }

  Widget buildStatusIcon({required String iconstatus}) {
    switch (iconstatus) {
      case 'Disponible':
        {
          return Icon(
            FontAwesomeIcons.check,
            size: 17,
            color: Colors.black,
          );
        }
      case 'PasDisponible':
        {
          return Icon(
            FontAwesomeIcons.times,
            size: 17,
            color: Colors.black,
          );
        }
      default:
        {
          return Icon(
            FontAwesomeIcons.question,
            size: 17,
            color: Colors.black,
          );
          ;
        }
    }
  }

  //For Create Contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  final _createContactKeyForm = GlobalKey<FormState>();
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

  addContactPartenaire({required Map dataPartenaire}) {
    _nomContactController.text = '';
    _prenomContractController.text = '';
    _telephone1ContactController.text = '';
    _telephone2ContactController.text = '';
    _emailContactController.text = '';
    _passwordContactController.text = '';
    _noteContactController.text = '';
    isPrincipal = false;
    recoitRapport = false;
    recoitFacture = false;
    accessExtranet = false;
    idNewContact = '';
    if (dataPartenaire['idContactPartenaire'] == 'null') {
      isPrincipal = true;
    }
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
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      color: Colors.blue,
                      child: Text(
                        'New Contact',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )),
                  Divider(
                    thickness: 5,
                  ),
                  Container(
                    height: 400,
                    width: 500,
                    color: Colors.green,
                    child: Form(
                        key: _createContactKeyForm,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _nomContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom*:',
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
                                  controller: _prenomContractController,
                                  decoration: InputDecoration(
                                    labelText: 'Prenom*:',
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
                                  controller: _telephone1ContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Telephone 1:',
                                  ),
                                  validator: (value) {
                                    if (!checkTelephone(
                                            _telephone1ContactController
                                                .text) &&
                                        _telephone1ContactController
                                            .text.isNotEmpty) {
                                      return 'Telephone format is: 0xxxxxxxxx';
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
                                  controller: _telephone2ContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Telephone2:',
                                  ),
                                  validator: (value) {
                                    if (!checkTelephone(
                                            _telephone2ContactController
                                                .text) &&
                                        _telephone2ContactController
                                            .text.isNotEmpty) {
                                      return 'Telephone format is: 0xxxxxxxxx';
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
                                  controller: _emailContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Email:',
                                  ),
                                  validator: (value) {
                                    if (!checkEmail(
                                            _emailContactController.text) &&
                                        _emailContactController
                                            .text.isNotEmpty) {
                                      return 'Please Input a true Email';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 310,
                                    color: Colors.red,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _passwordContactController,
                                      decoration: InputDecoration(
                                        labelText: 'Password:',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        final password = generatePassword();
                                        _passwordContactController.text =
                                            password;
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.syncAlt,
                                        size: 17,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        final data = ClipboardData(
                                            text: _passwordContactController
                                                .text);
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
                                        color: Colors.black,
                                      ))
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
                                      controller: _noteContactController,
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
                                    'Recoit Facture',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
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
                                    'Recoit Rapport',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
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
                                    'Access Etranet',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
                                  ),
                                ],
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
                                print('recoitFacture $recoitFacture');
                                print('recoitRapport $recoitRapport');
                                print('accessExtranet $accessExtranet');
                                print('isPrincipal $isPrincipal');
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
                                if (_createContactKeyForm.currentState!
                                    .validate()) {
                                  idNewContact = _contact.doc().id;
                                  await _contact.doc(idNewContact).set({
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
                                    'nombredePartenaire': '1',
                                    'idContact': idNewContact
                                  }).then((value) {
                                    print("Contact Added");
                                    Fluttertoast.showToast(
                                        msg: "Contact Added",
                                        gravity: ToastGravity.TOP);
                                  }).catchError((error) =>
                                      print("Failed to add user: $error"));
                                  await _partenaire
                                      .where('idPartenaire',
                                          isEqualTo:
                                              dataPartenaire['idPartenaire'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _partenaire.doc(doc.id).update({
                                        'nombredeContact': (int.parse(
                                                    dataPartenaire[
                                                        'nombredeContact']) +
                                                1)
                                            .toString(),
                                        'idContactPartenaire': idNewContact,
                                      });
                                    });
                                  });
                                  await _contactpartenaire
                                      .doc(_contact.doc().id)
                                      .set({
                                    'idPartenaire':
                                        dataPartenaire['idPartenaire'],
                                    'idContact': idNewContact,
                                    'isPrincipal': 'true'
                                  }).then((value) {
                                    Navigator.push(
                                        context,
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
                ],
              ),
            ),
          );
        });
  }

  //For View(and Modify) Contact
  final _modifyContactKeyForm = GlobalKey<FormState>();
  viewContactPartenaire({required Map dataPartenaire}) async {
    await _contact
        .where('idContact', isEqualTo: dataPartenaire['idContactPartenaire'])
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> dataContact = doc.data()! as Map<String, dynamic>;
        // print('$dataContact');
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
      });
    });

    // print('${_nomContactController.text}');
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
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      color: Colors.blue,
                      child: Text(
                        'View Contact Information',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )),
                  Divider(
                    thickness: 5,
                  ),
                  Container(
                    height: 400,
                    width: 500,
                    color: Colors.green,
                    child: Form(
                        key: _modifyContactKeyForm,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _nomContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom*:',
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
                                  controller: _prenomContractController,
                                  decoration: InputDecoration(
                                    labelText: 'Prenom*:',
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
                                  controller: _telephone1ContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Telephone 1:',
                                  ),
                                  validator: (value) {
                                    if (!checkTelephone(
                                            _telephone1ContactController
                                                .text) &&
                                        _telephone1ContactController
                                            .text.isNotEmpty) {
                                      return 'Telephone format is: 0xxxxxxxxx';
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
                                  controller: _telephone2ContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Telephone2:',
                                  ),
                                  validator: (value) {
                                    if (!checkTelephone(
                                            _telephone2ContactController
                                                .text) &&
                                        _telephone2ContactController
                                            .text.isNotEmpty) {
                                      return 'Telephone format is: 0xxxxxxxxx';
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
                                  controller: _emailContactController,
                                  decoration: InputDecoration(
                                    labelText: 'Email:',
                                  ),
                                  validator: (value) {
                                    if (!checkEmail(
                                            _emailContactController.text) &&
                                        _emailContactController
                                            .text.isNotEmpty) {
                                      return 'Please Input a true Email';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 310,
                                    color: Colors.red,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _passwordContactController,
                                      decoration: InputDecoration(
                                        labelText: 'Password:',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        final password = generatePassword();
                                        _passwordContactController.text =
                                            password;
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.syncAlt,
                                        size: 17,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        final data = ClipboardData(
                                            text: _passwordContactController
                                                .text);
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
                                        color: Colors.black,
                                      ))
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
                                      controller: _noteContactController,
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
                                    'Recoit Facture',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
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
                                    'Recoit Rapport',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
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
                                    'Access Etranet',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
                                  ),
                                ],
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
                                print('recoitFacture $recoitFacture');
                                print('recoitRapport $recoitRapport');
                                print('accessExtranet $accessExtranet');
                                print('isPrincipal $isPrincipal');
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
                                if (_modifyContactKeyForm.currentState!
                                    .validate()) {
                                  await _contact
                                      .where('idContact',
                                          isEqualTo: dataPartenaire[
                                              'idContactPartenaire'])
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      _contact.doc(doc.id).update({
                                        'nomContact':
                                            _nomContactController.text,
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
                                        'accessExtranet':
                                            accessExtranet.toString(),
                                        'recoitFacture':
                                            recoitFacture.toString(),
                                        'recoitRapport':
                                            recoitRapport.toString(),
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
                ],
              ),
            ),
          );
        });
  }
}
