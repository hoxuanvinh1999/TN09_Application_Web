// ignore_for_file: non_constant_identifier_names, unnecessary_new, prefer_final_fields

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tn09_app_web_demo/google_map/blocs/application_bloc.dart';
import 'package:tn09_app_web_demo/google_map/models/place.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/get_time_text.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/math_function/toDouble.dart';
import 'package:tn09_app_web_demo/pages/math_function/toMinute.dart';
import 'package:tn09_app_web_demo/pages/menu2/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/widget/button_widget.dart';
import 'package:tn09_app_web_demo/pages/widget/company_position.dart'
    as company;
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/widget/vehicule_icon.dart';

class CreateAdresseFullPage extends StatefulWidget {
  Map partenaire;
  CreateAdresseFullPage({
    required this.partenaire,
  });
  @override
  _CreateAdresseFullPageState createState() => _CreateAdresseFullPageState();
}

class _CreateAdresseFullPageState extends State<CreateAdresseFullPage> {
  //id for new adresse
  String newidAdresse = '';
  // For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  //For frequence
  CollectionReference _frequence =
      FirebaseFirestore.instance.collection("Frequence");
  // For Create Adresse, it's for adresse information
  final _createAdresseKeyForm = GlobalKey<FormState>();
  CollectionReference _adresse =
      FirebaseFirestore.instance.collection("Adresse");
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
  bool _ascenseurAdresse = true;
  TextEditingController _noteAdresseController = TextEditingController();
  bool _passagesAdresse = true;
  bool _facturationAdresse = true;
  TextEditingController _tarifpassageAdresseController =
      TextEditingController();
  TextEditingController _tempspassageAdresseController =
      TextEditingController();
  TextEditingController _surfacepassageAdresseController =
      TextEditingController();

  // inputData() {
  //   _nomPartenaireAdresseController.text = widget.partenaire['nomPartenaire'];
  //   _etageAdresseController.text = '0';
  //   _noteAdresseController.text = '';
  //   newidAdresse = _adresse.doc().id;
  // }

