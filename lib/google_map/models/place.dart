import 'package:tn09_app_web_demo/google_map/models/geometry.dart';

class Place {
  final Geometry geometry;
  final String placeId;
  final String name;
  final String vicinity;
  final String formatted_address;
  final String short_adresse;
  final String city;
  final String country;
  final String code_postal;

  Place(
      {required this.geometry,
      required this.placeId,
      required this.name,
      required this.vicinity,
      required this.formatted_address,
      required this.short_adresse,
      required this.city,
      required this.country,
      required this.code_postal});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        geometry: Geometry.fromJson(json['geometry']),
        placeId: json['place_id'],
        name: json['formatted_address'],
        vicinity: json['vicinity'],
        formatted_address: json['formatted_address'],
        short_adresse: json['address_components'][0]['long_name'] +
            ' ' +
            json['address_components'][1]['long_name'],
        city: json['address_components'][2]['long_name'],
        country: json['address_components'][5]['long_name'],
        code_postal: json['address_components'][6]['long_name']);
  }
}
