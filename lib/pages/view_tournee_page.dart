import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/pages/collecteur_page.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'dart:async';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:tn09_app_web_demo/menu/showSubMenu1.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_if_a_time.dart';
import 'package:tn09_app_web_demo/pages/math_function/frequence_title.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_time_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/is_Inconnu.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/math_function/week_of_year.dart';
import 'package:tn09_app_web_demo/pages/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/widget/button_widget.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';

class ViewTourneePage extends StatefulWidget {
  DateTime thisDay;
  Map dataVehicule;
  Map dataTournee;
  ViewTourneePage(
      {required this.thisDay,
      required this.dataVehicule,
      required this.dataTournee});
  @override
  _ViewTourneePageState createState() => _ViewTourneePageState();
}

class _ViewTourneePageState extends State<ViewTourneePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // for Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  Stream<QuerySnapshot> _vehiculeStream = FirebaseFirestore.instance
      .collection("Vehicule")
      .orderBy('orderVehicule')
      .snapshots();
  //For Collecteur
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  //For Tournee
  CollectionReference _tournee =
      FirebaseFirestore.instance.collection("Tournee");
  //For Etape
  CollectionReference _etape = FirebaseFirestore.instance.collection("Etape");
  // for Frequence
  CollectionReference _frequence =
      FirebaseFirestore.instance.collection("Frequence");
  //For Adresse
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
  TextEditingController _vehiculeInformationController =
      TextEditingController();
  TextEditingController _newCollecteur = TextEditingController();
  TextEditingController _new2eCollecteur = TextEditingController();
  TextEditingController _timeStartController = TextEditingController();
  String _idnom1eCollecteur = 'null';
  String _idnom2eCollecteur = 'null';

  getInputTournee() async {
    _vehiculeInformationController.text = widget.dataVehicule['nomVehicule'] +
        '(${widget.dataVehicule['numeroImmatriculation']})';
    _idnom1eCollecteur = widget.dataTournee['idCollecteur'];
    _timeStartController.text = widget.dataTournee['startTime'];
    if (widget.dataTournee['id2eCollecteur'] == null) {
      _idnom2eCollecteur = 'null';
    } else {
      _idnom2eCollecteur = widget.dataTournee['id2eCollecteur'];
    }
  }

  @override
  Widget build(BuildContext context) {
    getInputTournee();
    //For set up Date
    int currentDay = widget.thisDay.weekday;
    DateTime nextDay = widget.thisDay.add(new Duration(days: 1));
    DateTime previousDay = widget.thisDay.subtract(Duration(days: 1));
    int weeknumber = weekNumber(widget.thisDay);
    String thisDay = DateFormat('EEEE, d MMM').format(widget.thisDay);
    print('widget.thisDay: ${widget.thisDay}');
    print('currentday: $currentDay');
    print('weeknumber: $weeknumber');
    print('thisDay: $thisDay');
    print('nextDay: $nextDay');
    print('previousDay: $previousDay');

    //Pick Time Widget
    Future pickTime(
        {required BuildContext context, required TimeOfDay time}) async {
      final newTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (newTime == null) {
        return;
      }
      setState(() => time = newTime);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                              text: 'Semaine #$weeknumber',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlanningWeeklyPage(
                                                thisDay: widget.thisDay,
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
                              text: thisDay,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlanningDailyPage(
                                                thisDay: widget.thisDay,
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
                            text: 'Tournee ${widget.dataTournee['idTournee']}',
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
            Container(
              width: 1200,
              height: 3000,
              color: Colors.green,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 700,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Tournee ${widget.dataTournee['idTournee']} du $thisDay ${widget.thisDay.year} - ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  buildVehiculeIcon(
                                      icontype:
                                          widget.dataVehicule['typeVehicule'],
                                      iconcolor: widget
                                          .dataVehicule['colorIconVehicule']
                                          .toUpperCase(),
                                      sizeIcon: 15.0),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${widget.dataVehicule['nomVehicule']} ( ${widget.dataVehicule['numeroImmatriculation']}) ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 500,
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 20, bottom: 20),
                                      child: GestureDetector(
                                        onTap: () {},
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
                                              'New Rendez-Vous',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 20, bottom: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          showActionSubMenu(context: context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons
                                                  .chevronCircleRight,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Action',
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          thickness: 5,
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1190,
                    height: 2500,
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 800,
                          height: 1000 +
                              400 *
                                  double.parse(
                                      widget.dataTournee['nombredeEtape']) +
                              500,
                          color: Colors.red,
                          child: Column(
                            children: [
                              Container(
                                width: 790,
                                height: 50,
                                color: Colors.grey,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    buildVehiculeIcon(
                                        icontype:
                                            widget.dataVehicule['typeVehicule'],
                                        iconcolor: '0xff000000',
                                        sizeIcon: 15),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Paramètres de la tournée',
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
                                height: 20,
                              ),
                              Container(
                                height: 400,
                                width: 790,
                                color: Colors.blue,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        buildVehiculeIcon(
                                            icontype: widget
                                                .dataVehicule['typeVehicule'],
                                            iconcolor: '0xff000000',
                                            sizeIcon: 15),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Vehicule: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 400,
                                          color: Colors.red,
                                          child: TextFormField(
                                            enabled: false,
                                            controller:
                                                _vehiculeInformationController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.user,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Collecteur: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 100,
                                          color: Colors.red,
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: _collecteur
                                                  .where('idCollecteur',
                                                      isNotEqualTo: 'null')
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
                                                return DropdownButton(
                                                  onChanged: (String?
                                                      changedValue) async {
                                                    _idnom1eCollecteur =
                                                        changedValue!;
                                                    // print(
                                                    //     'idCollecteurTournee $idCollecteurTournee');
                                                    // print(
                                                    //     'changedValue $changedValue');
                                                    await _collecteur
                                                        .where('idCollecteur',
                                                            isEqualTo:
                                                                changedValue)
                                                        .limit(1)
                                                        .get()
                                                        .then((QuerySnapshot
                                                            querySnapshot) {
                                                      querySnapshot.docs
                                                          .forEach((doc) {
                                                        _newCollecteur.text =
                                                            doc['nomCollecteur'];
                                                      });
                                                    });
                                                  },
                                                  value: _idnom1eCollecteur,
                                                  items: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_collecteur) {
                                                    Map<String, dynamic>
                                                        collecteur =
                                                        document_collecteur
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: collecteur[
                                                          'idCollecteur'],
                                                      child: Text(collecteur[
                                                          'nomCollecteur']),
                                                    );
                                                  }).toList(),
                                                );
                                              }),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'New Collecteur: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 50,
                                          color: Colors.red,
                                          child: TextFormField(
                                            enabled: false,
                                            controller: _newCollecteur,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.blue,
                                          child: IconButton(
                                            icon: const Icon(
                                              FontAwesomeIcons.check,
                                              size: 15,
                                            ),
                                            tooltip: 'New Collecteur',
                                            onPressed: () async {
                                              if (_idnom1eCollecteur ==
                                                  widget.dataTournee[
                                                      'idCollecteur']) {
                                                Fluttertoast.showToast(
                                                    msg: "You chagned nothing",
                                                    gravity: ToastGravity.TOP);
                                              } else if (_idnom1eCollecteur ==
                                                  _idnom2eCollecteur) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Cannot be the same as the 2e Collecteur",
                                                    gravity: ToastGravity.TOP);
                                              } else {
                                                _tournee
                                                    .doc(widget.dataTournee[
                                                        'idTournee'])
                                                    .update({
                                                  'idCollecteur':
                                                      _idnom1eCollecteur,
                                                }).then((value) async {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Changed 1e Collecteur",
                                                      gravity:
                                                          ToastGravity.TOP);
                                                  print(
                                                      "Changed 1e Collecteur");
                                                  await _tournee
                                                      .where('idTournee',
                                                          isEqualTo: widget
                                                                  .dataTournee[
                                                              'idTournee'])
                                                      .limit(1)
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    querySnapshot.docs
                                                        .forEach((doc) {
                                                      Map<String, dynamic>
                                                          next_tournee =
                                                          doc.data()! as Map<
                                                              String, dynamic>;
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ViewTourneePage(
                                                                            thisDay:
                                                                                widget.thisDay,
                                                                            dataVehicule:
                                                                                widget.dataVehicule,
                                                                            dataTournee:
                                                                                next_tournee,
                                                                          )));
                                                    });
                                                  });
                                                }).catchError((error) => print(
                                                        "Failed to add user: $error"));
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.user,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '2e Collecteur: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 100,
                                          color: Colors.red,
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: _collecteur.snapshots(),
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
                                                return DropdownButton(
                                                  onChanged: (String?
                                                      changedValue) async {
                                                    _idnom2eCollecteur =
                                                        changedValue!;
                                                    // print(
                                                    //     'idCollecteurTournee $idCollecteurTournee');
                                                    // print(
                                                    //     'changedValue $changedValue');
                                                    await _collecteur
                                                        .where('idCollecteur',
                                                            isEqualTo:
                                                                changedValue)
                                                        .limit(1)
                                                        .get()
                                                        .then((QuerySnapshot
                                                            querySnapshot) {
                                                      querySnapshot.docs
                                                          .forEach((doc) {
                                                        _new2eCollecteur.text =
                                                            doc['nomCollecteur'];
                                                      });
                                                    });
                                                  },
                                                  value: _idnom2eCollecteur,
                                                  items: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_collecteur) {
                                                    Map<String, dynamic>
                                                        collecteur =
                                                        document_collecteur
                                                                .data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: collecteur[
                                                          'idCollecteur'],
                                                      child: Text(collecteur[
                                                          'nomCollecteur']),
                                                    );
                                                  }).toList(),
                                                );
                                              }),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'New 2e Collecteur: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 50,
                                          color: Colors.red,
                                          child: TextFormField(
                                            enabled: false,
                                            controller: _new2eCollecteur,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.blue,
                                          child: IconButton(
                                            icon: const Icon(
                                              FontAwesomeIcons.check,
                                              size: 15,
                                            ),
                                            tooltip: 'Add 2e Collecteur',
                                            onPressed: () async {
                                              if (_idnom2eCollecteur ==
                                                      'null' ||
                                                  _idnom2eCollecteur ==
                                                      widget.dataTournee[
                                                          'id2eCollecteur']) {
                                                Fluttertoast.showToast(
                                                    msg: "You added no one",
                                                    gravity: ToastGravity.TOP);
                                              } else if (_idnom2eCollecteur ==
                                                  _idnom1eCollecteur) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Cannot be the same as the 1e Collecteur",
                                                    gravity: ToastGravity.TOP);
                                              } else {
                                                _tournee
                                                    .doc(widget.dataTournee[
                                                        'idTournee'])
                                                    .update({
                                                  'id2eCollecteur':
                                                      _idnom2eCollecteur,
                                                }).then((value) async {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Added 2e Collecteur",
                                                      gravity:
                                                          ToastGravity.TOP);
                                                  print("Added 2e Collecteur");
                                                  await _tournee
                                                      .where('idTournee',
                                                          isEqualTo: widget
                                                                  .dataTournee[
                                                              'idTournee'])
                                                      .limit(1)
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    querySnapshot.docs
                                                        .forEach((doc) {
                                                      Map<String, dynamic>
                                                          next_tournee =
                                                          doc.data()! as Map<
                                                              String, dynamic>;
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ViewTourneePage(
                                                                            thisDay:
                                                                                widget.thisDay,
                                                                            dataVehicule:
                                                                                widget.dataVehicule,
                                                                            dataTournee:
                                                                                next_tournee,
                                                                          )));
                                                    });
                                                  });
                                                }).catchError((error) => print(
                                                        "Failed to add user: $error"));
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.clock,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Time Start: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 100,
                                          height: 50,
                                          color: Colors.red,
                                          child: TextFormField(
                                            controller: _timeStartController,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.blue,
                                          child: IconButton(
                                            icon: const Icon(
                                              FontAwesomeIcons.check,
                                              size: 15,
                                            ),
                                            tooltip: 'Change Time Start',
                                            onPressed: () async {
                                              if (_timeStartController.text ==
                                                  widget.dataTournee[
                                                      'startTime']) {
                                                Fluttertoast.showToast(
                                                    msg: "You changed nothing",
                                                    gravity: ToastGravity.TOP);
                                              } else if (!check_if_a_time(
                                                  check: _timeStartController
                                                      .text)) {
                                                Fluttertoast.showToast(
                                                    msg: "Time form is xx:xx",
                                                    gravity: ToastGravity.TOP);
                                              } else {
                                                _tournee
                                                    .doc(widget.dataTournee[
                                                        'idTournee'])
                                                    .update({
                                                  'startTime':
                                                      _timeStartController.text,
                                                }).then((value) async {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Time Start Modified",
                                                      gravity:
                                                          ToastGravity.TOP);
                                                  print("Time Start Modified");
                                                  await _tournee
                                                      .where('idTournee',
                                                          isEqualTo: widget
                                                                  .dataTournee[
                                                              'idTournee'])
                                                      .limit(1)
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    querySnapshot.docs
                                                        .forEach((doc) {
                                                      Map<String, dynamic>
                                                          next_tournee =
                                                          doc.data()! as Map<
                                                              String, dynamic>;
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ViewTourneePage(
                                                                            thisDay:
                                                                                widget.thisDay,
                                                                            dataVehicule:
                                                                                widget.dataVehicule,
                                                                            dataTournee:
                                                                                next_tournee,
                                                                          )));
                                                    });
                                                  });
                                                }).catchError((error) => print(
                                                        "Failed to add user: $error"));
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 200 +
                                    300 *
                                        double.parse(widget
                                            .dataTournee['nombredeEtape']),
                                width: 790,
                                color: Colors.blue,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _etape
                                      .where('idTourneeEtape',
                                          isEqualTo:
                                              widget.dataTournee['idTournee'])
                                      .orderBy('orderEtape')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      print('${snapshot.error.toString()}');
                                      return Text(
                                          'Something went wrong + ${snapshot.error.toString()}');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    // print('$snapshot');
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: snapshot.data!.docs.map(
                                            (DocumentSnapshot document_etape) {
                                          Map<String, dynamic> etape =
                                              document_etape.data()!
                                                  as Map<String, dynamic>;
                                          // print('$collecteur');
                                          return Container(
                                              width: 500,
                                              height: 300,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              color: Colors.green,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 400,
                                                    color: Colors.grey,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                  FontAwesomeIcons
                                                                      .truck,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                  FontAwesomeIcons
                                                                      .arrowAltCircleRight,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'Etape #' +
                                                                    etape[
                                                                        'orderEtape'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    // get and save information before do the change
                                                                    String
                                                                        idEtapeNow =
                                                                        etape[
                                                                            'idEtape'];
                                                                    String
                                                                        idEtapeBefore =
                                                                        etape[
                                                                            'idEtapeBefore'];
                                                                    String
                                                                        idEtapeAfter =
                                                                        etape[
                                                                            'idEtapeAfter'];
                                                                    String
                                                                        idEtapeBeforeofBefore =
                                                                        '';
                                                                    String
                                                                        neworder =
                                                                        (int.parse(etape['orderEtape']) -
                                                                                1)
                                                                            .toString();
                                                                    String
                                                                        oldorder =
                                                                        etape[
                                                                            'orderEtape'];
                                                                    if (idEtapeBefore ==
                                                                        'null') {
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "This Etape can not go up",
                                                                          gravity:
                                                                              ToastGravity.TOP);
                                                                    } else if (idEtapeAfter !=
                                                                        'null') {
                                                                      await _etape
                                                                          .where(
                                                                              'idEtape',
                                                                              isEqualTo:
                                                                                  idEtapeBefore)
                                                                          .limit(
                                                                              1)
                                                                          .get()
                                                                          .then((QuerySnapshot
                                                                              querySnapshot) {
                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((etapeBefore) {
                                                                          idEtapeBeforeofBefore =
                                                                              etapeBefore['idEtapeBefore'];
                                                                        });
                                                                      });
                                                                      if (idEtapeBeforeofBefore !=
                                                                          'null') {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeBeforeofBefore,
                                                                          'idEtapeAfter':
                                                                              idEtapeBefore,
                                                                          'orderEtape':
                                                                              neworder,
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeBefore)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeNow,
                                                                          'idEtapeAfter':
                                                                              idEtapeAfter,
                                                                          'orderEtape':
                                                                              oldorder,
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeAfter)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeBefore,
                                                                        });
                                                                        _etape.doc(idEtapeBeforeofBefore).update({
                                                                          'idEtapeAfter':
                                                                              idEtapeNow,
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Up",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Up");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      } else {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              'null',
                                                                          'idEtapeAfter':
                                                                              idEtapeBefore,
                                                                          'orderEtape':
                                                                              '1',
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeBefore)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeNow,
                                                                          'idEtapeAfter':
                                                                              idEtapeAfter,
                                                                          'orderEtape':
                                                                              '2',
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeAfter)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeBefore,
                                                                        });
                                                                        _tournee.doc(widget.dataTournee['idTournee']).update({
                                                                          'idEtapeStart':
                                                                              idEtapeNow
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Up",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Up");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      }
                                                                    } else {
                                                                      await _etape
                                                                          .where(
                                                                              'idEtape',
                                                                              isEqualTo:
                                                                                  idEtapeBefore)
                                                                          .limit(
                                                                              1)
                                                                          .get()
                                                                          .then((QuerySnapshot
                                                                              querySnapshot) {
                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((etapeBefore) {
                                                                          idEtapeBeforeofBefore =
                                                                              etapeBefore['idEtapeBefore'];
                                                                        });
                                                                      });
                                                                      if (idEtapeBeforeofBefore !=
                                                                          'null') {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeBeforeofBefore,
                                                                          'idEtapeAfter':
                                                                              idEtapeBefore,
                                                                          'orderEtape':
                                                                              neworder,
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeBefore)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeNow,
                                                                          'idEtapeAfter':
                                                                              idEtapeAfter,
                                                                          'orderEtape':
                                                                              oldorder,
                                                                        });
                                                                        _etape.doc(idEtapeBeforeofBefore).update({
                                                                          'idEtapeAfter':
                                                                              idEtapeNow,
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Up",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Up");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      } else {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              'null',
                                                                          'idEtapeAfter':
                                                                              idEtapeBefore,
                                                                          'orderEtape':
                                                                              '1',
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeBefore)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeNow,
                                                                          'idEtapeAfter':
                                                                              idEtapeAfter,
                                                                          'orderEtape':
                                                                              '2',
                                                                        });
                                                                        _tournee.doc(widget.dataTournee['idTournee']).update({
                                                                          'idEtapeStart':
                                                                              idEtapeNow
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Up",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Up");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      }
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    FontAwesomeIcons
                                                                        .chevronCircleUp,
                                                                    size: 12,
                                                                  )),
                                                              SizedBox(
                                                                  width: 10),
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    // get and save information before do the change
                                                                    String
                                                                        idEtapeNow =
                                                                        etape[
                                                                            'idEtape'];
                                                                    String
                                                                        idEtapeBefore =
                                                                        etape[
                                                                            'idEtapeBefore'];
                                                                    String
                                                                        idEtapeAfter =
                                                                        etape[
                                                                            'idEtapeAfter'];
                                                                    String
                                                                        idEtapeAfterofAfter =
                                                                        '';
                                                                    String
                                                                        neworder =
                                                                        (int.parse(etape['orderEtape']) +
                                                                                1)
                                                                            .toString();
                                                                    String
                                                                        oldorder =
                                                                        etape[
                                                                            'orderEtape'];
                                                                    if (idEtapeAfter ==
                                                                        'null') {
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "This Etape can not go down",
                                                                          gravity:
                                                                              ToastGravity.TOP);
                                                                    } else if (idEtapeBefore !=
                                                                        'null') {
                                                                      await _etape
                                                                          .where(
                                                                              'idEtape',
                                                                              isEqualTo:
                                                                                  idEtapeAfter)
                                                                          .limit(
                                                                              1)
                                                                          .get()
                                                                          .then((QuerySnapshot
                                                                              querySnapshot) {
                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((etapeAfter) {
                                                                          idEtapeAfterofAfter =
                                                                              etapeAfter['idEtapeAfter'];
                                                                        });
                                                                      });
                                                                      if (idEtapeAfterofAfter !=
                                                                          'null') {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeAfter,
                                                                          'idEtapeAfter':
                                                                              idEtapeAfterofAfter,
                                                                          'orderEtape':
                                                                              neworder,
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeAfter)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeBefore,
                                                                          'idEtapeAfter':
                                                                              idEtapeNow,
                                                                          'orderEtape':
                                                                              oldorder,
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeBefore)
                                                                            .update({
                                                                          'idEtapeAfter':
                                                                              idEtapeAfter,
                                                                        });
                                                                        _etape.doc(idEtapeAfterofAfter).update({
                                                                          'idEtapeBefore':
                                                                              idEtapeNow,
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Down",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Down");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      } else {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeAfter,
                                                                          'idEtapeAfter':
                                                                              'null',
                                                                          'orderEtape':
                                                                              neworder,
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeAfter)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeBefore,
                                                                          'idEtapeAfter':
                                                                              idEtapeNow,
                                                                          'orderEtape':
                                                                              oldorder,
                                                                        });
                                                                        _etape.doc(idEtapeBefore).update({
                                                                          'idEtapeAfter':
                                                                              idEtapeAfter,
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Up",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Up");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      }
                                                                    } else {
                                                                      await _etape
                                                                          .where(
                                                                              'idEtape',
                                                                              isEqualTo:
                                                                                  idEtapeAfter)
                                                                          .limit(
                                                                              1)
                                                                          .get()
                                                                          .then((QuerySnapshot
                                                                              querySnapshot) {
                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((etapeAfter) {
                                                                          idEtapeAfterofAfter =
                                                                              etapeAfter['idEtapeAfter'];
                                                                        });
                                                                      });
                                                                      if (idEtapeAfterofAfter !=
                                                                          'null') {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeAfter,
                                                                          'idEtapeAfter':
                                                                              idEtapeAfterofAfter,
                                                                          'orderEtape':
                                                                              '2',
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeAfter)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              'null',
                                                                          'idEtapeAfter':
                                                                              idEtapeNow,
                                                                          'orderEtape':
                                                                              '1',
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeAfterofAfter)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeNow,
                                                                        });
                                                                        _tournee.doc(widget.dataTournee['idTournee']).update({
                                                                          'idEtapeStart':
                                                                              idEtapeAfter
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Down",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Down");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      } else {
                                                                        _etape
                                                                            .doc(idEtapeNow)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              idEtapeAfter,
                                                                          'idEtapeAfter':
                                                                              'null',
                                                                          'orderEtape':
                                                                              '2',
                                                                        });
                                                                        _etape
                                                                            .doc(idEtapeAfter)
                                                                            .update({
                                                                          'idEtapeBefore':
                                                                              'null',
                                                                          'idEtapeAfter':
                                                                              idEtapeNow,
                                                                          'orderEtape':
                                                                              '1',
                                                                        });
                                                                        _tournee.doc(widget.dataTournee['idTournee']).update({
                                                                          'idEtapeStart':
                                                                              idEtapeAfter
                                                                        }).then(
                                                                            (value) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Etape Moved Down",
                                                                              gravity: ToastGravity.TOP);
                                                                          print(
                                                                              "Etape Moved Down");
                                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                        }).catchError((error) =>
                                                                            print("Failed to add user: $error"));
                                                                      }
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    FontAwesomeIcons
                                                                        .chevronCircleDown,
                                                                    size: 12,
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width: 390,
                                                    height: 200,
                                                    color: Colors.red,
                                                    child: StreamBuilder<
                                                        QuerySnapshot>(
                                                      stream: _frequence
                                                          .where('idFrequence',
                                                              isEqualTo: etape[
                                                                  'idFrequenceEtape'])
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
                                                        // print('$snapshot');
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            children: snapshot
                                                                .data!.docs
                                                                .map((DocumentSnapshot
                                                                    document_frequence) {
                                                              Map<String,
                                                                      dynamic>
                                                                  frequence =
                                                                  document_frequence
                                                                          .data()!
                                                                      as Map<
                                                                          String,
                                                                          dynamic>;
                                                              // print('$collecteur');
                                                              return Container(
                                                                width: 380,
                                                                height: 200,
                                                                color:
                                                                    Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          180,
                                                                      color: Colors
                                                                          .blue,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(limitString(
                                                                              text: frequence['nomAdresseFrequence'],
                                                                              limit_long: 30)),
                                                                          Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Icon(FontAwesomeIcons.undoAlt, size: 12, color: Colors.black),
                                                                              SizedBox(
                                                                                width: 2,
                                                                              ),
                                                                              Text(
                                                                                titleFrequence(frequence: frequence['frequence'], jourFrequence: frequence['jourFrequence']),
                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          StreamBuilder<
                                                                              QuerySnapshot>(
                                                                            stream:
                                                                                _adresse.where('idAdresse', isEqualTo: frequence['idAdresseFrequence']).limit(1).snapshots(),
                                                                            builder:
                                                                                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                              if (snapshot.hasError) {
                                                                                return Text('Something went wrong');
                                                                              }

                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return CircularProgressIndicator();
                                                                              }
                                                                              // print('$snapshot');
                                                                              return SingleChildScrollView(
                                                                                child: Row(
                                                                                  children: snapshot.data!.docs.map((DocumentSnapshot document_adresse) {
                                                                                    Map<String, dynamic> adresse = document_adresse.data()! as Map<String, dynamic>;
                                                                                    // print('$collecteur');
                                                                                    return Column(
                                                                                      children: [
                                                                                        Text(adresse['ligne1Adresse'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                                                                        Text(adresse['codepostalAdresse'] + ' ' + adresse['villeAdresse'] + ' ' + adresse['paysAdresse'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                                                                      ],
                                                                                    );
                                                                                  }).toList(),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          180,
                                                                      color: Colors
                                                                          .blue,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                16,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                FontAwesomeIcons.clock,
                                                                                size: 12,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                'Durée ' + frequence['dureeFrequence'] + ' min',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                16,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                FontAwesomeIcons.clock,
                                                                                size: 12,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                'Start ' + ' min',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                16,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                FontAwesomeIcons.moneyCheckAlt,
                                                                                size: 12,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                'Tarif ' + isInconnu(text: frequence['tarifFrequence']) + ' €',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ));
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 790,
                                height: 50,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Text(
                                      '#',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Text(
                                      'Vehicule',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Text(
                                      'Collecteur',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Text(
                                      'Start',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Text(
                                      'Etape',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 400,
                                width: 790,
                                color: Colors.blue,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _tournee
                                      .where('dateTournee',
                                          isEqualTo:
                                              getDateText(date: widget.thisDay))
                                      .where('idTournee',
                                          isNotEqualTo:
                                              widget.dataTournee['idTournee'])
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
                                        children: snapshot.data!.docs.map(
                                            (DocumentSnapshot
                                                document_tournee) {
                                          Map<String, dynamic> tournee =
                                              document_tournee.data()!
                                                  as Map<String, dynamic>;
                                          // print('$collecteur');

                                          return Container(
                                              width: 750,
                                              height: 50,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: limitString(
                                                                    text: tournee[
                                                                        'idTournee'],
                                                                    limit_long:
                                                                        10),
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
                                                                          () async {
                                                                        await _vehicule
                                                                            .where('idVehicule',
                                                                                isEqualTo: tournee['idVehicule'])
                                                                            .limit(1)
                                                                            .get()
                                                                            .then((QuerySnapshot querySnapshot) {
                                                                          querySnapshot
                                                                              .docs
                                                                              .forEach((doc) {
                                                                            Map<String, dynamic>
                                                                                next_vehicule =
                                                                                doc.data()! as Map<String, dynamic>;
                                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                                builder: (context) => ViewTourneePage(
                                                                                      thisDay: widget.thisDay,
                                                                                      dataVehicule: next_vehicule,
                                                                                      dataTournee: tournee,
                                                                                    )));
                                                                          });
                                                                        });
                                                                      }),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Container(
                                                        child: StreamBuilder<
                                                            QuerySnapshot>(
                                                          stream: _vehicule
                                                              .where(
                                                                  'idVehicule',
                                                                  isEqualTo:
                                                                      tournee[
                                                                          'idVehicule'])
                                                              .limit(1)
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              print(
                                                                  '${snapshot.error.toString()}');
                                                              return Text(
                                                                  'Something went wrong');
                                                            }

                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return CircularProgressIndicator();
                                                            }
                                                            // print('$snapshot');

                                                            return SingleChildScrollView(
                                                              child: Row(
                                                                children: snapshot
                                                                    .data!.docs
                                                                    .map((DocumentSnapshot
                                                                        document_vehicule) {
                                                                  Map<String,
                                                                          dynamic>
                                                                      vehicule =
                                                                      document_vehicule
                                                                              .data()!
                                                                          as Map<
                                                                              String,
                                                                              dynamic>;
                                                                  // print('$collecteur');

                                                                  return Container(
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              buildVehiculeIcon(icontype: vehicule['typeVehicule'], iconcolor: vehicule['colorIconVehicule'].toUpperCase(), sizeIcon: 15),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                '${vehicule['nomVehicule']} ( ${vehicule['numeroImmatriculation']}) ',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ));
                                                                }).toList(),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 70,
                                                      ),
                                                      Container(
                                                        child: StreamBuilder<
                                                            QuerySnapshot>(
                                                          stream: _collecteur
                                                              .where(
                                                                  'idCollecteur',
                                                                  isEqualTo:
                                                                      tournee[
                                                                          'idCollecteur'])
                                                              .limit(1)
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              print(
                                                                  '${snapshot.error.toString()}');
                                                              return Text(
                                                                  'Something went wrong');
                                                            }

                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return CircularProgressIndicator();
                                                            }
                                                            // print('$snapshot');

                                                            return SingleChildScrollView(
                                                              child: Row(
                                                                children: snapshot
                                                                    .data!.docs
                                                                    .map((DocumentSnapshot
                                                                        document_collecteur) {
                                                                  Map<String,
                                                                          dynamic>
                                                                      collecteur =
                                                                      document_collecteur
                                                                              .data()!
                                                                          as Map<
                                                                              String,
                                                                              dynamic>;
                                                                  // print('$collecteur');

                                                                  return Container(
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                FontAwesomeIcons.user,
                                                                                size: 15,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                collecteur['nomCollecteur'],
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ));
                                                                }).toList(),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 75,
                                                      ),
                                                      Text(
                                                        tournee['startTime'],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 100,
                                                      ),
                                                      Text(
                                                        tournee[
                                                            'nombredeEtape'],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                              ));
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showActionSubMenu({required BuildContext context}) {
    return showDialog(
        barrierColor: null,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            alignment: Alignment(1, -0.10),
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => ViewTourneePage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.print,
                          size: 12,
                        ),
                        SizedBox(width: 10),
                        Text('Imprimer'),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => ViewTourneePage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.cropAlt,
                          size: 12,
                        ),
                        SizedBox(width: 10),
                        Text('Vue Compacte'),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(
                  //         builder: (context) => ViewTourneePage(
                  //               thisDay:
                  //                   // DateTime.parse('2019-10-05 15:43:03.887'),
                  //                   DateTime.now(),
                  //             )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 0),
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.userClock,
                          size: 12,
                        ),
                        SizedBox(width: 10),
                        Text('Vue Collecteur'),
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
