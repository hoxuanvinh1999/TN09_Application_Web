// import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/math_function/check_date.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_time_text.dart';
import 'package:tn09_app_web_demo/pages/menu3/planning_weekly_page.dart';
import 'package:tn09_app_web_demo/pages/widget/button_widget.dart';
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class CreateTourneePage extends StatefulWidget {
  @override
  _CreateTourneePageState createState() => _CreateTourneePageState();
}

class _CreateTourneePageState extends State<CreateTourneePage> {
  final _createTourneeKeyForm = GlobalKey<FormState>();
  String choiceIdCollecteur = 'null'; //for get idCollecteur
  String choiceIdVehicule = 'null'; //for get idVehicule
  String choiceIdPartenaire = 'null'; //for get IdPartenaire
  String choiceIdAdresse = 'null'; //for get IdAdresse
  String choiceIdFrequence = 'null'; // for get IdFrequence
  // String choiceNomPartenaire = 'None'; //for get NomPartenaire
  // String choiceNomPartenaireAdresse = 'None'; //for get NomPartenaireAdresse
  // For save Partenaire information
  List<String> list_choiceIdPartenaire = [];
  List<String> list_choiceNomPartenaire = [];
  // For save Adresse Information
  List<String> list_choiceIdAdresse = [];
  List<String> list_choiceNomPartenaireAdresse = [];
  List<String> list_latitudeAdresse = [];
  List<String> list_longitudeAdresse = [];
  List<String> list_ligne1Adresse = [];
  // For save Frequence Information
  List<String> list_choiceIdFrequence = [];
  List<String> list_startFrequence = [];
  List<String> list_endFrequence = [];
  List<String> list_tarifFrequence = [];
  // These two lists is for calculation of the Duration
  List<DateTime> list_dateMaximaleFrequence = [];
  List<DateTime> list_dateMinimaleFrequence = [];

