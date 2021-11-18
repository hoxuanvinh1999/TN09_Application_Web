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
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/view_partenaire_page.dart';
import 'package:tn09_app_web_demo/pages/widget/company_position.dart'
    as company;
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class CreateAdressePage extends StatefulWidget {
  Map partenaire;
  CreateAdressePage({
    required this.partenaire,
  });
  @override
  _CreateAdressePageState createState() => _CreateAdressePageState();
}

class _CreateAdressePageState extends State<CreateAdressePage> {
  // For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
  // For Control Table
  CollectionReference _contenantadresse =
      FirebaseFirestore.instance.collection("ContenantAdresse");
  //For frequence
  CollectionReference _frequence =
      FirebaseFirestore.instance.collection("Frequence");
  // For Adresse
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
  inputData() {
    _nomPartenaireAdresseController.text = widget.partenaire['nomPartenaire'];
    _etageAdresseController.text = '0';
    _noteAdresseController.text = '';
  }

  bool searchAdresse = false;
//For Google Map
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

  @override
  Widget build(BuildContext context) {
    // For width of table
    double column1_width = MediaQuery.of(context).size.width * 0.45;
    double column2_width = MediaQuery.of(context).size.width * 0.45;
    inputData();
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    _markers.add(company.companyMarker);
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
                        text: widget.partenaire['nomPartenaire'],
                        style: TextStyle(
                            color: Color(graphique.color['default_red']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => ViewPartenairePage(
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
              height: 1600,
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
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => ViewPartenairePage(
                                            partenaire: widget.partenaire,
                                          )));
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
                                  graphique.languagefr['create_adresse_page']
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
                      Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (_createAdresseKeyForm.currentState!
                                  .validate()) {
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
                                    });
                                  });
                                });
                                String newidAdresse = _adresse.doc().id;
                                await _contenantadresse.doc(newidAdresse).set({
                                  'idAdresse': newidAdresse,
                                  'nombredetype': '0'
                                });
                                await _frequence.doc(_frequence.doc().id).set({
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
                                await _adresse.doc(newidAdresse).set({
                                  'nomPartenaireAdresse':
                                      _nomPartenaireAdresseController.text,
                                  'ligne1Adresse':
                                      _ligne1AdresseController.text,
                                  'ligne2Adresse':
                                      _ligne2AdresseController.text,
                                  'codepostalAdresse':
                                      _codepostalAdresseController.text,
                                  'villeAdresse': _villeAdresseController.text,
                                  'paysAdresse': _paysAdresseController.text,
                                  'latitudeAdresse':
                                      _latitudeAdresseController.text,
                                  'longitudeAdresse':
                                      _longitudeAdresseController.text,
                                  'idPosition': 'null',
                                  'etageAdresse': _etageAdresseController.text,
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
                                          isEqualTo:
                                              widget.partenaire['idPartenaire'])
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
                                  graphique.languagefr['create_adresse_page']
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
      )
    ])));
  }
}
