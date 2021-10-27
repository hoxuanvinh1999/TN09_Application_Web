import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tn09_app_web_demo/google_map/models/geometry.dart';
import 'package:tn09_app_web_demo/google_map/models/location.dart';
import 'package:tn09_app_web_demo/google_map/models/place.dart';
import 'package:tn09_app_web_demo/google_map/models/place_search.dart';
import 'package:tn09_app_web_demo/google_map/services/geolocator_service.dart';
import 'package:tn09_app_web_demo/google_map/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

  //variable
  late Position currentLocation;
  List<PlaceSearch> searchResults = [];
  final selectedLocation = StreamController.broadcast();
  final bounds = BehaviorSubject<LatLngBounds>();
  late Place selectedLocationStatic;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
      name: 'null',
      geometry: Geometry(
        location: Location(
            lat: currentLocation.latitude, lng: currentLocation.longitude),
      ),
      vicinity: '',
      placeId: '',
      formatted_address: '',
      city: '',
      code_postal: '',
      short_adresse: '',
      country: '',
    );
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = [];
    notifyListeners();
  }

  void dispose() {
    selectedLocation.close();
    bounds.close();
    super.dispose();
  }
}
