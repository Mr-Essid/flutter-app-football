
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_flutter_football/utils/utils.dart';

class LatLongWapper {
  final String latitude;
  final String longitude;
  final String id_;

  const LatLongWapper({required this.id_, required this.latitude, required this.longitude});


  LatLng getLatLng() {
    return parseLatLongFromString(latitude, longitude);
  }



}