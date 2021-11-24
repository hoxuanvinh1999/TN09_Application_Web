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
import 'package:tn09_app_web_demo/pages/menu3/planning_daily_page.dart';
import 'package:tn09_app_web_demo/pages/menu3/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/menu3/view_tournee_page.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:tn09_app_web_demo/.env.dart';
import 'package:tn09_app_web_demo/pages/widget/company_position.dart'
    as company;
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

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
  // For Google Map
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(44.855601489864014, -0.5484378447808893),
    zoom: 15,
  );

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
  //clear data
  void clearCreatingTournee() async {
    await _tournee
        .where('isCreating', isEqualTo: 'true')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((tournee_data) {
        _tournee.doc(tournee_data['idTournee']).delete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    clearCreatingTournee();
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
                decoration: BoxDecoration(
                  color: Color(graphique.color['default_yellow']),
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                ),
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
                              text: 'Semaine #$weeknumber',
                              style: TextStyle(
                                  color: Color(graphique.color['default_red']),
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
                                  color: Color(graphique.color['default_red']),
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
                                color: Color(graphique.color['default_grey']),
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
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
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
                          width: 600,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                color: Color(graphique.color['default_yellow']),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlanningDailyVehiculePage(
                                                        thisDay: previousDay,
                                                        dataVehicule:
                                                            widget.dataVehicule,
                                                      )));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.stepBackward,
                                          size: 15,
                                          color: Color(
                                              graphique.color['default_black']),
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          pickDate(context);
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                          color: Color(
                                              graphique.color['default_black']),
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlanningDailyVehiculePage(
                                                        thisDay: nextDay,
                                                        dataVehicule:
                                                            widget.dataVehicule,
                                                      )));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.stepForward,
                                          size: 15,
                                          color: Color(
                                              graphique.color['default_black']),
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
                                  color: Color(graphique.color['main_color_2']),
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
                                      color: Color(
                                          graphique.color['default_yellow']),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {},
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
                                          'New Rendez-Vous',
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
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          graphique.color['default_yellow']),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      showActionSubMenu(context: context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.chevronCircleRight,
                                          color: Color(
                                              graphique.color['default_black']),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Action',
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
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1190,
                    height: 2500,
                    color: Color(graphique.color['default_yellow']),
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
                          color: Color(graphique.color['default_red']),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          width: 900,
                          height: 2000,
                          color: Color(graphique.color['default_red']),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 900,
                                  color: Colors.green,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: _vehicule
                                        .orderBy('orderVehicule')
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
                                            if (vehicule['idVehicule'] ==
                                                'null') {
                                              return SizedBox.shrink();
                                            }
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
                                                          : Color(graphique
                                                                  .color[
                                                              'default_white']),
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
                                        .orderBy('startTime')
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
                                            //For google map
                                            Completer<GoogleMapController>
                                                _controller = Completer();
                                            GoogleMapController?
                                                _googleMapController;
                                            Set<Marker> _markers = {};
                                            Set<Polyline> _polylines =
                                                Set<Polyline>();
                                            // Build Information
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
                                                color: Color(graphique
                                                    .color['default_white']),
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
                                                        RichText(
                                                          text: TextSpan(
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                  text: limitString(
                                                                      text: 'Tournee: ' +
                                                                          tournee[
                                                                              'idTournee'],
                                                                      limit_long:
                                                                          30),
                                                                  style: TextStyle(
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
                                                                              builder: (context) => ViewTourneePage(
                                                                                    thisDay: widget.thisDay,
                                                                                    dataVehicule: widget.dataVehicule,
                                                                                    dataTournee: tournee,
                                                                                  )));
                                                                        }),
                                                            ],
                                                          ),
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
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_yellow']),
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
                                                                              color: Color(graphique.color['default_grey']),
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
                                                                              color: Color(graphique.color['default_red']),
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
                                                                                          color: Color(graphique.color['default_red']),
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
                                                                                                            color: Color(graphique.color['default_black']),
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
                                                                                                          'Start ' + isInconnu(text: frequence['dureeFrequence']) + ' min',
                                                                                                          style: TextStyle(
                                                                                                            color: Color(graphique.color['default_black']),
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
                                                                                                            color: Color(graphique.color['default_black']),
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
                                                          width: 30,
                                                        ),
                                                        Container(
                                                          width: 400,
                                                          height: 800,
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_yellow']),
                                                          child: FutureBuilder<
                                                              String>(
                                                            future: Future<
                                                                String>.delayed(
                                                              const Duration(
                                                                  seconds: 2),
                                                              () async {
                                                                List<LatLng>
                                                                    polylineCoordinates =
                                                                    [];
                                                                PolylinePoints
                                                                    polylinePoints =
                                                                    PolylinePoints();
                                                                List<double>
                                                                    listlongitudeLocation =
                                                                    [];
                                                                List<double>
                                                                    listlatitudeLocation =
                                                                    [];
                                                                int numberofMarker =
                                                                    0;
                                                                for (int i = 0;
                                                                    i <
                                                                        int.parse(
                                                                            tournee['nombredeEtape']);
                                                                    i++) {
                                                                  await _etape
                                                                      .where(
                                                                          'idTourneeEtape',
                                                                          isEqualTo: tournee[
                                                                              'idTournee'])
                                                                      .get()
                                                                      .then((QuerySnapshot
                                                                          querySnapshot) {
                                                                    querySnapshot
                                                                        .docs
                                                                        .forEach(
                                                                            (doc_etape) async {
                                                                      Map<String,
                                                                              dynamic>
                                                                          etape =
                                                                          doc_etape.data()! as Map<
                                                                              String,
                                                                              dynamic>;
                                                                      await _adresse
                                                                          .where(
                                                                              'idAdresse',
                                                                              isEqualTo: etape[
                                                                                  'idAdresseEtape'])
                                                                          .limit(
                                                                              1)
                                                                          .get()
                                                                          .then((QuerySnapshot
                                                                              querySnapshot) {
                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((doc_adresse) {
                                                                          // print(
                                                                          //     'k');
                                                                          Map<String, dynamic>
                                                                              adresse =
                                                                              doc_adresse.data()! as Map<String, dynamic>;
                                                                          if (adresse['latitudeAdresse'] != '0' && adresse['longitudeAdresse'] != '0'
                                                                              // &&  adresse['idPosition'] != 'null'
                                                                              ) {
                                                                            // print('j');
                                                                            if (_markers.length <
                                                                                int.parse(tournee['nombredeEtape'])) {
                                                                              numberofMarker++;
                                                                              listlatitudeLocation.add(double.parse(adresse['latitudeAdresse']));
                                                                              listlongitudeLocation.add(double.parse(adresse['longitudeAdresse']));
                                                                              _markers.add(Marker(
                                                                                markerId: MarkerId(adresse['idAdresse']), // it can be idPosition but doesnt work now
                                                                                infoWindow: InfoWindow(title: adresse['nomPartenaireAdresse']),
                                                                                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                                                                                position: LatLng(double.parse(adresse['latitudeAdresse']), double.parse(adresse['longitudeAdresse'])),
                                                                              ));
                                                                            }
                                                                          }
                                                                        });
                                                                      });
                                                                    });
                                                                  });
                                                                }

                                                                _markers.add(company
                                                                    .companyMarker);
                                                                numberofMarker++;

                                                                print(
                                                                    'numberofMarker: $numberofMarker');
                                                                print(
                                                                    ' listlatitudeLocation ${listlatitudeLocation.length} : $listlatitudeLocation');
                                                                print(
                                                                    ' listlongitudeLocation ${listlongitudeLocation.length} : $listlongitudeLocation');
                                                                print(
                                                                    '  _markers ${_markers.length}');

                                                                for (int j = 0;
                                                                    j <
                                                                        // int.parse(
                                                                        //     tournee['nombredeEtape']);
                                                                        // numberofMarker;
                                                                        _markers
                                                                            .length;
                                                                    j++) {
                                                                  print('$j');
                                                                  if (j == 0) {
                                                                    polylineCoordinates
                                                                        .clear();
                                                                    // polylineCoordinates.add(LatLng(
                                                                    //     44.85552543453359,
                                                                    //     -0.5484378447808893));
                                                                    // polylineCoordinates.add(LatLng(
                                                                    //     44.8606994,
                                                                    //     -0.5562271000000001));

                                                                    // _polylines.add(
                                                                    //     Polyline(
                                                                    //   polylineId:
                                                                    //       PolylineId(
                                                                    //           'Polyline_Etape_1'),
                                                                    //   width: 5,
                                                                    //   visible:
                                                                    //       true,
                                                                    //   color: Colors
                                                                    //       .blue,
                                                                    //   points:
                                                                    //       polylineCoordinates,
                                                                    // ));

                                                                    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
                                                                        googleAPIKey,
                                                                        PointLatLng(
                                                                            44.85552543453359,
                                                                            -0.5484378447808893),
                                                                        PointLatLng(
                                                                            listlatitudeLocation[0],
                                                                            listlongitudeLocation[0])
                                                                        // PointLatLng(44.86301953775456, -0.550416465058058)
                                                                        );
                                                                    print(
                                                                        'Result Status  ${result.status}');
                                                                    if (result
                                                                            .status ==
                                                                        'OK') {
                                                                      result
                                                                          .points
                                                                          .forEach((PointLatLng
                                                                              point) {
                                                                        polylineCoordinates.add(LatLng(
                                                                            point.latitude,
                                                                            point.longitude));
                                                                      });
                                                                      _polylines
                                                                          .add(
                                                                              Polyline(
                                                                        polylineId:
                                                                            PolylineId('Polyline_Etape_1'),
                                                                        width:
                                                                            5,
                                                                        color: Colors
                                                                            .blue,
                                                                        points:
                                                                            polylineCoordinates,
                                                                      ));
                                                                    }
                                                                    print(
                                                                        ' polylineCoordinates ${polylineCoordinates.length}');
                                                                  }
                                                                  // else if (j ==
                                                                  //     _markers.length -
                                                                  //         1) {
                                                                  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
                                                                  //       googleAPIKey,
                                                                  //       PointLatLng(
                                                                  //           listlatitudeLocation[j -
                                                                  //               1],
                                                                  //           listlongitudeLocation[j -
                                                                  //               1]),
                                                                  //       PointLatLng(
                                                                  //           44.85552543453359,
                                                                  //           -0.5484378447808893));
                                                                  //   print(
                                                                  //       'Result Status  ${result.status}');
                                                                  //   if (result
                                                                  //           .status ==
                                                                  //       'OK') {
                                                                  //     result
                                                                  //         .points
                                                                  //         .forEach((PointLatLng
                                                                  //             point) {
                                                                  //       polylineCoordinates.add(LatLng(
                                                                  //           point.latitude,
                                                                  //           point.longitude));
                                                                  //     });
                                                                  //     _polylines
                                                                  //         .add(
                                                                  //             Polyline(
                                                                  //       polylineId:
                                                                  //           PolylineId('Polyline_Etape ${j + 1}'),
                                                                  //       visible:
                                                                  //           true,
                                                                  //       width:
                                                                  //           5,
                                                                  //       color: Colors
                                                                  //           .green,
                                                                  //       points:
                                                                  //           polylineCoordinates,
                                                                  //     ));
                                                                  //   }
                                                                  //   print(
                                                                  //       ' polylineCoordinates ${polylineCoordinates.length}');
                                                                  // } else {
                                                                  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
                                                                  //       googleAPIKey,
                                                                  //       PointLatLng(
                                                                  //           listlatitudeLocation[
                                                                  //               j],
                                                                  //           listlongitudeLocation[
                                                                  //               j]),
                                                                  //       PointLatLng(
                                                                  //           listlatitudeLocation[j -
                                                                  //               1],
                                                                  //           listlongitudeLocation[j -
                                                                  //               1]));
                                                                  //   print(
                                                                  //       'Result Status  ${result.status}');
                                                                  //   if (result
                                                                  //           .status ==
                                                                  //       'OK') {
                                                                  //     result
                                                                  //         .points
                                                                  //         .forEach((PointLatLng
                                                                  //             point) {
                                                                  //       polylineCoordinates.add(LatLng(
                                                                  //           point.latitude,
                                                                  //           point.longitude));
                                                                  //     });
                                                                  //     _polylines
                                                                  //         .add(
                                                                  //             Polyline(
                                                                  //       polylineId:
                                                                  //           PolylineId('Polyline_Etape ${j + 1}'),
                                                                  //       visible:
                                                                  //           true,
                                                                  //       width:
                                                                  //           5,
                                                                  //       color: Colors
                                                                  //           .yellow,
                                                                  //       points:
                                                                  //           polylineCoordinates,
                                                                  //     ));
                                                                  //   }
                                                                  // }
                                                                  print(
                                                                      ' polylineCoordinates ${polylineCoordinates.length}');
                                                                }
                                                                print(
                                                                    '_polylines ${_polylines.length} : $_polylines');

                                                                return 'Done';
                                                              },
                                                            ), // a previously-obtained Future<String> or null
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        String>
                                                                    snapshot) {
                                                              List<Widget>
                                                                  children;
                                                              if (snapshot
                                                                  .hasData) {
                                                                children =
                                                                    <Widget>[
                                                                  Stack(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              500,
                                                                          width:
                                                                              380,
                                                                          color:
                                                                              Color(graphique.color['default_red']),
                                                                          child:
                                                                              GoogleMap(
                                                                            polylines:
                                                                                _polylines,
                                                                            myLocationButtonEnabled:
                                                                                true,
                                                                            zoomControlsEnabled:
                                                                                true,
                                                                            initialCameraPosition:
                                                                                _initialCameraPosition,
                                                                            markers:
                                                                                _markers,
                                                                            onMapCreated:
                                                                                (GoogleMapController controller) {
                                                                              _googleMapController = controller;
                                                                            },
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ];
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                children =
                                                                    <Widget>[
                                                                  const Icon(
                                                                    Icons
                                                                        .error_outline,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 60,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            16),
                                                                    child: Text(
                                                                        'Error: ${snapshot.error}'),
                                                                  )
                                                                ];
                                                              } else {
                                                                children =
                                                                    const <
                                                                        Widget>[
                                                                  SizedBox(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                    width: 60,
                                                                    height: 60,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                16),
                                                                    child: Text(
                                                                        'Awaiting result...'),
                                                                  )
                                                                ];
                                                              }
                                                              return Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children:
                                                                    children,
                                                              );
                                                            },
                                                          ),
                                                        ),
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
                    color: Color(graphique.color['default_red']),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.print,
                          size: 12,
                          color: Color(graphique.color['default_black']),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Imprimer',
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
                          ),
                        ),
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
                    color: Color(graphique.color['default_red']),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.cropAlt,
                          size: 12,
                          color: Color(graphique.color['default_black']),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Vue Compacte',
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
                          ),
                        ),
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
                    color: Color(graphique.color['default_red']),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.userClock,
                          size: 12,
                          color: Color(graphique.color['default_black']),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Vue Collecteur',
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
