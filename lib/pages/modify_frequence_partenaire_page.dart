import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_time_text.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/view_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/widget/button_widget.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';

class ModifyFrequencePartenairePage extends StatefulWidget {
  Map partenaire;
  Map dataFrequence;
  ModifyFrequencePartenairePage({
    Key? key,
    required this.partenaire,
    required this.dataFrequence,
  }) : super(key: key);
  @override
  _ModifyFrequencePartenairePageState createState() =>
      _ModifyFrequencePartenairePageState();
}

class _ModifyFrequencePartenairePageState
    extends State<ModifyFrequencePartenairePage> {
  //forPartenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  String choiceVehicule = 'None';
  String idVehiculeFrequence = 'null';
  String _jour = 'Lundi';
  TimeOfDay timeStart = TimeOfDay.now();
  TimeOfDay timeEnd = TimeOfDay.now();
  TextEditingController _frequenceTextController = TextEditingController();
  TextEditingController _frequenceTarifController = TextEditingController();
  DateTime dateMinimale = DateTime.now();
  DateTime dateMaximale = DateTime.now();
  // Init Data
  void initState() {
    setState(() {
      choiceVehicule = 'None';
      idVehiculeFrequence = widget.dataFrequence['idVehiculeFrequence'];
      _jour = widget.dataFrequence['jourFrequence'];
      timeStart = TimeOfDay(
          hour:
              int.parse(widget.dataFrequence['startFrequence'].substring(0, 2)),
          minute:
              int.parse(widget.dataFrequence['startFrequence'].substring(3)));
      timeEnd = TimeOfDay(
          hour: int.parse(widget.dataFrequence['endFrequence'].substring(0, 2)),
          minute: int.parse(widget.dataFrequence['endFrequence'].substring(3)));
      _frequenceTextController =
          TextEditingController(text: widget.dataFrequence['frequence']);
      _frequenceTarifController =
          TextEditingController(text: widget.dataFrequence['tarifFrequence']);
      dateMinimale = DateTime(
          int.parse(widget.dataFrequence['dateMinimaleFrequence'].substring(6)),
          int.parse(
              widget.dataFrequence['dateMinimaleFrequence'].substring(3, 5)),
          int.parse(
              widget.dataFrequence['dateMinimaleFrequence'].substring(0, 2)));
      dateMaximale = DateTime(
          int.parse(widget.dataFrequence['dateMaximaleFrequence'].substring(6)),
          int.parse(
              widget.dataFrequence['dateMaximaleFrequence'].substring(3, 5)),
          int.parse(
              widget.dataFrequence['dateMaximaleFrequence'].substring(0, 2)));
    });
    super.initState();
  }

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

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
  double toMinute(TimeOfDay myTime) => myTime.hour * 60.0 + myTime.minute;

  Future pickDateMinimale(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateMinimale,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => dateMinimale = newDate);
  }

  Future pickDateMaximale(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateMaximale,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => dateMaximale = newDate);
  }

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

  @override
  Widget build(BuildContext context) {
    // For width of table
    double page_width = MediaQuery.of(context).size.width * 0.6;
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
                                          builder: (context) =>
                                              PartenairePage()));
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
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewPartenairePage(
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
                            text: graphique.languagefr[
                                'modify_frequence_partenaire_page']['nom_page'],
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
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
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
                            graphique.languagefr[
                                        'modify_frequence_partenaire_page']
                                    ['form_title'] +
                                ': ' +
                                widget.dataFrequence['nomAdresseFrequence'],
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
                                        'modify_frequence_partenaire_page']
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
                          height: 700,
                          decoration: BoxDecoration(
                            color:
                                Color(graphique.color['special_bureautique_2']),
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
                                            'modify_frequence_partenaire_page']
                                        ['field_1_title'] +
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
                                            'modify_frequence_partenaire_page']
                                        ['field_2_title'] +
                                    ': ' +
                                    // '${timeEnd.hour}:${timeEnd.minute}'
                                    getTimeText(time: timeEnd),
                                onClicked: () => pickTimeEnd(
                                    context: context, time: timeEnd),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ButtonWidget(
                                icon: Icons.calendar_today,
                                text: graphique.languagefr[
                                            'modify_frequence_partenaire_page']
                                        ['field_3_title'] +
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
                                            'modify_frequence_partenaire_page']
                                        ['field_4_title'] +
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
                                  controller: _frequenceTextController,
                                  decoration: InputDecoration(
                                    labelText: graphique.languagefr[
                                            'modify_frequence_partenaire_page']
                                        ['field_5_title'],
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
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
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
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  controller: _frequenceTarifController,
                                  decoration: InputDecoration(
                                    labelText: graphique.languagefr[
                                            'modify_frequence_partenaire_page']
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
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
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
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.calendar,
                                      size: 15,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        graphique.languagefr[
                                                'modify_frequence_partenaire_page']
                                            ['field_7_title'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(graphique
                                                .color['main_color_2']),
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
                                    color:
                                        Color(graphique.color['main_color_1']),
                                  ),
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.truck,
                                      size: 15,
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        graphique.languagefr[
                                                'modify_frequence_partenaire_page']
                                            ['field_8_title'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(graphique
                                                .color['main_color_2']),
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 10),
                                    StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("Vehicule")
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
                                                idVehiculeFrequence =
                                                    changedValue!;
                                              });
                                            },
                                            value: idVehiculeFrequence,
                                            items: snapshot.data!.docs.map(
                                                (DocumentSnapshot document) {
                                              Map<String, dynamic> vehicule =
                                                  document.data()!
                                                      as Map<String, dynamic>;

                                              return DropdownMenuItem<String>(
                                                  value: vehicule['idVehicule'],
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
                                                        vehicule[
                                                                'nomVehicule'] +
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
                                      color: Color(
                                          graphique.color['default_yellow']),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      // print(getTimeText(time: timeStart));
                                      // print(getTimeText(time: timeEnd));
                                      // print('$choiceVehicule');
                                      // print('$_jour');
                                      // print(
                                      //     '${DateFormat('yMd').format(dateMaximale).toString()}');
                                      // print(
                                      //     '${DateFormat('yMd').format(dateMinimale).toString()}');
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewPartenairePage(
                                                    partenaire:
                                                        widget.partenaire,
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
                                                  'modify_frequence_partenaire_page']
                                              ['button_2'],
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
                              Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          graphique.color['default_yellow']),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_frequenceTextController
                                          .text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Please Input a frequence",
                                            gravity: ToastGravity.TOP);
                                      } else if (!_frequenceTextController
                                              .text.isEmpty &&
                                          int.tryParse(_frequenceTextController
                                                  .text) ==
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
                                          int.tryParse(_frequenceTarifController
                                                  .text) ==
                                              null) {
                                      } else if (toDouble(timeStart) >
                                          toDouble(timeEnd)) {
                                        Fluttertoast.showToast(
                                            msg: "Please check your time",
                                            gravity: ToastGravity.TOP);
                                      } else {
                                        await _vehicule
                                            .where('idVehicule',
                                                isEqualTo: idVehiculeFrequence)
                                            .limit(1)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            idVehiculeFrequence =
                                                doc['idVehicule'];
                                          });
                                        });
                                        await _frequence
                                            .where('idFrequence',
                                                isEqualTo: widget.dataFrequence[
                                                    'idFrequence'])
                                            .limit(1)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            _frequence.doc(doc.id).update({
                                              'frequence':
                                                  _frequenceTextController.text,
                                              'jourFrequence': _jour,
                                              // 'siretPartenaire':
                                              //     _siretPartenaireController.text,
                                              'idContactFrequence': 'null',
                                              'idVehiculeFrequence':
                                                  idVehiculeFrequence,
                                              'dureeFrequence':
                                                  (toMinute(timeEnd) -
                                                          toMinute(timeStart))
                                                      .toString(),
                                              'startFrequence':
                                                  getTimeText(time: timeStart),
                                              'endFrequence':
                                                  getTimeText(time: timeEnd),
                                              'tarifFrequence':
                                                  _frequenceTarifController
                                                      .text,
                                              'dateMinimaleFrequence':
                                                  getDateText(
                                                      date: dateMinimale),
                                              'dateMaximaleFrequence':
                                                  getDateText(
                                                      date: dateMaximale),
                                            }).then((value) async {
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
                                                  Map<String, dynamic>
                                                      next_partenaire =
                                                      doc.data()! as Map<String,
                                                          dynamic>;
                                                  print("Frequence Modified");
                                                  Fluttertoast.showToast(
                                                      msg: "Frequence Modified",
                                                      gravity:
                                                          ToastGravity.TOP);

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewPartenairePage(
                                                              partenaire:
                                                                  next_partenaire,
                                                            )),
                                                  ).then((value) =>
                                                      setState(() {}));
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
                                          color: Color(
                                              graphique.color['default_black']),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          graphique.languagefr[
                                                  'modify_frequence_partenaire_page']
                                              ['button_1'],
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
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
