

import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng parseLatLongFromString(String latitude, String longitude) {
  final lat = double.parse(latitude);
  final long = double.parse(longitude);
  return LatLng(lat, long);
}


// Future<T?> awaitValue<T>(Duration duration, T Function() callback) {
//
// }

// class FutureCancelable<T> {
//
//   Duration durationBeforeTheCall;
//   T Function() callback;
//   bool isCanceled = false;
//
//
//   Future<T?> wapperFunction() {
//     while(!isCanceled) {
//
//     }
//   }
//
//   Future<T?> run() {
//
//     return Future.delayed(durationBeforeTheCall, callback);
//   }
//
//   void cancel() {
//
//   }
//
//
//
// }