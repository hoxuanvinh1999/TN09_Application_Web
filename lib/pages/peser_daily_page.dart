import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'dart:async';
// import 'package:http/http.dart' as html;
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_if_a_time.dart';
import 'package:tn09_app_web_demo/pages/math_function/frequence_title.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/is_Inconnu.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/math_function/week_of_year.dart';
import 'package:tn09_app_web_demo/pages/matieres_page.dart';
import 'package:tn09_app_web_demo/pages/peser_daily_etape_page.dart';
import 'package:tn09_app_web_demo/pages/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/view_tournee_page.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:tn09_app_web_demo/.env.dart';
import 'package:tn09_app_web_demo/pages/widget/company_position.dart'
    as company;

class PeserDailyPage extends StatefulWidget {
  DateTime thisDay;
  PeserDailyPage({
    required this.thisDay,
  });
  @override
  _PeserDailyPageState createState() => _PeserDailyPageState();
}

class _PeserDailyPageState extends State<PeserDailyPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // For Tounree
  CollectionReference _tournee =
      FirebaseFirestore.instance.collection("Tournee");
  // For Etape
  CollectionReference _etape = FirebaseFirestore.instance.collection("Etape");
  // For Type Matiere
  CollectionReference _matiere =
      FirebaseFirestore.instance.collection("Matiere");
  // For Type Contenant
  CollectionReference _typecontenant =
      FirebaseFirestore.instance.collection("TypeContenant");

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
          builder: (context) => PeserDailyPage(
                thisDay: newDate,
              )));
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
                              text: 'Peser ' + thisDay,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
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
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PeserDailyPage(
                                                                thisDay:
                                                                    previousDay,
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
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PeserDailyPage(
                                                                thisDay:
                                                                    nextDay,
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
                                    'Peser $thisDay ${widget.thisDay.year}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 5,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        width: 500,
                        height: 2000,
                        color: Colors.yellow,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _tournee
                              .where('dateTournee',
                                  isEqualTo: getDateText(date: widget.thisDay))
                              .where('status', isEqualTo: 'finished')
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

                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document_tournee) {
                                  Map<String, dynamic> tournee =
                                      document_tournee.data()!
                                          as Map<String, dynamic>;
                                  return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      color: Colors.red,
                                      width: 500,
                                      height: 150 +
                                          300 *
                                              double.parse(
                                                  tournee['nombredeEtape']),
                                      child: Column(children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          alignment: Alignment(-0.8, 0),
                                          width: 500,
                                          height: 50,
                                          color: Colors.blue,
                                          child: Text(
                                              'Tournee ' + tournee['idTournee'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ),
                                        Container(
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _etape
                                                .where('idTourneeEtape',
                                                    isEqualTo:
                                                        tournee['idTournee'])
                                                .orderBy('orderEtape')
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                print(
                                                    '${snapshot.error.toString()}');
                                                return Text(
                                                    'Something went wrong');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: snapshot.data!.docs
                                                      .map((DocumentSnapshot
                                                          document_etape) {
                                                    Map<String, dynamic> etape =
                                                        document_etape.data()!
                                                            as Map<String,
                                                                dynamic>;
                                                    if (etape[
                                                            'resultCollecte'] ==
                                                        null) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 20,
                                                            left: 10),
                                                        width: 400,
                                                        height: 300,
                                                        color: Colors.green,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              width: 400,
                                                              height: 50,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                  'Etape #' +
                                                                      etape[
                                                                          'orderEtape'] +
                                                                      ':  ' +
                                                                      etape[
                                                                          'nomAdresseEtape'],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15)),
                                                            ),
                                                            Container(
                                                              width: 350,
                                                              height: 50,
                                                              color:
                                                                  Colors.blue,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .clock,
                                                                    size: 15,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                      'Time: ' +
                                                                          etape[
                                                                              'realStartTime'] +
                                                                          ' - ' +
                                                                          etape[
                                                                              'realEndTime'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 350,
                                                              height: 50,
                                                              color:
                                                                  Colors.blue,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .hourglassHalf,
                                                                    size: 15,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                      'Duree: ' +
                                                                          etape[
                                                                              'duree'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      Map<String, dynamic>
                                                          etape_result =
                                                          etape['resultCollecte']
                                                              as Map<String,
                                                                  dynamic>;
                                                      Map<String, dynamic>
                                                          etape_result_peser =
                                                          etape['resultPeser'] ==
                                                                  null
                                                              ? {}
                                                              : etape['resultPeser']
                                                                  as Map<String,
                                                                      dynamic>;
                                                      List<Widget>
                                                          result_contenant_information =
                                                          [];
                                                      List etape_result_key =
                                                          etape_result.keys
                                                              .toList();
                                                      for (int i = 0;
                                                          i <
                                                              etape_result_key
                                                                  .length;
                                                          i++) {
                                                        //Condition check will be changed in the future
                                                        if (etape_result_key[
                                                                    i] !=
                                                                'idTournee' &&
                                                            etape_result_key[
                                                                    i] !=
                                                                'numberOfContenant' &&
                                                            etape_result_key[
                                                                    i] !=
                                                                'idCollecteur' &&
                                                            etape_result_key[
                                                                    i] !=
                                                                'idEtape' &&
                                                            etape_result_key[
                                                                    i] !=
                                                                'numberOfTypeContenant') {
                                                          String typeContenant =
                                                              etape_result_key[
                                                                  i];
                                                          // String
                                                          //     nomTypeContenant =
                                                          //     '';
                                                          // _typecontenant
                                                          //     .where(
                                                          //         'nomTypeContenant',
                                                          //         isEqualTo:
                                                          //             etape_result_key[
                                                          //                 i])
                                                          //     .limit(1)
                                                          //     .get()
                                                          //     .then((QuerySnapshot
                                                          //         querySnapshot) {
                                                          //   querySnapshot.docs
                                                          //       .forEach(
                                                          //           (document_type_contenant) {
                                                          //     Map<String, dynamic>
                                                          //         type_contenant =
                                                          //         document_type_contenant
                                                          //                 .data()!
                                                          //             as Map<
                                                          //                 String,
                                                          //                 dynamic>;
                                                          //     nomTypeContenant =
                                                          //         type_contenant[
                                                          //             'idTypeContenant'];
                                                          //   });
                                                          // });
                                                          if (etape_result_peser[
                                                                      typeContenant] ==
                                                                  null ||
                                                              etape_result_peser ==
                                                                  {}) {
                                                            result_contenant_information
                                                                .add(
                                                              Container(
                                                                width: 350,
                                                                height: 50,
                                                                color:
                                                                    Colors.blue,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .boxOpen,
                                                                      size: 15,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      child: StreamBuilder<
                                                                          QuerySnapshot>(
                                                                        stream: _typecontenant
                                                                            .where('nomTypeContenant',
                                                                                isEqualTo: etape_result_key[i])
                                                                            .limit(1)
                                                                            .snapshots(),
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<QuerySnapshot>
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasError) {
                                                                            print('${snapshot.error.toString()}');
                                                                            return Text('Something went wrong');
                                                                          }

                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return CircularProgressIndicator();
                                                                          }
                                                                          late Widget
                                                                              nom_contenant_information;
                                                                          snapshot
                                                                              .data!
                                                                              .docs
                                                                              .forEach((DocumentSnapshot document_type_contenant) {
                                                                            Map<String, dynamic>
                                                                                type_contenant =
                                                                                document_type_contenant.data()! as Map<String, dynamic>;

                                                                            nom_contenant_information =
                                                                                Text(
                                                                              type_contenant['idTypeContenant'],
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                                                            );
                                                                          });
                                                                          return nom_contenant_information;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        ': ' +
                                                                            etape_result[etape_result_key[i]]
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15)),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        width:
                                                                            50,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .yellow,
                                                                            borderRadius: BorderRadius.circular(
                                                                                5)),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                                builder: (context) => PeserDailyEtapePage(
                                                                                      thisDay: widget.thisDay,
                                                                                      typeContenant: etape_result_key[i],
                                                                                      nombredeContenant: etape_result[etape_result_key[i]],
                                                                                      idEtape: etape['idEtape'],
                                                                                    )));
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                'Peser',
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
                                                            );
                                                          } else {
                                                            Map<String, dynamic>
                                                                contenant_information =
                                                                etape_result_peser[
                                                                        typeContenant]
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;
                                                            result_contenant_information
                                                                .add(
                                                              Container(
                                                                width: 350,
                                                                height: 50,
                                                                color:
                                                                    Colors.blue,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .boxOpen,
                                                                      size: 15,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      child: StreamBuilder<
                                                                          QuerySnapshot>(
                                                                        stream: _typecontenant
                                                                            .where('nomTypeContenant',
                                                                                isEqualTo: etape_result_key[i])
                                                                            .limit(1)
                                                                            .snapshots(),
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<QuerySnapshot>
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasError) {
                                                                            print('${snapshot.error.toString()}');
                                                                            return Text('Something went wrong');
                                                                          }

                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return CircularProgressIndicator();
                                                                          }
                                                                          late Widget
                                                                              nom_contenant_information;
                                                                          snapshot
                                                                              .data!
                                                                              .docs
                                                                              .forEach((DocumentSnapshot document_type_contenant) {
                                                                            Map<String, dynamic>
                                                                                type_contenant =
                                                                                document_type_contenant.data()! as Map<String, dynamic>;

                                                                            nom_contenant_information =
                                                                                Text(
                                                                              type_contenant['idTypeContenant'],
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                                                            );
                                                                          });
                                                                          return nom_contenant_information;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        ': ' +
                                                                            etape_result[etape_result_key[i]]
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15)),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      child: StreamBuilder<
                                                                          QuerySnapshot>(
                                                                        stream: _matiere
                                                                            .where('idMatiere',
                                                                                isEqualTo: contenant_information['typeMatiere'])
                                                                            .limit(1)
                                                                            .snapshots(),
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<QuerySnapshot>
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasError) {
                                                                            print('${snapshot.error.toString()}');
                                                                            return Text('Something went wrong');
                                                                          }

                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return CircularProgressIndicator();
                                                                          }
                                                                          List<Widget>
                                                                              matiere_information =
                                                                              [];
                                                                          snapshot
                                                                              .data!
                                                                              .docs
                                                                              .forEach((DocumentSnapshot document_matiere) {
                                                                            Map<String, dynamic>
                                                                                matiere =
                                                                                document_matiere.data()! as Map<String, dynamic>;
                                                                            matiere_information.add(Icon(
                                                                              FontAwesomeIcons.tag,
                                                                              color: Color(int.parse(matiere['colorMatiere'])),
                                                                              size: 15,
                                                                            ));
                                                                            matiere_information.add(SizedBox(
                                                                              width: 10,
                                                                            ));
                                                                            matiere_information.add(
                                                                              Text(matiere['nomMatiere'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                                                                            );
                                                                            matiere_information.add(SizedBox(
                                                                              width: 10,
                                                                            ));
                                                                          });
                                                                          return Row(
                                                                              children: matiere_information);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        contenant_information['poidTotal'] +
                                                                            ' kg(s)',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15)),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      }
                                                      //print('$etape_result_key');
                                                      //print('$etape_result');
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 20,
                                                            left: 10),
                                                        width: 400,
                                                        height: 300,
                                                        color: Colors.green,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              width: 400,
                                                              height: 50,
                                                              color:
                                                                  Colors.yellow,
                                                              child: Text(
                                                                  'Etape #' +
                                                                      etape[
                                                                          'orderEtape'] +
                                                                      ':  ' +
                                                                      etape[
                                                                          'nomAdresseEtape'],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15)),
                                                            ),
                                                            Container(
                                                              width: 350,
                                                              height: 50,
                                                              color:
                                                                  Colors.blue,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .clock,
                                                                    size: 15,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                      'Time: ' +
                                                                          etape[
                                                                              'realStartTime'] +
                                                                          ' - ' +
                                                                          etape[
                                                                              'realEndTime'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 350,
                                                              height: 50,
                                                              color:
                                                                  Colors.blue,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .hourglassHalf,
                                                                    size: 15,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                      'Duree: ' +
                                                                          etape[
                                                                              'duree'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 350,
                                                              height: 120,
                                                              color:
                                                                  Colors.blue,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children:
                                                                      result_contenant_information,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  }).toList(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ]));
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        color: Colors.yellow,
                        height: 500,
                        width: 500,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                              ),
                              width: 500,
                              height: 50,
                              color: Colors.blue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.weight,
                                      size: 15, color: Colors.black),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Peser',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
