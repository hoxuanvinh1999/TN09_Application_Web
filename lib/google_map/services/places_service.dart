import 'package:http/http.dart' as http;
import 'package:tn09_app_web_demo/google_map/models/place.dart';
import 'dart:convert' as convert;
import 'package:tn09_app_web_demo/.env.dart';
import 'package:tn09_app_web_demo/google_map/models/place_search.dart';

class PlacesService {
  final key = googleAPIKey;

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&libraries=places&location=44.85561289815069%2C -0.5484914883986346&radius=100000&strictbounds=true&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }
}
