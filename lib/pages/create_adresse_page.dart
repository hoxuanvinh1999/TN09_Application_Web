import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tn09_app_web_demo/google_map/blocs/application_bloc.dart';
import 'package:tn09_app_web_demo/google_map/models/place.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/partenaire_page.dart';

class CreateAdressePage extends StatefulWidget {
  @override
  _CreateAdressePageState createState() => _CreateAdressePageState();
}

class _CreateAdressePageState extends State<CreateAdressePage> {
  // For Partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");
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
    _nomPartenaireAdresseController.text = '';
    //= widget.partenaire['nomPartenaire'];
    _latitudeAdresseController.text = '';
    _longitudeAdresseController.text = '';
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

  Marker _ourCompany = Marker(
      markerId: MarkerId('les_detritivores'),
      position: LatLng(44.85552543453359, -0.5484378447808893),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          InfoWindow(title: 'Les detritivores', snippet: 'Our Company'));

  @override
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription? locationSubscription;
  StreamSubscription? boundsSubscription;
  String idLocation = '';
  String addressLocation = '';
  String latitudeLocation = '';
  String longitudeLocation = '';
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
    inputData();
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    _markers.add(_ourCompany);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
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
                        text: 'Partenaire',
                        style: TextStyle(
                            color: Colors.red,
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
                      text: 'Create Adresse',
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
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 50),
              width: 600,
              height: 3000,
              color: Colors.green,
              child: Column(children: [
                Container(
                  height: 60,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(
                            FontAwesomeIcons.building,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Create New Adresse',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
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
                  ),
                ),
                Container(
                    height: 60,
                    color: Colors.red,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.cog,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              ' Informations et paramètres',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
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
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1500,
                  width: 800,
                  color: Colors.blue,
                  child: Form(
                      key: _createAdresseKeyForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8.0),
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _nomPartenaireAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Nom Adresse:',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == '') {
                                  return 'This can not be null';
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _ligne1AdresseController,
                              decoration: InputDecoration(
                                labelText: 'Adresse 1*:',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == '') {
                                  return 'This can not be null';
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _ligne2AdresseController,
                              decoration: InputDecoration(
                                labelText: 'Adresse 2:',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _codepostalAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Code Postal*:',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == '') {
                                  return 'This can not be null';
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _villeAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Ville*:',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == '') {
                                  return 'This can not be null';
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _paysAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Pays*:',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == '') {
                                  return 'This can not be null';
                                }
                              },
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Position',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchAdresse = true;
                                        });
                                      },
                                      tooltip: 'Search by Google Map',
                                      icon: Icon(
                                        FontAwesomeIcons.search,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  padding: EdgeInsets.only(left: 8.0),
                                  width: 200,
                                  color: Colors.red,
                                  child: TextFormField(
                                    controller: _latitudeAdresseController,
                                    decoration: InputDecoration(
                                      labelText: 'Latitude:',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  padding: EdgeInsets.only(left: 8.0),
                                  width: 200,
                                  color: Colors.red,
                                  child: TextFormField(
                                    controller: _longitudeAdresseController,
                                    decoration: InputDecoration(
                                      labelText: 'Longitude:',
                                    ),
                                  ),
                                ),
                              ],
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
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _etageAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Étage*:',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == '') {
                                  return 'This can not be null';
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ascenseur',
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
                                value: _ascenseurAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _ascenseurAdresse = !_ascenseurAdresse;
                                    print(
                                        '_ascenseurAdresse $_ascenseurAdresse');
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
                                'Passages',
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
                                value: _passagesAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _passagesAdresse = !_passagesAdresse;
                                    print('_passagesAdresse $_passagesAdresse');
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
                                'Facturation',
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
                                value: _facturationAdresse,
                                onChanged: (value) {
                                  setState(() {
                                    _facturationAdresse = !_facturationAdresse;
                                    print(
                                        '_facturationAdresse $_facturationAdresse');
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              width: 400,
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _noteAdresseController,
                                  maxLines: 4,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Note"),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _tarifpassageAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Prix du passage',
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
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _tempspassageAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Temps sur place',
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
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            width: 400,
                            color: Colors.red,
                            child: TextFormField(
                              controller: _surfacepassageAdresseController,
                              decoration: InputDecoration(
                                labelText: 'Surface plancher',
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
                        width: 250,
                      ),
                      Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () {},
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
                              if (_createAdresseKeyForm.currentState!
                                  .validate()) {}
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
                                  'Create',
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
              ])),
          SizedBox(
            width: 30,
          ),
          Visibility(
              visible: searchAdresse,
              child: Container(
                width: 600,
                height: 2000,
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Icon(
                                FontAwesomeIcons.search,
                                size: 17,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search Posistion',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
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
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    hintText: 'Search Location',
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: (value) =>
                                      applicationBloc.searchPlaces(value),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 600,
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
                                        width: 600,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.6),
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
                                width: 200,
                                height: 100,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: ElevatedButton(
                                  child: Text(
                                    'Select Location',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {},
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
