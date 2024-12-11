const String BASE_URL = "10.0.2.2:4000";
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}


Map<String, String> parseDate(String date) {
  // Simulate date parsing logic
  final dateTime = DateTime.parse(date);
  return {
    'date': "${dateTime.year}-${dateTime.month}-${dateTime.day}",
    'time': "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}",
  };
}