  //For collecteur
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  //For Vehicule
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  // For Frequence
  CollectionReference _frequence =
      FirebaseFirestore.instance.collection("Frequence");
  // For select day
  String _jourPlanning = '';
  // DateTime now
  DateTime date = DateTime.now();
  // For calculation of the Duration
  String left_limit = '';
  String right_limit = '';

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 25),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  // For Select Time
  TimeOfDay timeStart = TimeOfDay.now();
  Future pickTime(
      {required BuildContext context, required TimeOfDay time}) async {
    final newTime = await showTimePicker(context: context, initialTime: time);

    if (newTime == null) {
      return;
    }
    setState(() => timeStart = newTime);
  }

  //For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  //For Adresse
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
  // for count
  int _count = 0;
  // For Tournee
  CollectionReference _tournee =
      FirebaseFirestore.instance.collection("Tournee");
  bool confirm = true;
  Color confirm_color = Color(graphique.color['default_blue']);
  String newIdTournee = '';
  // For Step
  CollectionReference _etape = FirebaseFirestore.instance.collection("Etape");
  List<String> list_IdEtape = [];
  List<bool> list_Etape_confirm = [];
  List<Color> list_color_etape = [];
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
    // Fow width of table
    double page_width =
        MediaQuery.of(context).size.width * 0.6; // For width of table
    double column1_width = MediaQuery.of(context).size.width * 0.45;
    double column2_width = MediaQuery.of(context).size.width * 0.45;
    // For the list view
    List<Widget> list_step =
        List.generate(_count, (int i) => addStepWidget(element: i));
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
                          ..onTap = () async {
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
                      text: graphique.languagefr['create_tournee_page']
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
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),
                width: column1_width,
                height: 1000,
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
                        SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.truck,
                          size: 17,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          graphique.languagefr['create_tournee_page']
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
                          graphique.languagefr['create_tournee_page']
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
                    height: 400,
                    width: column1_width * 0.8,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: confirm_color,
                      border: Border.all(
                        width: 1,
                        color: Color(graphique.color['default_black']),
                      ),
                    ),
                    child: Form(
                      key: _createTourneeKeyForm,
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
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.user,
                                  size: 15,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr['create_tournee_page']
                                        ['field_1_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  width: 10,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: _collecteur.snapshots(),
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
                                          if (confirm) {
                                            setState(() {
                                              choiceIdCollecteur =
                                                  changedValue!;
                                            });
                                          } else {
                                            null;
                                          }
                                        },
                                        value: choiceIdCollecteur,
                                        items: snapshot.data!.docs.map(
                                            (DocumentSnapshot
                                                document_collecteur) {
                                          Map<String, dynamic> dataCollecteur =
                                              document_collecteur.data()!
                                                  as Map<String, dynamic>;

                                          return DropdownMenuItem<String>(
                                            value:
                                                dataCollecteur['idCollecteur'],
                                            child: Text(
                                              dataCollecteur['nomCollecteur'] +
                                                  ' ' +
                                                  dataCollecteur[
                                                      'prenomCollecteur'],
                                              style: TextStyle(
                                                  color: Color(graphique
                                                      .color['main_color_2']),
                                                  fontSize: 15),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 50,
                            margin: EdgeInsets.symmetric(vertical: 10),
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr['create_tournee_page']
                                        ['field_2_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  width: 10,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: _vehicule.snapshots(),
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
                                          if (confirm) {
                                            setState(() {
                                              choiceIdVehicule = changedValue!;
                                            });
                                          } else {
                                            null;
                                          }
                                        },
                                        value: choiceIdVehicule,
                                        items: snapshot.data!.docs.map(
                                            (DocumentSnapshot
                                                document_vehicule) {
                                          Map<String, dynamic> dataVehicule =
                                              document_vehicule.data()!
                                                  as Map<String, dynamic>;

                                          return DropdownMenuItem<String>(
                                              value: dataVehicule['idVehicule'],
                                              child: Row(children: [
                                                buildVehiculeIcon(
                                                    icontype: dataVehicule[
                                                        'typeVehicule'],
                                                    iconcolor: dataVehicule[
                                                            'colorIconVehicule']
                                                        .toUpperCase(),
                                                    sizeIcon: 15.0),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  dataVehicule['nomVehicule'] +
                                                      ' ' +
                                                      dataVehicule[
                                                          'numeroImmatriculation'],
                                                  style: TextStyle(
                                                      color: Color(
                                                          graphique.color[
                                                              'main_color_2']),
                                                      fontSize: 15),
                                                ),
                                              ]));
                                        }).toList(),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
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
                                  Icons.calendar_today_rounded,
                                  size: 15,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr['create_tournee_page']
                                        ['field_3_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                Container(
                                  height: 50,
                                  width: 150,
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (confirm) {
                                          pickDate(context);
                                        } else {
                                          null;
                                        }
                                      },
                                      child: Text(
                                        getDateText(date: date),
                                        style: TextStyle(
                                            color: Color(graphique
                                                .color['default_white']),
                                            fontSize: 15),
                                      )),
                                )
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
                                  Icons.calendar_today_rounded,
                                  size: 15,
                                  color: Color(graphique.color['main_color_2']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    graphique.languagefr['create_tournee_page']
                                        ['field_4_title'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                Container(
                                  height: 50,
                                  width: 150,
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                  child: ButtonWidget(
                                    icon: FontAwesomeIcons.clock,
                                    text: getTimeText(time: timeStart),
                                    onClicked: () => pickTime(
                                        context: context, time: timeStart),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: column1_width * 3 / 4,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(graphique.color['main_color_1']),
                              border: Border.all(
                                  width: 1.0,
                                  color:
                                      Color(graphique.color['default_black'])),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: !confirm,
                                  child: Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Color(graphique
                                              .color['default_yellow']),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 20, bottom: 20),
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            confirm = true;
                                            confirm_color = Color(graphique
                                                .color['default_blue']);
                                          });
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
                                                      'create_tournee_page']
                                                  ['change_button'],
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
                                ),
                                Visibility(
                                  visible: confirm,
                                  child: Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Color(graphique
                                              .color['default_yellow']),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 20, bottom: 20),
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (choiceIdCollecteur == 'null' ||
                                              choiceIdVehicule == 'null') {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please Select Collecteur and Vehicule",
                                                gravity: ToastGravity.TOP);
                                          } else {
                                            if (newIdTournee == '') {
                                              newIdTournee =
                                                  _tournee.doc().id.toString();
                                              await _tournee
                                                  .doc(newIdTournee)
                                                  .set({
                                                'idTournee': newIdTournee,
                                                'idCollecteur':
                                                    choiceIdCollecteur,
                                                'idVehicule': choiceIdVehicule,
                                                'dateTournee':
                                                    getDateText(date: date),
                                                'startTime': getTimeText(
                                                    time: timeStart),
                                                'isCreating': 'true',
                                              });
                                            } else {
                                              await _tournee
                                                  .doc(newIdTournee)
                                                  .update({
                                                'idCollecteur':
                                                    choiceIdCollecteur,
                                                'idVehicule': choiceIdVehicule,
                                                'dateTournee':
                                                    getDateText(date: date),
                                                'startTime': getTimeText(
                                                    time: timeStart),
                                              });
                                            }
                                            setState(() {
                                              confirm = false;
                                              confirm_color = Color(graphique
                                                  .color['default_grey']);
                                            });
                                          }
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
                                                      'create_tournee_page']
                                                  ['confirm_button'],
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
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Divider(
                    thickness: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: column1_width * 0.8,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_blue']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Column(
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
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.flag,
                                size: 15,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_tournee_page']
                                      ['field_5_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                width: 10,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: _partenaire.snapshots(),
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
                                          choiceIdPartenaire = changedValue!;
                                          choiceIdAdresse = 'null';
                                        });
                                      },
                                      value: choiceIdPartenaire,
                                      items: snapshot.data!.docs.map(
                                          (DocumentSnapshot
                                              document_partenaire) {
                                        Map<String, dynamic> dataPartenaire =
                                            document_partenaire.data()!
                                                as Map<String, dynamic>;

                                        return DropdownMenuItem<String>(
                                          value: dataPartenaire['idPartenaire'],
                                          child: Text(
                                              dataPartenaire['nomPartenaire'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(graphique
                                                    .color['main_color_2']),
                                              )),
                                        );
                                      }).toList(),
                                    );
                                  }),
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
                                FontAwesomeIcons.mapMarker,
                                size: 15,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_tournee_page']
                                      ['field_6_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                width: 10,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: _adresse
                                      .where('idPartenaireAdresse',
                                          isEqualTo: choiceIdPartenaire)
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
                                          choiceIdAdresse = changedValue!;
                                          choiceIdFrequence = 'null';
                                        });
                                      },
                                      value: choiceIdAdresse,
                                      items: snapshot.data!.docs.map(
                                          (DocumentSnapshot document_adresse) {
                                        Map<String, dynamic> dataAdresse =
                                            document_adresse.data()!
                                                as Map<String, dynamic>;

                                        return DropdownMenuItem<String>(
                                          value: dataAdresse['idAdresse'],
                                          child: Text(
                                            dataAdresse['nomPartenaireAdresse'],
                                            style: TextStyle(
                                              color: Color(graphique
                                                  .color['main_color_2']),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 10, bottom: 20),
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
                                FontAwesomeIcons.flag,
                                size: 17,
                                color: Color(graphique.color['main_color_2']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  graphique.languagefr['create_tournee_page']
                                      ['field_7_title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                width: 10,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: _frequence
                                      .where('idAdresseFrequence',
                                          isEqualTo: choiceIdAdresse)
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
                                          choiceIdFrequence = changedValue!;
                                        });
                                      },
                                      value: choiceIdFrequence,
                                      items: snapshot.data!.docs.map(
                                          (DocumentSnapshot
                                              document_frequence) {
                                        Map<String, dynamic> dataFrequence =
                                            document_frequence.data()!
                                                as Map<String, dynamic>;

                                        return DropdownMenuItem<String>(
                                          value: dataFrequence['idFrequence'],
                                          child: Text(
                                            dataFrequence['jourFrequence'] +
                                                ' ' +
                                                dataFrequence[
                                                    'startFrequence'] +
                                                ' - ' +
                                                dataFrequence['endFrequence'],
                                            style: TextStyle(
                                              color: Color(graphique
                                                  .color['main_color_2']),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            late DateTime dateMinimale;
                            late DateTime dateMaximale;
                            bool min_after = false;
                            bool max_after = false;
                            bool time_start_after = false;
                            bool time_end_after = false;
                            String datelimit = '';
                            await _frequence
                                .where('idFrequence',
                                    isEqualTo: choiceIdFrequence)
                                .limit(1)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                _jourPlanning = doc['jourFrequence'];
                                DateTime dateMinimale = DateTime(
                                    int.parse(doc['dateMinimaleFrequence']
                                        .substring(6)),
                                    int.parse(doc['dateMinimaleFrequence']
                                        .substring(3, 5)),
                                    int.parse(doc['dateMinimaleFrequence']
                                        .substring(0, 2)));
                                DateTime dateMaximale = DateTime(
                                    int.parse(doc['dateMaximaleFrequence']
                                        .substring(6)),
                                    int.parse(doc['dateMaximaleFrequence']
                                        .substring(3, 5)),
                                    int.parse(doc['dateMaximaleFrequence']
                                        .substring(0, 2)));
                                min_after = dateMinimale.isAfter(date);
                                max_after = date.isAfter(dateMaximale);
                                datelimit = 'Date Limit is: ' +
                                    DateFormat('yMd')
                                        .format(dateMinimale)
                                        .toString() +
                                    ' - ' +
                                    DateFormat('yMd')
                                        .format(dateMaximale)
                                        .toString();
                                TimeOfDay startTime = TimeOfDay(
                                    hour: int.parse(
                                        doc['startFrequence'].substring(0, 2)),
                                    minute: int.parse(
                                        doc['startFrequence'].substring(3)));
                                TimeOfDay endTime = TimeOfDay(
                                    hour: int.parse(
                                        doc['endFrequence'].substring(0, 2)),
                                    minute: int.parse(
                                        doc['endFrequence'].substring(3)));
                                if (startTime.hour < timeStart.hour &&
                                    startTime.minute < timeStart.minute) {
                                  time_start_after = true;
                                }
                              });
                            });
                            print('$min_after');
                            print('$max_after');
                            print('$datelimit');
                            if (confirm) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please Confirm Collecteur, Vehicule and Date before",
                                  gravity: ToastGravity.TOP);
                            } else if (choiceIdAdresse == 'null' ||
                                choiceIdPartenaire == 'null') {
                              Fluttertoast.showToast(
                                  msg: "Please select Partenaire and Adresse",
                                  gravity: ToastGravity.TOP);
                            } else if (choiceIdFrequence == 'null') {
                              Fluttertoast.showToast(
                                  msg: "Please select a Frequence",
                                  gravity: ToastGravity.TOP);
                            } else if (checkday(check_date: date) !=
                                _jourPlanning) {
                              Fluttertoast.showToast(
                                  msg: "That Frequence is not in that day",
                                  gravity: ToastGravity.TOP);
                            } else if (min_after || max_after) {
                              Fluttertoast.showToast(
                                  msg: datelimit, gravity: ToastGravity.TOP);
                            } else if (time_start_after) {
                              Fluttertoast.showToast(
                                  msg: 'Please check your time',
                                  gravity: ToastGravity.TOP);
                            } else {
                              await _frequence
                                  .where('idFrequence',
                                      isEqualTo: choiceIdFrequence)
                                  .limit(1)
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc) {
                                  list_choiceIdFrequence
                                      .add(doc['idFrequence']);
                                  list_startFrequence
                                      .add(doc['startFrequence']);
                                  list_endFrequence.add(doc['endFrequence']);
                                  list_tarifFrequence
                                      .add(doc['tarifFrequence']);
                                  list_dateMaximaleFrequence.add(DateTime(
                                      int.parse(doc['dateMaximaleFrequence']
                                          .substring(6)),
                                      int.parse(doc['dateMaximaleFrequence']
                                          .substring(3, 5)),
                                      int.parse(doc['dateMaximaleFrequence']
                                          .substring(0, 2))));
                                  list_dateMinimaleFrequence.add(DateTime(
                                      int.parse(doc['dateMinimaleFrequence']
                                          .substring(6)),
                                      int.parse(doc['dateMinimaleFrequence']
                                          .substring(3, 5)),
                                      int.parse(doc['dateMinimaleFrequence']
                                          .substring(0, 2))));
                                });
                              });

                              await _partenaire
                                  .where('idPartenaire',
                                      isEqualTo: choiceIdPartenaire)
                                  .limit(1)
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc) {
                                  list_choiceIdPartenaire
                                      .add(doc['idPartenaire']);
                                  list_choiceNomPartenaire
                                      .add(doc['nomPartenaire']);
                                });
                              });
                              await _adresse
                                  .where('idAdresse',
                                      isEqualTo: choiceIdAdresse)
                                  .limit(1)
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc) {
                                  list_choiceIdAdresse.add(doc['idAdresse']);
                                  list_choiceNomPartenaireAdresse
                                      .add(doc['nomPartenaireAdresse']);
                                  list_latitudeAdresse
                                      .add(doc['latitudeAdresse']);
                                  list_longitudeAdresse
                                      .add(doc['longitudeAdresse']);
                                  list_ligne1Adresse.add(doc['ligne1Adresse']);
                                });
                              });
                              list_Etape_confirm.add(false);
                              list_IdEtape.add(_etape.doc().id);
                              list_color_etape
                                  .add(Color(graphique.color['default_blue']));
                              setState(() {
                                _count++;
                              });
                            }
                          },
                          child: Icon(Icons.add,
                              color: Color(graphique.color['default_yellow'])),
                        ),
                      ],
                    ),
                  ),
                ])),
            Container(
              margin: const EdgeInsets.only(
                right: 20,
                top: 20,
                bottom: 20,
              ),
              width: column2_width,
              height: 1200,
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
                        FontAwesomeIcons.listUl,
                        size: 17,
                        color: Color(graphique.color['main_color_2']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        graphique.languagefr['create_tournee_page']['step_form']
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
                        graphique.languagefr['create_tournee_page']['step_form']
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
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 800,
                    child: SingleChildScrollView(
                      child: Column(
                        children: list_step,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.centerLeft,
                  width: column2_width * 0.95,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['default_blue']),
                    border: Border.all(
                      width: 1.0,
                      color: Color(graphique.color['default_black']),
                    ),
                  ),
                  child: Text(
                    graphique.languagefr['create_tournee_page']
                            ['duration_line'] +
                        ':  ' +
                        left_limit +
                        ' - ' +
                        right_limit,
                    style: TextStyle(
                        color: Color(graphique.color['default_black']),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Container(
                  width: column2_width * 0.95,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['default_red']),
                    border: Border.all(
                      width: 1.0,
                      color: Color(graphique.color['default_black']),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (newIdTournee != '') {
                                _tournee
                                    .doc(newIdTournee)
                                    .delete()
                                    .then((value) {
                                  Fluttertoast.showToast(
                                      msg: 'Stop Creating Tournee',
                                      gravity: ToastGravity.TOP);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlanningWeeklyPage(
                                                thisDay: DateTime.now(),
                                              )));
                                }).catchError((error) =>
                                        print("Failed to add user: $error"));
                              } else {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlanningWeeklyPage(
                                              thisDay: DateTime.now(),
                                            )));
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
                                  graphique.languagefr['create_tournee_page']
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
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          width: 200,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (_count == 0) {
                                Fluttertoast.showToast(
                                    msg: "Please add a Etape",
                                    gravity: ToastGravity.TOP);
                              } else if (confirm) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please select and confirm Collecteur and Vehicule",
                                    gravity: ToastGravity.TOP);
                              } else {
                                bool all_etape_not_confirm = true;
                                int check_all_etape = 0;
                                while (all_etape_not_confirm &&
                                    check_all_etape < _count) {
                                  if (list_Etape_confirm[check_all_etape] ==
                                      false) {
                                    check_all_etape++;
                                  } else {
                                    all_etape_not_confirm = false;
                                  }
                                }
                                if (all_etape_not_confirm) {
                                  Fluttertoast.showToast(
                                      msg: "You did not confirm any Etape",
                                      gravity: ToastGravity.TOP);
                                } else {
                                  DateTime date_left_limit = DateTime(
                                      int.parse(left_limit.substring(6)),
                                      int.parse(left_limit.substring(3, 5)),
                                      int.parse(left_limit.substring(0, 2)));
                                  DateTime date_right_limit = DateTime(
                                      int.parse(right_limit.substring(6)),
                                      int.parse(right_limit.substring(3, 5)),
                                      int.parse(right_limit.substring(0, 2)));
                                  int number_of_planning = 1;
                                  DateTime date_first_Planning = date;
                                  DateTime date_Planning =
                                      date.add(Duration(days: 7));
                                  while (date_Planning
                                      .isBefore(date_right_limit)) {
                                    number_of_planning++;
                                    date_Planning =
                                        date_Planning.add(Duration(days: 7));
                                  }
                                  if (getDateText(date: date_Planning) ==
                                      getDateText(date: date_right_limit)) {
                                    number_of_planning++;
                                  }
                                  print('$number_of_planning');
                                  if (number_of_planning == 1) {
                                    bool found_start = false;
                                    int numberofEtape = 0;
                                    int before = 0;
                                    int end = 0;
                                    String idEtapeStart = '';
                                    int orderEtape = 1;
                                    for (int i = 0; i < _count; i++) {
                                      if (!found_start) {
                                        if (list_Etape_confirm[i]) {
                                          found_start = true;
                                          idEtapeStart = list_IdEtape[i];
                                          numberofEtape++;
                                          await _tournee
                                              .doc(newIdTournee)
                                              .update({
                                            'idEtapeStart': idEtapeStart,
                                          });
                                          before = i;
                                          await _etape
                                              .doc(list_IdEtape[i])
                                              .set({
                                            'idEtape': list_IdEtape[i],
                                            'idTourneeEtape': newIdTournee,
                                            'idEtapeBefore': 'null',
                                            'orderEtape': orderEtape.toString(),
                                            'idPartenaireEtape':
                                                list_choiceIdPartenaire[i],
                                            'idVehiculeEtape': choiceIdVehicule,
                                            'idCollecteurEtape':
                                                choiceIdCollecteur,
                                            'idAdresseEtape':
                                                list_choiceIdAdresse[i],
                                            'nomAdresseEtape':
                                                list_choiceNomPartenaireAdresse[
                                                    i],
                                            'latitudeEtape':
                                                list_latitudeAdresse[i],
                                            'longitude':
                                                list_longitudeAdresse[i],
                                            'ligne1Adresse':
                                                list_ligne1Adresse[i],
                                            'idFrequenceEtape':
                                                list_choiceIdFrequence[i],
                                            'startFrequenceEtape':
                                                list_startFrequence[i],
                                            'endFrequenceEtape':
                                                list_endFrequence[i],
                                            'tarifFrequenceEtape':
                                                list_tarifFrequence[i],
                                            'status': 'wait',
                                            'jourEtape':
                                                getDateText(date: date),
                                          });
                                          orderEtape++;
                                          end = i;
                                        }
                                      } else {
                                        if (list_Etape_confirm[i]) {
                                          numberofEtape++;
                                          await _etape
                                              .doc(list_IdEtape[before])
                                              .update({
                                            'idEtapeAfter': list_IdEtape[i],
                                          });
                                          await _etape
                                              .doc(list_IdEtape[i])
                                              .set({
                                            'idEtape': list_IdEtape[i],
                                            'idTourneeEtape': newIdTournee,
                                            'idEtapeBefore':
                                                list_IdEtape[before],
                                            'idPartenaireEtape':
                                                list_choiceIdPartenaire[i],
                                            'orderEtape': orderEtape.toString(),
                                            'idVehiculeEtape': choiceIdVehicule,
                                            'idCollecteurEtape':
                                                choiceIdCollecteur,
                                            'idAdresseEtape':
                                                list_choiceIdAdresse[i],
                                            'nomAdresseEtape':
                                                list_choiceNomPartenaireAdresse[
                                                    i],
                                            'latitudeEtape':
                                                list_latitudeAdresse[i],
                                            'longitude':
                                                list_longitudeAdresse[i],
                                            'ligne1Adresse':
                                                list_ligne1Adresse[i],
                                            'idFrequenceEtape':
                                                list_choiceIdFrequence[i],
                                            'startFrequenceEtape':
                                                list_startFrequence[i],
                                            'endFrequenceEtape':
                                                list_endFrequence[i],
                                            'tarifFrequenceEtape':
                                                list_tarifFrequence[i],
                                            'status': 'wait',
                                            'jourEtape':
                                                getDateText(date: date),
                                          });
                                          orderEtape++;
                                          before = i;
                                          end = i;
                                        }
                                      }
                                    }
                                    await _etape.doc(list_IdEtape[end]).update({
                                      'idEtapeAfter': 'null',
                                    });
                                    String colorTournee = '';
                                    await _vehicule
                                        .where('idVehicule',
                                            isEqualTo: choiceIdVehicule)
                                        .limit(1)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        colorTournee = doc['colorIconVehicule'];
                                      });
                                    });
                                    await _tournee.doc(newIdTournee).update({
                                      'nombredeEtape': numberofEtape.toString(),
                                      'isCreating': false.toString(),
                                      'jourTournee': _jourPlanning,
                                      'status': 'wait',
                                      'colorTournee': colorTournee,
                                    }).then((value) {
                                      Fluttertoast.showToast(
                                          msg: "Finish Creating Tournee",
                                          gravity: ToastGravity.TOP);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlanningWeeklyPage(
                                                    thisDay: date,
                                                  )));
                                    }).catchError((error) =>
                                        print("Failed to add user: $error"));
                                  } else {
                                    // await _tournee.doc(newIdTournee).set({
                                    //   'idTournee': newIdTournee,
                                    //   'idCollecteur': choiceIdCollecteur,
                                    //   'idVehicule': choiceIdVehicule,
                                    //   'dateTournee': getDateText(date: date),
                                    //   'startTime': getTimeText(time: timeStart),
                                    //   'isCreating': 'true',
                                    // });
                                    print(
                                        'Start creating $number_of_planning tournee');
                                    for (int j = 0;
                                        j < number_of_planning;
                                        j++) {
                                      _tournee
                                          .where('idTournee',
                                              isEqualTo: newIdTournee)
                                          .limit(1)
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs
                                            .forEach((document_tournee) async {
                                          Map<String, dynamic> data_Tournee =
                                              document_tournee.data()!
                                                  as Map<String, dynamic>;
                                          String newIdTournee_now =
                                              _tournee.doc().id.toString();
                                          data_Tournee['idTournee'] =
                                              newIdTournee_now;
                                          data_Tournee['dateTournee'] =
                                              getDateText(
                                                  date: date.add(
                                                      Duration(days: 7 * j)));

                                          bool found_start = false;
                                          int numberofEtape = 0;
                                          int before = 0;
                                          int end = 0;
                                          String idEtapeStart = '';
                                          int orderEtape = 1;
                                          List<String> list_idEtape_now = [];
                                          for (int i = 0; i < _count; i++) {
                                            list_idEtape_now.add(
                                                _etape.doc().id.toString());
                                          }
                                          for (int i = 0; i < _count; i++) {
                                            if (!found_start) {
                                              if (list_Etape_confirm[i]) {
                                                found_start = true;
                                                idEtapeStart =
                                                    list_idEtape_now[i];
                                                numberofEtape++;
                                                data_Tournee.putIfAbsent(
                                                    'idEtapeStart',
                                                    () => idEtapeStart);
                                                before = i;
                                                await _etape
                                                    .doc(list_idEtape_now[i])
                                                    .set({
                                                  'idEtape':
                                                      list_idEtape_now[i],
                                                  'idTourneeEtape':
                                                      newIdTournee_now,
                                                  'idEtapeBefore': 'null',
                                                  'orderEtape':
                                                      orderEtape.toString(),
                                                  'idPartenaireEtape':
                                                      list_choiceIdPartenaire[
                                                          i],
                                                  'idVehiculeEtape':
                                                      choiceIdVehicule,
                                                  'idCollecteurEtape':
                                                      choiceIdCollecteur,
                                                  'idAdresseEtape':
                                                      list_choiceIdAdresse[i],
                                                  'nomAdresseEtape':
                                                      list_choiceNomPartenaireAdresse[
                                                          i],
                                                  'latitudeEtape':
                                                      list_latitudeAdresse[i],
                                                  'longitude':
                                                      list_longitudeAdresse[i],
                                                  'ligne1Adresse':
                                                      list_ligne1Adresse[i],
                                                  'idFrequenceEtape':
                                                      list_choiceIdFrequence[i],
                                                  'startFrequenceEtape':
                                                      list_startFrequence[i],
                                                  'endFrequenceEtape':
                                                      list_endFrequence[i],
                                                  'tarifFrequenceEtape':
                                                      list_tarifFrequence[i],
                                                  'status': 'wait',
                                                  'jourEtape': getDateText(
                                                      date: date.add(Duration(
                                                          days: 7 * j))),
                                                });
                                                orderEtape++;
                                                end = i;
                                              }
                                            } else {
                                              if (list_Etape_confirm[i]) {
                                                numberofEtape++;
                                                await _etape
                                                    .doc(list_idEtape_now[
                                                        before])
                                                    .update({
                                                  'idEtapeAfter':
                                                      list_idEtape_now[i],
                                                });
                                                await _etape
                                                    .doc(list_idEtape_now[i])
                                                    .set({
                                                  'idEtape':
                                                      list_idEtape_now[i],
                                                  'idTourneeEtape':
                                                      newIdTournee_now,
                                                  'idEtapeBefore':
                                                      list_idEtape_now[before],
                                                  'idPartenaireEtape':
                                                      list_choiceIdPartenaire[
                                                          i],
                                                  'orderEtape':
                                                      orderEtape.toString(),
                                                  'idVehiculeEtape':
                                                      choiceIdVehicule,
                                                  'idCollecteurEtape':
                                                      choiceIdCollecteur,
                                                  'idAdresseEtape':
                                                      list_choiceIdAdresse[i],
                                                  'nomAdresseEtape':
                                                      list_choiceNomPartenaireAdresse[
                                                          i],
                                                  'latitudeEtape':
                                                      list_latitudeAdresse[i],
                                                  'longitude':
                                                      list_longitudeAdresse[i],
                                                  'ligne1Adresse':
                                                      list_ligne1Adresse[i],
                                                  'idFrequenceEtape':
                                                      list_choiceIdFrequence[i],
                                                  'startFrequenceEtape':
                                                      list_startFrequence[i],
                                                  'endFrequenceEtape':
                                                      list_endFrequence[i],
                                                  'tarifFrequenceEtape':
                                                      list_tarifFrequence[i],
                                                  'status': 'wait',
                                                  'jourEtape': getDateText(
                                                      date: date.add(Duration(
                                                          days: 7 * j))),
                                                });
                                                orderEtape++;
                                                before = i;
                                                end = i;
                                              }
                                            }
                                          }
                                          await _etape
                                              .doc(list_idEtape_now[end])
                                              .update({
                                            'idEtapeAfter': 'null',
                                          });
                                          String colorTournee = '';
                                          await _vehicule
                                              .where('idVehicule',
                                                  isEqualTo: choiceIdVehicule)
                                              .limit(1)
                                              .get()
                                              .then((QuerySnapshot
                                                  querySnapshot) {
                                            querySnapshot.docs.forEach((doc) {
                                              colorTournee =
                                                  doc['colorIconVehicule'];
                                            });
                                          });
                                          data_Tournee.putIfAbsent(
                                              'nombredeEtape',
                                              () => numberofEtape.toString());
                                          data_Tournee['isCreating'] =
                                              false.toString();
                                          data_Tournee.putIfAbsent(
                                              'status', () => 'wait');
                                          data_Tournee.putIfAbsent(
                                              'colorTournee',
                                              () => colorTournee);
                                          data_Tournee.putIfAbsent(
                                              'jourTournee',
                                              () => _jourPlanning);
                                          print('$data_Tournee');
                                          await _tournee
                                              .doc(newIdTournee_now)
                                              .set(data_Tournee)
                                              .then((value) {
                                            if (j == number_of_planning - 1) {
                                              print(
                                                  'j = $j and number of planning is $number_of_planning');
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Finish Creating $number_of_planning Tournee",
                                                  gravity: ToastGravity.TOP);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlanningWeeklyPage(
                                                                thisDay: date,
                                                              )));
                                            }
                                          }).catchError((error) => print(
                                                  "Failed to add user: $error"));
                                        });
                                      });
                                      print('j = $j');
                                    }
                                  }
                                }
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
                                  graphique.languagefr['create_tournee_page']
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
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          width: 180,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (_count == 0) {
                                Fluttertoast.showToast(
                                    msg: "Please add a Etape",
                                    gravity: ToastGravity.TOP);
                              } else if (confirm) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please select and confirm Collecteur and Vehicule",
                                    gravity: ToastGravity.TOP);
                              } else {
                                bool all_etape_not_confirm = true;
                                int check_all_etape = 0;
                                while (all_etape_not_confirm &&
                                    check_all_etape < _count) {
                                  if (list_Etape_confirm[check_all_etape] ==
                                      false) {
                                    check_all_etape++;
                                  } else {
                                    all_etape_not_confirm = false;
                                  }
                                }
                                if (all_etape_not_confirm) {
                                  Fluttertoast.showToast(
                                      msg: "You did not confirm any Etape",
                                      gravity: ToastGravity.TOP);
                                } else {
                                  bool found_start = false;
                                  int numberofEtape = 0;
                                  int before = 0;
                                  int end = 0;
                                  String idEtapeStart = '';
                                  int orderEtape = 1;
                                  for (int i = 0; i < _count; i++) {
                                    if (!found_start) {
                                      if (list_Etape_confirm[i]) {
                                        found_start = true;
                                        idEtapeStart = list_IdEtape[i];
                                        numberofEtape++;
                                        await _tournee
                                            .doc(newIdTournee)
                                            .update({
                                          'idEtapeStart': idEtapeStart,
                                        });
                                        before = i;
                                        await _etape.doc(list_IdEtape[i]).set({
                                          'idEtape': list_IdEtape[i],
                                          'idTourneeEtape': newIdTournee,
                                          'idEtapeBefore': 'null',
                                          'orderEtape': orderEtape.toString(),
                                          'idPartenaireEtape':
                                              list_choiceIdPartenaire[i],
                                          'idVehiculeEtape': choiceIdVehicule,
                                          'idCollecteurEtape':
                                              choiceIdCollecteur,
                                          'idAdresseEtape':
                                              list_choiceIdAdresse[i],
                                          'nomAdresseEtape':
                                              list_choiceNomPartenaireAdresse[
                                                  i],
                                          'latitudeEtape':
                                              list_latitudeAdresse[i],
                                          'longitude': list_longitudeAdresse[i],
                                          'ligne1Adresse':
                                              list_ligne1Adresse[i],
                                          'idFrequenceEtape':
                                              list_choiceIdFrequence[i],
                                          'startFrequenceEtape':
                                              list_startFrequence[i],
                                          'endFrequenceEtape':
                                              list_endFrequence[i],
                                          'tarifFrequenceEtape':
                                              list_tarifFrequence[i],
                                          'status': 'wait',
                                          'jourEtape': getDateText(date: date),
                                        });
                                        orderEtape++;
                                        end = i;
                                      }
                                    } else {
                                      if (list_Etape_confirm[i]) {
                                        numberofEtape++;
                                        await _etape
                                            .doc(list_IdEtape[before])
                                            .update({
                                          'idEtapeAfter': list_IdEtape[i],
                                        });
                                        await _etape.doc(list_IdEtape[i]).set({
                                          'idEtape': list_IdEtape[i],
                                          'idTourneeEtape': newIdTournee,
                                          'idEtapeBefore': list_IdEtape[before],
                                          'idPartenaireEtape':
                                              list_choiceIdPartenaire[i],
                                          'orderEtape': orderEtape.toString(),
                                          'idVehiculeEtape': choiceIdVehicule,
                                          'idCollecteurEtape':
                                              choiceIdCollecteur,
                                          'idAdresseEtape':
                                              list_choiceIdAdresse[i],
                                          'nomAdresseEtape':
                                              list_choiceNomPartenaireAdresse[
                                                  i],
                                          'latitudeEtape':
                                              list_latitudeAdresse[i],
                                          'longitude': list_longitudeAdresse[i],
                                          'ligne1Adresse':
                                              list_ligne1Adresse[i],
                                          'idFrequenceEtape':
                                              list_choiceIdFrequence[i],
                                          'startFrequenceEtape':
                                              list_startFrequence[i],
                                          'endFrequenceEtape':
                                              list_endFrequence[i],
                                          'tarifFrequenceEtape':
                                              list_tarifFrequence[i],
                                          'status': 'wait',
                                          'jourEtape': getDateText(date: date),
                                        });
                                        orderEtape++;
                                        before = i;
                                        end = i;
                                      }
                                    }
                                  }
                                  await _etape.doc(list_IdEtape[end]).update({
                                    'idEtapeAfter': 'null',
                                  });
                                  String colorTournee = '';
                                  await _vehicule
                                      .where('idVehicule',
                                          isEqualTo: choiceIdVehicule)
                                      .limit(1)
                                      .get()
                                      .then((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      colorTournee = doc['colorIconVehicule'];
                                    });
                                  });
                                  await _tournee.doc(newIdTournee).update({
                                    'nombredeEtape': numberofEtape.toString(),
                                    'isCreating': false.toString(),
                                    'jourTournee': _jourPlanning,
                                    'status': 'wait',
                                    'colorTournee': colorTournee,
                                  }).then((value) {
                                    Fluttertoast.showToast(
                                        msg: "Finish Creating Tournee",
                                        gravity: ToastGravity.TOP);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PlanningWeeklyPage(
                                                  thisDay: date,
                                                )));
                                  }).catchError((error) =>
                                      print("Failed to add user: $error"));
                                }
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
                                  graphique.languagefr['create_tournee_page']
                                      ['button_3'],
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
              ]),
            ),
          ]),
    ])));
  }

  addStepWidget({required int element}) {
    double step_width = MediaQuery.of(context).size.width * 0.45 * 0.9;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 320,
      width: step_width,
      decoration: BoxDecoration(
        color: list_color_etape[element],
        border: Border.all(
            width: 1.0, color: Color(graphique.color['default_black'])),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                graphique.languagefr['create_tournee_page']['step_form']
                        ['field_1_title'] +
                    ': ' +
                    (element + 1).toString(),
                style: TextStyle(
                  color: Color(graphique.color['default_black']),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                graphique.languagefr['create_tournee_page']['step_form']
                        ['field_2_title'] +
                    ': ' +
                    list_choiceNomPartenaire[element],
                style: TextStyle(
                  color: Color(graphique.color['default_black']),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                graphique.languagefr['create_tournee_page']['step_form']
                        ['field_3_title'] +
                    ': ' +
                    list_choiceNomPartenaireAdresse[element],
                style: TextStyle(
                  color: Color(graphique.color['default_black']),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                graphique.languagefr['create_tournee_page']['step_form']
                        ['field_4_title'] +
                    ': ' +
                    list_ligne1Adresse[element],
                style: TextStyle(
                  color: Color(graphique.color['default_black']),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                graphique.languagefr['create_tournee_page']['step_form']
                        ['field_5_title'] +
                    ': ' +
                    list_startFrequence[element] +
                    ' - ' +
                    list_endFrequence[element],
                style: TextStyle(
                  color: Color(graphique.color['default_black']),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                graphique.languagefr['create_tournee_page']['step_form']
                        ['field_6_title'] +
                    ': ' +
                    list_tarifFrequence[element],
                style: TextStyle(
                  color: Color(graphique.color['default_black']),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: step_width * 0.9,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(graphique.color['main_color_1']),
                  border: Border.all(
                      width: 1.0,
                      color: Color(graphique.color['default_black'])),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: list_Etape_confirm[element],
                      child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              int number_of_etape_added = list_Etape_confirm
                                  .map((element) => element == true ? 1 : 0)
                                  .reduce((value, element) => value + element);
                              print('$number_of_etape_added');
                              if (number_of_etape_added == 1) {
                                setState(() {
                                  left_limit = '';
                                  right_limit = '';
                                  list_Etape_confirm[element] = false;
                                  list_color_etape[element] =
                                      Color(graphique.color['default_blue']);
                                });
                              } else {
                                setState(() {
                                  list_Etape_confirm[element] = false;
                                  list_color_etape[element] =
                                      Color(graphique.color['default_blue']);
                                });
                                bool find_first_true_element = false;
                                late DateTime newMinFrequence;
                                late DateTime newMaxFrequence;
                                for (int i = 0;
                                    i < list_Etape_confirm.length;
                                    i++) {
                                  if (list_Etape_confirm[i] == true) {
                                    if (find_first_true_element) {
                                      newMinFrequence =
                                          newMinFrequence.isBefore(
                                                  list_dateMinimaleFrequence[i])
                                              ? list_dateMinimaleFrequence[i]
                                              : newMinFrequence;
                                      newMaxFrequence = newMaxFrequence.isAfter(
                                              list_dateMaximaleFrequence[i])
                                          ? list_dateMaximaleFrequence[i]
                                          : newMaxFrequence;
                                    } else {
                                      newMinFrequence =
                                          list_dateMinimaleFrequence[i];
                                      newMaxFrequence =
                                          list_dateMaximaleFrequence[i];
                                      find_first_true_element = true;
                                    }
                                  }
                                }
                                setState(() {
                                  left_limit =
                                      getDateText(date: newMinFrequence);
                                  right_limit =
                                      getDateText(date: newMaxFrequence);
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
                                  graphique.languagefr['create_tournee_page']
                                      ['step_form']['remove_button'],
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
                    ),
                    Visibility(
                      visible: !list_Etape_confirm[element],
                      child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (left_limit == '' && right_limit == '') {
                                setState(() {
                                  left_limit = getDateText(
                                      date:
                                          list_dateMinimaleFrequence[element]);
                                  right_limit = getDateText(
                                      date:
                                          list_dateMaximaleFrequence[element]);
                                  list_Etape_confirm[element] = true;
                                  list_color_etape[element] =
                                      Color(graphique.color['default_grey']);
                                });
                              } else {
                                DateTime date_left_limit = DateTime(
                                    int.parse(left_limit.substring(6)),
                                    int.parse(left_limit.substring(3, 5)),
                                    int.parse(left_limit.substring(0, 2)));
                                DateTime date_right_limit = DateTime(
                                    int.parse(right_limit.substring(6)),
                                    int.parse(right_limit.substring(3, 5)),
                                    int.parse(right_limit.substring(0, 2)));
                                setState(() {
                                  left_limit = date_left_limit.isBefore(
                                          list_dateMinimaleFrequence[element])
                                      ? getDateText(
                                          date: list_dateMinimaleFrequence[
                                              element])
                                      : left_limit;

                                  right_limit = date_right_limit.isAfter(
                                          list_dateMaximaleFrequence[element])
                                      ? getDateText(
                                          date: list_dateMaximaleFrequence[
                                              element])
                                      : right_limit;
                                  list_Etape_confirm[element] = true;
                                  list_color_etape[element] =
                                      Color(graphique.color['default_grey']);
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
                                  graphique.languagefr['create_tournee_page']
                                      ['step_form']['add_button'],
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
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
