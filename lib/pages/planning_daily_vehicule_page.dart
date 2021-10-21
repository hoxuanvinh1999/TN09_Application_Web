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

class PlanningDailyVehiculePage extends StatefulWidget {
  DateTime thisDay;
  Map dataVehicule;
  PlanningDailyVehiculePage(
      {required this.thisDay, required this.dataVehicule});
  @override
  _PlanningDailyVehiculePageState createState() =>
      _PlanningDailyVehiculePageState();
}

class _PlanningDailyVehiculePageState extends State<PlanningDailyVehiculePage> {
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
  @override
  Widget build(BuildContext context) {
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

    //Pick Date Widget
    Future pickDate(BuildContext context) async {
      final initialDate = widget.thisDay;
      final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 25),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (newDate == null) return;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PlanningDailyVehiculePage(
                thisDay: newDate,
                dataVehicule: widget.dataVehicule,
              )));
    }

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
                            text: widget.dataVehicule['nomVehicule'],
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
                              width: 600,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 120,
                                    height: 50,
                                    color: Colors.yellow,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlanningDailyVehiculePage(
                                                            thisDay:
                                                                previousDay,
                                                            dataVehicule: widget
                                                                .dataVehicule,
                                                          )));
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.stepBackward,
                                              size: 15,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              pickDate(context);
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.calendar,
                                              size: 15,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlanningDailyVehiculePage(
                                                            thisDay: nextDay,
                                                            dataVehicule: widget
                                                                .dataVehicule,
                                                          )));
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.stepForward,
                                              size: 15,
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Planning of $thisDay ${widget.thisDay.year}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
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
                          width: 20,
                        ),
                        Container(
                          width: 200,
                          height: 1000,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          width: 900,
                          height: 2000,
                          color: Colors.red,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 900,
                                  color: Colors.green,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: _vehicule
                                        .where('idVehicule',
                                            isNotEqualTo: 'null')
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
                                      // print('$snapshot');
                                      return SingleChildScrollView(
                                        child: Row(
                                          children: snapshot.data!.docs.map(
                                              (DocumentSnapshot
                                                  document_vehicule) {
                                            Map<String, dynamic> vehicule =
                                                document_vehicule.data()!
                                                    as Map<String, dynamic>;
                                            // print('$collecteur');
                                            return Expanded(
                                                child: Container(
                                                    width: 150,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: vehicule[
                                                                  'idVehicule'] ==
                                                              widget.dataVehicule[
                                                                  'idVehicule']
                                                          ? Colors.grey
                                                          : Colors.white,
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 5),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (vehicule[
                                                                'idVehicule'] ==
                                                            widget.dataVehicule[
                                                                'idVehicule']) {
                                                          null;
                                                        } else {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          PlanningDailyVehiculePage(
                                                                            thisDay:
                                                                                widget.thisDay,
                                                                            dataVehicule:
                                                                                vehicule,
                                                                          )));
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          buildVehiculeIcon(
                                                              icontype: vehicule[
                                                                  'typeVehicule'],
                                                              iconcolor: vehicule[
                                                                      'colorIconVehicule']
                                                                  .toUpperCase(),
                                                              sizeIcon: 15.0),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            vehicule[
                                                                'nomVehicule'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )));
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
                                  height: 1800,
                                  width: 890,
                                  color: Colors.blue,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: _tournee
                                        .where('idVehicule',
                                            isEqualTo: widget
                                                .dataVehicule['idVehicule'])
                                        .where('dateTournee',
                                            isEqualTo: getDateText(
                                                date: widget.thisDay))
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
                                      // print('$snapshot');
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: snapshot.data!.docs.map(
                                              (DocumentSnapshot
                                                  document_tournee) {
                                            Map<String, dynamic> tournee =
                                                document_tournee.data()!
                                                    as Map<String, dynamic>;
                                            TextEditingController
                                                _timeStartController =
                                                TextEditingController(
                                                    text: tournee['startTime']);
                                            TextEditingController
                                                _newCollecteur =
                                                TextEditingController();
                                            String idCollecteurTournee =
                                                tournee['idCollecteur'];
                                            return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 40),
                                                width: 880,
                                                height: 900,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 880,
                                                      height: 60,
                                                      color: Color(int.parse(
                                                          tournee[
                                                              'colorTournee'])),
                                                      child: Row(children: [
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        buildVehiculeIcon(
                                                            icontype: widget
                                                                    .dataVehicule[
                                                                'typeVehicule'],
                                                            iconcolor:
                                                                '0xff000000',
                                                            sizeIcon: 15.0),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          limitString(
                                                              text: 'Tournee: ' +
                                                                  tournee[
                                                                      'idTournee'],
                                                              limit_long: 30),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        Icon(
                                                            FontAwesomeIcons
                                                                .user,
                                                            size: 15,
                                                            color:
                                                                Colors.black),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        StreamBuilder<
                                                                QuerySnapshot>(
                                                            stream: _collecteur
                                                                .where(
                                                                    'idCollecteur',
                                                                    isNotEqualTo:
                                                                        'null')
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
                                                              return DropdownButton(
                                                                onChanged: (String?
                                                                    changedValue) async {
                                                                  idCollecteurTournee =
                                                                      changedValue!;
                                                                  // print(
                                                                  //     'idCollecteurTournee $idCollecteurTournee');
                                                                  // print(
                                                                  //     'changedValue $changedValue');
                                                                  await _collecteur
                                                                      .where(
                                                                          'idCollecteur',
                                                                          isEqualTo:
                                                                              changedValue)
                                                                      .limit(1)
                                                                      .get()
                                                                      .then((QuerySnapshot
                                                                          querySnapshot) {
                                                                    querySnapshot
                                                                        .docs
                                                                        .forEach(
                                                                            (doc) {
                                                                      _newCollecteur
                                                                              .text =
                                                                          doc['nomCollecteur'];
                                                                    });
                                                                  });
                                                                },
                                                                value:
                                                                    idCollecteurTournee,
                                                                items: snapshot
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
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: collecteur[
                                                                        'idCollecteur'],
                                                                    child: Text(
                                                                        collecteur[
                                                                            'nomCollecteur']),
                                                                  );
                                                                }).toList(),
                                                              );
                                                            }),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          height: 50,
                                                          color: Color(
                                                              int.parse(tournee[
                                                                  'colorTournee'])),
                                                          child: TextFormField(
                                                            enabled: false,
                                                            controller:
                                                                _newCollecteur,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'New Collecteur',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Icon(
                                                            FontAwesomeIcons
                                                                .clock,
                                                            size: 15,
                                                            color:
                                                                Colors.black),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          height: 50,
                                                          color: Color(
                                                              int.parse(tournee[
                                                                  'colorTournee'])),
                                                          child: TextFormField(
                                                            controller:
                                                                _timeStartController,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'TimeStart',
                                                            ),
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
                                                              FontAwesomeIcons
                                                                  .check,
                                                              size: 15,
                                                            ),
                                                            tooltip:
                                                                'Modify Tournee',
                                                            onPressed: () {
                                                              if (idCollecteurTournee ==
                                                                      tournee[
                                                                          'idCollecteur'] &&
                                                                  _timeStartController
                                                                          .text ==
                                                                      tournee[
                                                                          'startTime']) {
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "You changed nothing",
                                                                    gravity:
                                                                        ToastGravity
                                                                            .TOP);
                                                              } else if (!check_if_a_time(
                                                                  check: _timeStartController
                                                                      .text)) {
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Time form is xx:xx",
                                                                    gravity:
                                                                        ToastGravity
                                                                            .TOP);
                                                              } else {
                                                                _tournee
                                                                    .doc(tournee[
                                                                        'idTournee'])
                                                                    .update({
                                                                  'startTime':
                                                                      _timeStartController
                                                                          .text,
                                                                  'idCollecteur':
                                                                      idCollecteurTournee,
                                                                }).then(
                                                                        (value) {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Tournee Modified",
                                                                      gravity:
                                                                          ToastGravity
                                                                              .TOP);
                                                                  print(
                                                                      "Tournee Modified");
                                                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                      builder: (context) => PlanningDailyVehiculePage(
                                                                          thisDay: widget
                                                                              .thisDay,
                                                                          dataVehicule:
                                                                              widget.dataVehicule)));
                                                                }).catchError(
                                                                        (error) =>
                                                                            print("Failed to add user: $error"));
                                                              }
                                                            },
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          width: 400,
                                                          height: 800,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 20),
                                                          color: Colors.yellow,
                                                          child: StreamBuilder<
                                                              QuerySnapshot>(
                                                            stream: _etape
                                                                .where(
                                                                    'idTourneeEtape',
                                                                    isEqualTo:
                                                                        tournee[
                                                                            'idTournee'])
                                                                .orderBy(
                                                                    'orderEtape')
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
                                                                    'Something went wrong + ${snapshot.error.toString()}');
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
                                                                      .data!
                                                                      .docs
                                                                      .map((DocumentSnapshot
                                                                          document_etape) {
                                                                    Map<String,
                                                                            dynamic>
                                                                        etape =
                                                                        document_etape.data()! as Map<
                                                                            String,
                                                                            dynamic>;
                                                                    // print('$collecteur');
                                                                    return Container(
                                                                        width:
                                                                            400,
                                                                        height:
                                                                            300,
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                10),
                                                                        color: Colors
                                                                            .green,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              height: 50,
                                                                              width: 400,
                                                                              color: Colors.grey,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Container(
                                                                                    child: Row(
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Icon(FontAwesomeIcons.truck, size: 12, color: Colors.black),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Icon(FontAwesomeIcons.arrowAltCircleRight, size: 12, color: Colors.black),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Text(
                                                                                          'Etape #' + etape['orderEtape'],
                                                                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                            onPressed: () async {
                                                                                              // get and save information before do the change
                                                                                              String idEtapeNow = etape['idEtape'];
                                                                                              String idEtapeBefore = etape['idEtapeBefore'];
                                                                                              String idEtapeAfter = etape['idEtapeAfter'];
                                                                                              String idEtapeBeforeofBefore = '';
                                                                                              String neworder = (int.parse(etape['orderEtape']) - 1).toString();
                                                                                              String oldorder = etape['orderEtape'];
                                                                                              if (idEtapeBefore == 'null') {
                                                                                                Fluttertoast.showToast(msg: "This Etape can not go up", gravity: ToastGravity.TOP);
                                                                                              } else if (idEtapeAfter != 'null') {
                                                                                                await _etape.where('idEtape', isEqualTo: idEtapeBefore).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                                  querySnapshot.docs.forEach((etapeBefore) {
                                                                                                    idEtapeBeforeofBefore = etapeBefore['idEtapeBefore'];
                                                                                                  });
                                                                                                });
                                                                                                if (idEtapeBeforeofBefore != 'null') {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': idEtapeBeforeofBefore,
                                                                                                    'idEtapeAfter': idEtapeBefore,
                                                                                                    'orderEtape': neworder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBefore).update({
                                                                                                    'idEtapeBefore': idEtapeNow,
                                                                                                    'idEtapeAfter': idEtapeAfter,
                                                                                                    'orderEtape': oldorder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfter).update({
                                                                                                    'idEtapeBefore': idEtapeBefore,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBeforeofBefore).update({
                                                                                                    'idEtapeAfter': idEtapeNow,
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Up", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Up");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                } else {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': 'null',
                                                                                                    'idEtapeAfter': idEtapeBefore,
                                                                                                    'orderEtape': '1',
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBefore).update({
                                                                                                    'idEtapeBefore': idEtapeNow,
                                                                                                    'idEtapeAfter': idEtapeAfter,
                                                                                                    'orderEtape': '2',
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfter).update({
                                                                                                    'idEtapeBefore': idEtapeBefore,
                                                                                                  });
                                                                                                  _tournee.doc(tournee['idTournee']).update({
                                                                                                    'idEtapeStart': idEtapeNow
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Up", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Up");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                }
                                                                                              } else {
                                                                                                await _etape.where('idEtape', isEqualTo: idEtapeBefore).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                                  querySnapshot.docs.forEach((etapeBefore) {
                                                                                                    idEtapeBeforeofBefore = etapeBefore['idEtapeBefore'];
                                                                                                  });
                                                                                                });
                                                                                                if (idEtapeBeforeofBefore != 'null') {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': idEtapeBeforeofBefore,
                                                                                                    'idEtapeAfter': idEtapeBefore,
                                                                                                    'orderEtape': neworder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBefore).update({
                                                                                                    'idEtapeBefore': idEtapeNow,
                                                                                                    'idEtapeAfter': idEtapeAfter,
                                                                                                    'orderEtape': oldorder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBeforeofBefore).update({
                                                                                                    'idEtapeAfter': idEtapeNow,
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Up", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Up");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                } else {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': 'null',
                                                                                                    'idEtapeAfter': idEtapeBefore,
                                                                                                    'orderEtape': '1',
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBefore).update({
                                                                                                    'idEtapeBefore': idEtapeNow,
                                                                                                    'idEtapeAfter': idEtapeAfter,
                                                                                                    'orderEtape': '2',
                                                                                                  });
                                                                                                  _tournee.doc(tournee['idTournee']).update({
                                                                                                    'idEtapeStart': idEtapeNow
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Up", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Up");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                }
                                                                                              }
                                                                                            },
                                                                                            icon: Icon(
                                                                                              FontAwesomeIcons.chevronCircleUp,
                                                                                              size: 12,
                                                                                            )),
                                                                                        SizedBox(width: 10),
                                                                                        IconButton(
                                                                                            onPressed: () async {
                                                                                              // get and save information before do the change
                                                                                              String idEtapeNow = etape['idEtape'];
                                                                                              String idEtapeBefore = etape['idEtapeBefore'];
                                                                                              String idEtapeAfter = etape['idEtapeAfter'];
                                                                                              String idEtapeAfterofAfter = '';
                                                                                              String neworder = (int.parse(etape['orderEtape']) + 1).toString();
                                                                                              String oldorder = etape['orderEtape'];
                                                                                              if (idEtapeAfter == 'null') {
                                                                                                Fluttertoast.showToast(msg: "This Etape can not go down", gravity: ToastGravity.TOP);
                                                                                              } else if (idEtapeBefore != 'null') {
                                                                                                await _etape.where('idEtape', isEqualTo: idEtapeAfter).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                                  querySnapshot.docs.forEach((etapeAfter) {
                                                                                                    idEtapeAfterofAfter = etapeAfter['idEtapeAfter'];
                                                                                                  });
                                                                                                });
                                                                                                if (idEtapeAfterofAfter != 'null') {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': idEtapeAfter,
                                                                                                    'idEtapeAfter': idEtapeAfterofAfter,
                                                                                                    'orderEtape': neworder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfter).update({
                                                                                                    'idEtapeBefore': idEtapeBefore,
                                                                                                    'idEtapeAfter': idEtapeNow,
                                                                                                    'orderEtape': oldorder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBefore).update({
                                                                                                    'idEtapeAfter': idEtapeAfter,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfterofAfter).update({
                                                                                                    'idEtapeBefore': idEtapeNow,
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Down", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Down");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                } else {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': idEtapeAfter,
                                                                                                    'idEtapeAfter': 'null',
                                                                                                    'orderEtape': neworder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfter).update({
                                                                                                    'idEtapeBefore': idEtapeBefore,
                                                                                                    'idEtapeAfter': idEtapeNow,
                                                                                                    'orderEtape': oldorder,
                                                                                                  });
                                                                                                  _etape.doc(idEtapeBefore).update({
                                                                                                    'idEtapeAfter': idEtapeAfter,
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Up", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Up");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                }
                                                                                              } else {
                                                                                                await _etape.where('idEtape', isEqualTo: idEtapeAfter).limit(1).get().then((QuerySnapshot querySnapshot) {
                                                                                                  querySnapshot.docs.forEach((etapeAfter) {
                                                                                                    idEtapeAfterofAfter = etapeAfter['idEtapeAfter'];
                                                                                                  });
                                                                                                });
                                                                                                if (idEtapeAfterofAfter != 'null') {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': idEtapeAfter,
                                                                                                    'idEtapeAfter': idEtapeAfterofAfter,
                                                                                                    'orderEtape': '2',
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfter).update({
                                                                                                    'idEtapeBefore': 'null',
                                                                                                    'idEtapeAfter': idEtapeNow,
                                                                                                    'orderEtape': '1',
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfterofAfter).update({
                                                                                                    'idEtapeBefore': idEtapeNow,
                                                                                                  });
                                                                                                  _tournee.doc(tournee['idTournee']).update({
                                                                                                    'idEtapeStart': idEtapeAfter
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Down", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Down");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                } else {
                                                                                                  _etape.doc(idEtapeNow).update({
                                                                                                    'idEtapeBefore': idEtapeAfter,
                                                                                                    'idEtapeAfter': 'null',
                                                                                                    'orderEtape': '2',
                                                                                                  });
                                                                                                  _etape.doc(idEtapeAfter).update({
                                                                                                    'idEtapeBefore': 'null',
                                                                                                    'idEtapeAfter': idEtapeNow,
                                                                                                    'orderEtape': '1',
                                                                                                  });
                                                                                                  _tournee.doc(tournee['idTournee']).update({
                                                                                                    'idEtapeStart': idEtapeAfter
                                                                                                  }).then((value) {
                                                                                                    Fluttertoast.showToast(msg: "Etape Moved Down", gravity: ToastGravity.TOP);
                                                                                                    print("Etape Moved Down");
                                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlanningDailyVehiculePage(thisDay: widget.thisDay, dataVehicule: widget.dataVehicule)));
                                                                                                  }).catchError((error) => print("Failed to add user: $error"));
                                                                                                }
                                                                                              }
                                                                                            },
                                                                                            icon: Icon(
                                                                                              FontAwesomeIcons.chevronCircleDown,
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
                                                                              child: StreamBuilder<QuerySnapshot>(
                                                                                stream: _frequence.where('idFrequence', isEqualTo: etape['idFrequenceEtape']).snapshots(),
                                                                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                                  if (snapshot.hasError) {
                                                                                    return Text('Something went wrong');
                                                                                  }

                                                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                    return CircularProgressIndicator();
                                                                                  }
                                                                                  // print('$snapshot');
                                                                                  return SingleChildScrollView(
                                                                                    child: Column(
                                                                                      children: snapshot.data!.docs.map((DocumentSnapshot document_frequence) {
                                                                                        Map<String, dynamic> frequence = document_frequence.data()! as Map<String, dynamic>;
                                                                                        // print('$collecteur');
                                                                                        return Container(
                                                                                          width: 380,
                                                                                          height: 200,
                                                                                          color: Colors.red,
                                                                                          child: Row(
                                                                                            children: [
                                                                                              SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                              Container(
                                                                                                width: 200,
                                                                                                height: 180,
                                                                                                color: Colors.blue,
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    SizedBox(
                                                                                                      height: 10,
                                                                                                    ),
                                                                                                    Text(limitString(text: frequence['nomAdresseFrequence'], limit_long: 30)),
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
                                                                                                    StreamBuilder<QuerySnapshot>(
                                                                                                      stream: _adresse.where('idAdresse', isEqualTo: frequence['idAdresseFrequence']).limit(1).snapshots(),
                                                                                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                                                                                width: 150,
                                                                                                height: 180,
                                                                                                color: Colors.blue,
                                                                                                child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    SizedBox(
                                                                                                      height: 16,
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
                                                                                                      height: 16,
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
                                                                                                      height: 16,
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
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ));
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ]),
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
                  //         builder: (context) => PlanningDailyVehiculePage(
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
                  //         builder: (context) => PlanningDailyVehiculePage(
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
                  //         builder: (context) => PlanningDailyVehiculePage(
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
