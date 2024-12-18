import 'package:flutter/cupertino.dart';

const String BASE_URL = "10.0.2.2:4000";
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}


Map<String, String> parseDate(String date) {
  // Simulate date parsing logic
  final dateTime = DateTime.parse(date).add(const Duration(hours: 1));
  return {
    'date': "${dateTime.year}-${dateTime.month}-${dateTime.day}",
    'time': "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
  };
}