  //For Google Map
  bool searchAdresse = false;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(44.855601489864014, -0.5484378447808893),
    zoom: 15,
  );

  Set<Marker> _markers = {};
  GoogleMapController? _googleMapController;

  @override
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription? locationSubscription;
  StreamSubscription? boundsSubscription;
  String idLocation = '';
  String addressLocation = '';
  String latitudeLocation = '';
  String longitudeLocation = '';
  String short_adresse = '';
  String code_postal = '';
  String city = '';
  String country = '';
  final _locationController = TextEditingController();
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription = applicationBloc.selectedLocation.stream
        .asBroadcastStream()
        .listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
        // _googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        //   CameraPosition(
        //       target: LatLng(
        //           place.geometry.location.lat, place.geometry.location.lng),
        //       zoom: 14.0),
        // ));
        // _markers.remove('now');
        _markers.add(Marker(
          markerId: MarkerId('${place.placeId}'),
          infoWindow: InfoWindow(title: place.name),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
        ));
        String location_name = place.name;
      } else
        _locationController.text = "";
    });
    setState(() {
      _nomPartenaireAdresseController.text = widget.partenaire['nomPartenaire'];
      _etageAdresseController.text = '0';
      _noteAdresseController.text = '';
      newidAdresse = _adresse.doc().id;
    });

    _contenantadresse.doc(newidAdresse).set({
      'idAdresse': newidAdresse,
      'nombredetype': '0',
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    locationSubscription!.cancel();
    boundsSubscription!.cancel();
    super.dispose();
  }

  Future<void> _goToPlace(Place place) async {
    latitudeLocation = (place.geometry.location.lat).toString();
    longitudeLocation = (place.geometry.location.lng).toString();
    idLocation = place.placeId;
    addressLocation = place.formatted_address;
    short_adresse = place.short_adresse;
    code_postal = place.code_postal;
    city = place.city;
    country = place.country;
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }

  // For Frequence part
  var list_timeStart = new List<TimeOfDay>.generate(7, (i) => TimeOfDay.now());
  var list_timeEnd = new List<TimeOfDay>.generate(7, (i) => TimeOfDay.now());
  var list_idVehicule = new List<String>.generate(7, (i) => '');
  var list_color = new List<Color>.generate(
      7, (index) => Color(graphique.color['default_blue']));
  var confirm_value = new List<bool>.generate(7, (index) => false);
  var list_dateMinimale = new List<DateTime>.generate(7, (i) => DateTime.now());
  var list_dateMaximale = new List<DateTime>.generate(7, (i) => DateTime.now());
  var list_frequence =
      new List<Map<String, dynamic>>.generate(7, (index) => {});
  var list_frequenceTextController = List<TextEditingController>.generate(
      7, (index) => TextEditingController(text: ''));
  var list_frequenceTarifController = List<TextEditingController>.generate(
      7, (index) => TextEditingController(text: ''));
  var list_choiceVehicule = List<String>.generate(7, (index) => 'None');
  List<String> list_jour = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche',
  ];
  Future pickTimeStart({
    required BuildContext context,
    required TimeOfDay time,
    required int index,
  }) async {
    final newTime = await showTimePicker(context: context, initialTime: time);

    if (newTime == null) {
      return;
    }
    setState(() => list_timeStart[index] = newTime);
  }

  Future pickTimeEnd({
    required BuildContext context,
    required TimeOfDay time,
    required int index,
  }) async {
    final newTime = await showTimePicker(context: context, initialTime: time);

    if (newTime == null) {
      return;
    }
    setState(() => list_timeEnd[index] = newTime);
  }

  Future pickDateMinimale({
    required BuildContext context,
    required index,
  }) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => list_dateMinimale[index] = newDate);
  }

  Future pickDateMaximale({
    required BuildContext context,
    required index,
  }) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDate == null) return;

    setState(() => list_dateMaximale[index] = newDate);
  }

  Widget frequence_row({
    required BuildContext context,
    required int index,
  }) {
    double row_width = MediaQuery.of(context).size.width * 0.9;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: row_width,
        decoration: BoxDecoration(
          color: Color(graphique.color['main_color_2']),
          border: Border(
            top: BorderSide(
              color: Color(graphique.color['default_black']),
              width: 1.0,
            ),
            bottom: BorderSide(
              color: Color(graphique.color['default_black']),
              width: 1.0,
            ),
          ),
        ),
        height: 80,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.centerLeft,
                width: row_width * 0.1,
                child: Text(
                  list_jour[index],
                  style: TextStyle(
                    color: Color(graphique.color['default_black']),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.centerLeft,
                width: row_width * 0.1,
                child: ButtonWidget(
                  icon: Icons.calendar_today,
                  text: getTimeText(time: list_timeStart[index]),
                  onClicked: () => pickTimeStart(
                    context: context,
                    time: list_timeStart[index],
                    index: index,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.centerLeft,
                width: row_width * 0.1,
                child: ButtonWidget(
                  icon: Icons.calendar_today,
                  text: getTimeText(time: list_timeEnd[index]),
                  onClicked: () => pickTimeEnd(
                    context: context,
                    time: list_timeStart[index],
                    index: index,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.centerLeft,
                width: row_width * 0.15,
                child: ButtonWidget(
                  icon: Icons.calendar_today,
                  text: getDateText(date: list_dateMinimale[index]),
                  onClicked: () =>
                      pickDateMinimale(context: context, index: index),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.centerLeft,
                width: row_width * 0.15,
                child: ButtonWidget(
                  icon: Icons.calendar_today,
                  text: getDateText(date: list_dateMaximale[index]),
                  onClicked: () =>
                      pickDateMaximale(context: context, index: index),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(graphique.color['main_color_1']),
                  ),
                  color: Color(graphique.color['special_bureautique_1']),
                ),
                child: TextFormField(
                  style:
                      TextStyle(color: Color(graphique.color['main_color_2'])),
                  cursorColor: Color(graphique.color['main_color_2']),
                  controller: list_frequenceTextController[index],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(graphique.color['main_color_2']),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(graphique.color['main_color_1']),
                  ),
                  color: Color(graphique.color['special_bureautique_1']),
                ),
                child: TextFormField(
                  style:
                      TextStyle(color: Color(graphique.color['main_color_2'])),
                  cursorColor: Color(graphique.color['main_color_2']),
                  controller: list_frequenceTarifController[index],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(graphique.color['main_color_2']),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(graphique.color['main_color_1']),
                  ),
                  color: Color(graphique.color['special_bureautique_1']),
                ),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Vehicule")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      return DropdownButton(
                        onChanged: (String? changedValue) {
                          setState(() {
                            list_choiceVehicule[index] = changedValue!;
                          });
                        },
                        value: list_choiceVehicule[index],
                        items: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> vehicule =
                              document.data()! as Map<String, dynamic>;

                          return DropdownMenuItem<String>(
                              value: vehicule['numeroImmatriculation'],
                              child: Row(
                                children: [
                                  buildVehiculeIcon(
                                      icontype: vehicule['typeVehicule'],
                                      iconcolor: vehicule['colorIconVehicule']
                                          .toUpperCase(),
                                      sizeIcon: 15.0),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    vehicule['nomVehicule'] +
                                        ' ' +
                                        vehicule['numeroImmatriculation'],
                                    style: TextStyle(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                        fontSize: 15),
                                  ),
                                ],
                              ));
                        }).toList(),
                      );
                    }),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                      color: confirm_value[index]
                          ? Color(graphique.color['default_grey'])
                          : Color(graphique.color['default_blue']),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (list_frequenceTextController[index].text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please Input a frequence",
                            gravity: ToastGravity.TOP);
                      } else if (!list_frequenceTextController[index]
                              .text
                              .isEmpty &&
                          int.tryParse(
                                  list_frequenceTextController[index].text) ==
                              null) {
                        Fluttertoast.showToast(
                            msg: "Please Input a real Number for frequence",
                            gravity: ToastGravity.TOP);
                      } else if (list_dateMinimale[index]
                          .isAfter(list_dateMaximale[index])) {
                        Fluttertoast.showToast(
                            msg: "Please check your day",
                            gravity: ToastGravity.TOP);
                      } else if (!list_frequenceTarifController[index]
                              .text
                              .isEmpty &&
                          int.tryParse(
                                  list_frequenceTarifController[index].text) ==
                              null) {
                      } else if (toDouble(list_timeStart[index]) >
                          toDouble(list_timeEnd[index])) {
                        Fluttertoast.showToast(
                            msg: "Please check your time",
                            gravity: ToastGravity.TOP);
                      } else {
                        if (!confirm_value[index]) {
                          String newIdFrequence = _frequence.doc().id;
                          list_frequence[index] = {
                            'frequence':
                                list_frequenceTextController[index].text,
                            'jourFrequence': list_jour[index],
                            //'siretPartenaire': _siretPartenaireController.text,
                            'idContactFrequence': 'null',
                            'idVehiculeFrequence': list_choiceVehicule[index],
                            'idAdresseFrequence': newidAdresse,
                            'nomAdresseFrequence':
                                _nomPartenaireAdresseController.text,
                            'idPartenaireFrequence':
                                widget.partenaire['idPartenaire'],
                            'dureeFrequence': (toMinute(list_timeEnd[index]) -
                                    toMinute(list_timeStart[index]))
                                .toString(),
                            'startFrequence':
                                getTimeText(time: list_timeStart[index]),
                            'endFrequence':
                                getTimeText(time: list_timeEnd[index]),
                            'tarifFrequence':
                                list_frequenceTarifController[index].text,
                            'dateMinimaleFrequence':
                                getDateText(date: list_dateMinimale[index]),
                            'dateMaximaleFrequence':
                                getDateText(date: list_dateMaximale[index]),
                            'idFrequence': newIdFrequence
                          };
                        } else {
                          list_frequence[index] = {};
                        }
                        setState(() {
                          confirm_value[index] = !confirm_value[index];
                        });
                      }
                    },
                    child: Text(
                      confirm_value[index]
                          ? graphique
                                  .languagefr['modify_addresse_multiple_page']
                              ['horaires_form']['column_9_button_2']
                          : graphique
                                  .languagefr['modify_addresse_multiple_page']
                              ['horaires_form']['column_9_button_1'],
                      style: TextStyle(
                        color: Color(graphique.color['default_black']),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ],
          ),
        ));
    // return SizedBox.shrink();
  }

  // For Contenant Part
  CollectionReference _contenant =
      FirebaseFirestore.instance.collection("Contenant");
  CollectionReference _contenantadresse =
      FirebaseFirestore.instance.collection("ContenantAdresse");
  int number_of_contenant_added = 0;

  @override
  Widget build(BuildContext context) {
    // For width of table
    double column1_width = MediaQuery.of(context).size.width * 0.45;
    double column2_width = MediaQuery.of(context).size.width * 0.45;
    double page_frequence = MediaQuery.of(context).size.width * 0.95;
    double page_frequence_inside = MediaQuery.of(context).size.width * 0.9;
    //inputData();
    print('newidAdresse: $newidAdresse');
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    _markers.add(company.companyMarker);
    // For Table Frequence
    var list_frequence_row = List<Widget>.generate(
        7, (index) => frequence_row(context: context, index: index));
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
                            showCancelDialog(context: context, goto: 'Home');
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
                          ..onTap = () async {
                            showCancelDialog(
                                context: context, goto: 'Partenaire');
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
                          ..onTap = () async {
                            showCancelDialog(
                                context: context, goto: 'ViewPartenaire');
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
                      text: graphique.languagefr['create_adresse_page']
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
              height: 1500,
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
                        FontAwesomeIcons.building,
                        size: 17,
                        color: Color(graphique.color['main_color_2']),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        graphique.languagefr['create_adresse_page']['nom_page'],
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
                        graphique.languagefr['create_adresse_page']
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
                  height: 1350,
                  width: column1_width,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['special_bureautique_2']),
                    // border: Border.all(width: 1.0),
                  ),
                  child: Form(
                      key: _createAdresseKeyForm,
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
                              controller: _nomPartenaireAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
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
                              controller: _ligne1AdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
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
                              controller: _ligne2AdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
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
                              controller: _codepostalAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
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
                              controller: _villeAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
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
                              controller: _paysAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
                                        ['field_6_title'],
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
                            width: 400,
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      graphique
                                              .languagefr['create_adresse_page']
                                          ['field_7_title'],
                                      style: TextStyle(
                                        color: Color(
                                            graphique.color['default_black']),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchAdresse = true;
                                          applicationBloc.searchPlaces(
                                              _ligne1AdresseController.text);
                                        });
                                      },
                                      tooltip: graphique
                                              .languagefr['create_adresse_page']
                                          ['field_7_hint'],
                                      icon: Icon(
                                        FontAwesomeIcons.search,
                                        size: 15,
                                        color: Color(
                                            graphique.color['default_black']),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
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
                              controller: _latitudeAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
                                        ['field_8_title'],
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
                              controller: _longitudeAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
                                        ['field_9_title'],
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
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //     vertical: 20,
                          //   ),
                          //   width: 700,
                          //   height: 800,
                          //   color: Colors.red,
                          // ),
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
                              controller: _etageAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
                                        ['field_10_title'],
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                graphique.languagefr['create_adresse_page']
                                    ['field_11_title'],
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
                                value: _ascenseurAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _ascenseurAdresse = !_ascenseurAdresse;
                                    print(
                                        '_ascenseurAdresse $_ascenseurAdresse');
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
                                graphique.languagefr['create_adresse_page']
                                    ['field_12_title'],
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
                                value: _passagesAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _passagesAdresse = !_passagesAdresse;
                                    print('_passagesAdresse $_passagesAdresse');
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
                                graphique.languagefr['create_adresse_page']
                                    ['field_13_title'],
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
                                value: _facturationAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _facturationAdresse = !_facturationAdresse;
                                    print(
                                        '_facturationAdresse $_facturationAdresse');
                                  });
                                },
                                activeTrackColor:
                                    Color(graphique.color['main_color_2']),
                                activeColor:
                                    Color(graphique.color['main_color_2']),
                              ),
                            ],
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
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  controller: _noteAdresseController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: graphique
                                            .languagefr['create_adresse_page']
                                        ['field_14_title'],
                                    hintStyle: TextStyle(
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
                              controller: _tarifpassageAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
                                        ['field_15_title'],
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
                                if (!value!.isEmpty &&
                                    double.tryParse(value) == null) {
                                  return 'Please input a true number';
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
                              controller: _tempspassageAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
                                        ['field_16_title'],
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
                                if (!value!.isEmpty &&
                                    double.tryParse(value) == null) {
                                  return 'Please input a true number';
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
                              controller: _surfacepassageAdresseController,
                              decoration: InputDecoration(
                                labelText:
                                    graphique.languagefr['create_adresse_page']
                                        ['field_17_title'],
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
                                if (!value!.isEmpty &&
                                    double.tryParse(value) == null) {
                                  return 'Please input a true number';
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ])),
          Visibility(
              visible: searchAdresse,
              child: Container(
                height: 1000,
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            FontAwesomeIcons.search,
                            size: 17,
                            color: Color(graphique.color['main_color_2']),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            graphique.languagefr['create_adresse_page']
                                ['position_form']['form_nom'],
                            style: TextStyle(
                              color: Color(graphique.color['main_color_2']),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    (applicationBloc.currentLocation == null)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    hintText: graphique
                                            .languagefr['create_adresse_page']
                                        ['position_form']['hint_1'],
                                    suffixIcon: Icon(Icons.search,
                                        color: Color(
                                            graphique.color['main_color_2'])),
                                    hintStyle: TextStyle(
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
                                  onChanged: (value) =>
                                      applicationBloc.searchPlaces(value),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: column2_width,
                                    child: GoogleMap(
                                      myLocationButtonEnabled: false,
                                      zoomControlsEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            applicationBloc
                                                .currentLocation.latitude,
                                            applicationBloc
                                                .currentLocation.altitude),
                                        zoom: 15,
                                      ),
                                      // _initialCameraPosition,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _mapController.complete(controller);
                                        //setPolylines();
                                      },
                                      markers: _markers,
                                      gestureRecognizers: Set()
                                        ..add(Factory<EagerGestureRecognizer>(
                                            () => EagerGestureRecognizer())),
                                    ),
                                  ),
                                  if (applicationBloc.searchResults != [] &&
                                      applicationBloc.searchResults.length != 0)
                                    Container(
                                        height: 600,
                                        width: column2_width,
                                        decoration: BoxDecoration(
                                          color: Color(graphique
                                                  .color['default_black'])
                                              .withOpacity(.6),
                                        )),
                                  if (applicationBloc.searchResults != [])
                                    Container(
                                      height: 600,
                                      width: 600,
                                      child: ListView.builder(
                                          itemCount: applicationBloc
                                              .searchResults.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                applicationBloc
                                                    .searchResults[index]
                                                    .description,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onTap: () {
                                                applicationBloc
                                                    .setSelectedLocation(
                                                        applicationBloc
                                                            .searchResults[
                                                                index]
                                                            .placeId);
                                              },
                                            );
                                          }),
                                    ),
                                ],
                              ),
                              Container(
                                width: column2_width * 0.5,
                                height: 100,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: ElevatedButton(
                                  child: Text(
                                    graphique.languagefr['create_adresse_page']
                                        ['position_form']['button_1'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(
                                          graphique.color['default_white']),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _ligne1AdresseController.text =
                                          addressLocation.toString();
                                      _ligne2AdresseController.text =
                                          short_adresse;
                                      _longitudeAdresseController.text =
                                          longitudeLocation;
                                      _latitudeAdresseController.text =
                                          latitudeLocation;
                                      _villeAdresseController.text = city;
                                      _paysAdresseController.text = country;
                                      _codepostalAdresseController.text =
                                          code_postal;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ))
        ],
      ),
      Align(
          alignment: Alignment(-0.9, 0),
          child: Container(
            height: 1200,
            margin: const EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 20,
            ),
            width: page_frequence,
            decoration: BoxDecoration(
              color: Color(graphique.color['special_bureautique_2']),
              border: Border.all(
                  width: 1.0, color: Color(graphique.color['default_black'])),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: page_frequence,
                    alignment: const Alignment(-0.9, 0),
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Text(
                      graphique.languagefr['modify_addresse_multiple_page']
                          ['subtitle_page'] // Créer un horaire associé
                      ,
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
                          graphique.languagefr['modify_addresse_multiple_page']
                              ['horaires_form']['form_subtitle'],
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
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    height: 100,
                    width: page_frequence_inside,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(width: 1.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.1,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_1_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.1,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_2_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 20),
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.1,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_3_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.1,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_4_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50, right: 10),
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.1,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_5_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.08,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_6_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.1,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_7_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: page_frequence_inside * 0.1,
                          child: Text(
                            graphique
                                    .languagefr['modify_addresse_multiple_page']
                                ['horaires_form']['column_8_title'],
                            style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 800,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['special_bureautique_2']),
                      border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black']),
                      ),
                      // border: Border(
                      //   left: BorderSide(
                      //     width: 1.0,
                      //     color: Color(graphique.color['default_black']),
                      //   ),
                      //   right: BorderSide(
                      //     width: 1.0,
                      //     color: Color(graphique.color['default_black']),
                      //   ),
                      // ),
                    ),
                    child: Column(
                      children: list_frequence_row,
                    ),
                  ),
                ]),
          )),
      Align(
        alignment: Alignment(-0.9, 0),
        child: Container(
            height: 500,
            margin: const EdgeInsets.only(
              left: 10,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: page_frequence,
                    alignment: const Alignment(-0.9, 0),
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Text(
                      'Contenant Form',
                      style: TextStyle(
                        color: Color(graphique.color['main_color_2']),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: column2_width * 0.8,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_red']),
                      border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black']),
                      ),
                    ),
                    height: 150,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Contenant")
                            .where('idAdresseContenant',
                                isEqualTo: newidAdresse)
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
                          return SingleChildScrollView(
                            child: Column(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document_contenant) {
                                Map<String, dynamic> insidedataContenant =
                                    document_contenant.data()!
                                        as Map<String, dynamic>;

                                return SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 5,
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
                                                    limitString(
                                                        text: insidedataContenant[
                                                                'typeContenant'] +
                                                            ' ' +
                                                            insidedataContenant[
                                                                'barCodeContenant'],
                                                        limit_long: 30),
                                                    style: TextStyle(
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ])),
                                            Container(
                                              width: 80,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        await _contenant
                                                            .where(
                                                                'idContenant',
                                                                isEqualTo:
                                                                    insidedataContenant[
                                                                        'idContenant'])
                                                            .limit(1)
                                                            .get()
                                                            .then((QuerySnapshot
                                                                querySnapshot) {
                                                          querySnapshot.docs
                                                              .forEach((doc) {
                                                            _contenant
                                                                .doc(doc.id)
                                                                .update({
                                                              'idAdresseContenant':
                                                                  'null',
                                                            });
                                                          });
                                                        });
                                                        String typeConenant =
                                                            insidedataContenant[
                                                                    'typeContenant']
                                                                .replaceAll(
                                                                    ' ', '')
                                                                .toLowerCase();
                                                        await _contenantadresse
                                                            .where('idAdresse',
                                                                isEqualTo:
                                                                    newidAdresse)
                                                            .limit(1)
                                                            .get()
                                                            .then((QuerySnapshot
                                                                querySnapshot) {
                                                          querySnapshot.docs
                                                              .forEach((doc) {
                                                            int check_type_exist =
                                                                0;
                                                            int save_position =
                                                                0;
                                                            for (int i = 1;
                                                                i <=
                                                                    int.parse(doc[
                                                                        'nombredetype']);
                                                                i++) {
                                                              if (typeConenant ==
                                                                  doc['${i.toString()}']
                                                                      .substring(
                                                                          0,
                                                                          doc['$i']
                                                                              .indexOf('/'))) {
                                                                print(
                                                                    '${doc['${i.toString()}'].substring(0, doc['$i'].indexOf('/'))}');
                                                                check_type_exist =
                                                                    1;
                                                                save_position =
                                                                    i;
                                                              }
                                                            }
                                                            String _quality = doc[
                                                                    '${save_position.toString()}']
                                                                .substring(doc[
                                                                            '$save_position']
                                                                        .indexOf(
                                                                            '/') +
                                                                    1);
                                                            _contenantadresse
                                                                .doc(doc.id)
                                                                .update({
                                                              '${save_position.toString()}':
                                                                  typeConenant +
                                                                      '/' +
                                                                      (int.parse(_quality) -
                                                                              1)
                                                                          .toString(),
                                                            }).then((value) {
                                                              number_of_contenant_added--;
                                                              print(
                                                                  "Contenant Updated");
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Contenant Updated",
                                                                  gravity:
                                                                      ToastGravity
                                                                          .TOP);
                                                            }).catchError((error) =>
                                                                    print(
                                                                        "Failed to add user: $error"));
                                                          });
                                                        });
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons.minus,
                                                        size: 15,
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
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
                    margin: const EdgeInsets.only(top: 10),
                    height: 40,
                    width: column1_width * 0.8,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_green']),
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: Color(graphique.color['default_black']),
                        ),
                        left: BorderSide(
                          width: 1.0,
                          color: Color(graphique.color['default_black']),
                        ),
                        right: BorderSide(
                          width: 1.0,
                          color: Color(graphique.color['default_black']),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  FontAwesomeIcons.locationArrow,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Availabe Contenant',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: column2_width * 0.8,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_red']),
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Color(graphique.color['default_black']),
                        ),
                        left: BorderSide(
                          width: 1.0,
                          color: Color(graphique.color['default_black']),
                        ),
                        right: BorderSide(
                          width: 1.0,
                          color: Color(graphique.color['default_black']),
                        ),
                      ),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Contenant")
                          .where('idAdresseContenant', isEqualTo: 'null')
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
                        return SingleChildScrollView(
                          child: Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document_contenant) {
                              Map<String, dynamic> insidedataContenant =
                                  document_contenant.data()!
                                      as Map<String, dynamic>;

                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: column1_width * 0.5,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  limitString(
                                                      text: insidedataContenant[
                                                              'typeContenant'] +
                                                          ' ' +
                                                          insidedataContenant[
                                                              'barCodeContenant'],
                                                      limit_long: 30),
                                                  style: TextStyle(
                                                      color: Color(
                                                          graphique.color[
                                                              'default_black']),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    await _contenant
                                                        .where('idContenant',
                                                            isEqualTo:
                                                                insidedataContenant[
                                                                    'idContenant'])
                                                        .limit(1)
                                                        .get()
                                                        .then((QuerySnapshot
                                                            querySnapshot) {
                                                      querySnapshot.docs
                                                          .forEach((doc) {
                                                        _contenant
                                                            .doc(doc.id)
                                                            .update({
                                                          'idAdresseContenant':
                                                              newidAdresse,
                                                        });
                                                      });
                                                    });
                                                    String typeConenant =
                                                        insidedataContenant[
                                                                'typeContenant']
                                                            .replaceAll(' ', '')
                                                            .toLowerCase();
                                                    QuerySnapshot query =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'TypeContenant')
                                                            .where(
                                                                'nomTypeContenant',
                                                                isEqualTo:
                                                                    typeConenant)
                                                            .get();

                                                    await _contenantadresse
                                                        .where('idAdresse',
                                                            isEqualTo:
                                                                newidAdresse)
                                                        .limit(1)
                                                        .get()
                                                        .then((QuerySnapshot
                                                            querySnapshot) {
                                                      querySnapshot.docs.forEach(
                                                          (doc_contenantadresse) {
                                                        int check_type_exist =
                                                            0;
                                                        int save_position = 0;
                                                        for (int i = 1;
                                                            i <=
                                                                int.parse(
                                                                    doc_contenantadresse[
                                                                        'nombredetype']);
                                                            i++) {
                                                          if (typeConenant ==
                                                              doc_contenantadresse[
                                                                      '${i.toString()}']
                                                                  .substring(
                                                                      0,
                                                                      doc_contenantadresse[
                                                                              '$i']
                                                                          .indexOf(
                                                                              '/'))) {
                                                            print(
                                                                '${doc_contenantadresse['${i.toString()}'].substring(0, doc_contenantadresse['$i'].indexOf('/'))}');
                                                            check_type_exist =
                                                                1;
                                                            save_position = i;
                                                          }
                                                        }

                                                        if (check_type_exist ==
                                                            1) {
                                                          String _quality = doc_contenantadresse[
                                                                  '${save_position.toString()}']
                                                              .substring(doc_contenantadresse[
                                                                          '$save_position']
                                                                      .indexOf(
                                                                          '/') +
                                                                  1);
                                                          _contenantadresse
                                                              .doc(
                                                                  doc_contenantadresse
                                                                      .id)
                                                              .update({
                                                            '${save_position.toString()}':
                                                                typeConenant +
                                                                    '/' +
                                                                    (int.parse(_quality) +
                                                                            1)
                                                                        .toString(),
                                                          }).then((value) {
                                                            print(
                                                                "Contenant Updated");
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Contenant Updated",
                                                                gravity:
                                                                    ToastGravity
                                                                        .TOP);
                                                          }).catchError((error) =>
                                                                  print(
                                                                      "Failed to add user: $error"));
                                                        } else {
                                                          _contenantadresse
                                                              .doc(
                                                                  doc_contenantadresse
                                                                      .id)
                                                              .update({
                                                            '${int.parse(doc_contenantadresse['nombredetype']) + 1}':
                                                                typeConenant +
                                                                    '/' +
                                                                    '1',
                                                            'nombredetype':
                                                                (int.parse(doc_contenantadresse[
                                                                            'nombredetype']) +
                                                                        1)
                                                                    .toString(),
                                                          }).then((value) {
                                                            number_of_contenant_added++;
                                                            print(
                                                                "Contenant Added");
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Contenant Added",
                                                                gravity:
                                                                    ToastGravity
                                                                        .TOP);
                                                          }).catchError((error) =>
                                                                  print(
                                                                      "Failed to add user: $error"));
                                                        }
                                                      });
                                                    });
                                                  },
                                                  icon: Icon(
                                                    FontAwesomeIcons.plus,
                                                    size: 15,
                                                    color: Color(
                                                        graphique.color[
                                                            'default_black']),
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
                ])),
      ),
      Align(
        alignment: Alignment(-0.9, 0),
        child: Container(
          height: 150,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Color(graphique.color['default_yellow']),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      showCancelDialog(
                          context: context, goto: 'ViewPartenaire');
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
                          graphique.languagefr['modify_addresse_multiple_page']
                              ['adresse_form']['button_2'],
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
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
                  margin: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () async {
                      showConfirmDialog(context: context);
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
                          graphique.languagefr['modify_addresse_multiple_page']
                              ['adresse_form']['button_1'],
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
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
      ),
    ])));
  }

  showConfirmDialog({required BuildContext context}) {
    double form_width = MediaQuery.of(context).size.width * 0.5;
    int number_of_new_frequence =
        confirm_value.where((element) => element == true).length;
    List<Widget> list_final_frequence = [];
    for (int i = 0; i < 7; i++) {
      if (confirm_value[i] == true) {
        list_final_frequence.add(
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 50,
              width: form_width * 0.8,
              decoration: BoxDecoration(
                  border: Border.all(
                width: 1.0,
                color: Color(graphique.color['default_black']),
              )),
              child: Row(
                children: [
                  Text(
                    '${list_frequence[i]['jourFrequence']}:  ',
                    style: TextStyle(
                      color: Color(
                        graphique.color['default_black'],
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${list_frequence[i]['startFrequence']}',
                    style: TextStyle(
                      color: Color(
                        graphique.color['default_black'],
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${list_frequence[i]['endFrequence']}',
                    style: TextStyle(
                      color: Color(
                        graphique.color['default_black'],
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${list_frequence[i]['dateMinimaleFrequence']}',
                    style: TextStyle(
                      color: Color(
                        graphique.color['default_black'],
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${list_frequence[i]['dateMaximaleFrequence']}',
                    style: TextStyle(
                      color: Color(
                        graphique.color['default_black'],
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
        );
      }
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 500,
              width: form_width,
              decoration: BoxDecoration(
                color: Color(graphique.color['default_white']),
                border: Border.all(
                  width: 1.0,
                  color: Color(graphique.color['default_black']),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      decoration: BoxDecoration(
                        color: Color(graphique.color['special_bureautique_2']),
                        border: Border.all(
                            width: 1.0,
                            color: Color(graphique.color['default_black'])),
                      ),
                      child: Text(
                        'Confirm Form',
                        style: TextStyle(
                            color: Color(graphique.color['default_black']),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Finish creating that adresse?',
                        style: TextStyle(
                          color: Color(
                            graphique.color['default_black'],
                          ),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Your Adresse have $number_of_contenant_added frequences',
                        style: TextStyle(
                          color: Color(
                            graphique.color['default_black'],
                          ),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Your Adresse have $number_of_new_frequence contenants',
                        style: TextStyle(
                          color: Color(
                            graphique.color['default_black'],
                          ),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              _nomPartenaireAdresseController.text,
                              style: TextStyle(
                                color: Color(
                                  graphique.color['default_black'],
                                ),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              _ligne1AdresseController.text,
                              style: TextStyle(
                                color: Color(
                                  graphique.color['default_black'],
                                ),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 150,
                      child: SingleChildScrollView(
                        child: Column(
                          children: list_final_frequence,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                  color:
                                      Color(graphique.color['default_yellow']),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      graphique.languagefr[
                                              'modify_addresse_multiple_page']
                                          ['adresse_form']['button_2'],
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
                          Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                  color:
                                      Color(graphique.color['default_yellow']),
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () async {
                                  for (int i = 0; i < 7; i++) {
                                    if (confirm_value[i] == true) {
                                      list_frequence[i]['nomAdresseFrequence'] =
                                          _nomPartenaireAdresseController.text;
                                    }
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
                                        'nombredeAdresses': (int.parse(
                                                    widget.partenaire[
                                                        'nombredeAdresses']) +
                                                1)
                                            .toString(),
                                        'nombredeFrequence': (int.parse(
                                                    widget.partenaire[
                                                        'nombredeFrequence']) +
                                                number_of_new_frequence)
                                            .toString(),
                                      });
                                    });
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
                                  for (int i = 0; i < 7; i++) {
                                    if (confirm_value[i]) {
                                      await _frequence
                                          .doc(list_frequence[i]['idFrequence'])
                                          .set(list_frequence[i]);
                                    }
                                  }
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
                                    'ascenseurAdresse':
                                        _ascenseurAdresse.toString(),
                                    'noteAdresse': _noteAdresseController.text,
                                    'passagesAdresse':
                                        _passagesAdresse.toString(),
                                    'facturationAdresse':
                                        _facturationAdresse.toString(),
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
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      graphique.languagefr[
                                              'modify_addresse_multiple_page']
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
                  ]),
            ),
          );
        });
  }

  showCancelDialog({required BuildContext context, required String goto}) {
    double form_width = MediaQuery.of(context).size.width * 0.3;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            height: 250,
            width: form_width,
            decoration: BoxDecoration(
              color: Color(graphique.color['default_white']),
              border: Border.all(
                width: 1.0,
                color: Color(graphique.color['default_black']),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    alignment: Alignment(-0.9, 0),
                    decoration: BoxDecoration(
                      color: Color(graphique.color['special_bureautique_2']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Text(
                      'Cancel Form',
                      style: TextStyle(
                          color: Color(graphique.color['default_black']),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      'Are you sure to cancel creating that adresse?',
                      style: TextStyle(
                        color: Color(graphique.color['default_black']),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color(graphique.color['default_yellow']),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    graphique.languagefr[
                                            'modify_addresse_multiple_page']
                                        ['adresse_form']['button_2'],
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
                        Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color(graphique.color['default_yellow']),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () async {
                                _contenantadresse.doc(newidAdresse).delete();
                                switch (goto) {
                                  case 'Home':
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                    break;
                                  case 'Partenaire':
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PartenairePage()));
                                    break;
                                  case 'ViewPartenaire':
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewPartenairePage(
                                                    partenaire:
                                                        widget.partenaire)));
                                    break;
                                  default:
                                    {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewPartenairePage(
                                                      partenaire:
                                                          widget.partenaire)));
                                      break;
                                    }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    graphique.languagefr[
                                            'modify_addresse_multiple_page']
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
                ]),
          ));
        });
  }
}
