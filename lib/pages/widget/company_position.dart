import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker companyMarker = Marker(
    markerId: MarkerId('les_detritivores'),
    position: LatLng(44.85552543453359, -0.5484378447808893),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    infoWindow: InfoWindow(title: 'Les detritivores', snippet: 'Our Company'));
