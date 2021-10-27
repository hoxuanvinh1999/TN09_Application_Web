import 'package:tn09_app_web_demo/google_map/models/geometry.dart';

class Place {
  final Geometry geometry;
  final String placeId;
  final String name;
  final String vicinity;
  final String formatted_address;

  Place(
      {required this.geometry,
      required this.placeId,
      required this.name,
      required this.vicinity,
      required this.formatted_address});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Geometry.fromJson(json['geometry']),
      placeId: json['place_id'],
      name: json['formatted_address'],
      vicinity: json['vicinity'],
      formatted_address: json['formatted_address'],
    );
  }
}
