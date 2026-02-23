import 'package:intl/intl.dart';

String formatDateString(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  } catch (e) {
    print("Error parsing date: $e");
    return "";
  }
}


String formatDateTime(String inputDate) {
  try {
    DateTime dateTime = DateTime.parse(inputDate).toLocal();
    return DateFormat("dd/MM/yyyy | HH:mm").format(dateTime);
  } catch (e) {
    print("Error formatting date: $e");
    return "Invalid date";
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}