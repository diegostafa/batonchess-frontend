import "package:intl/intl.dart";

String prettyId(String id) => id.substring(0, 8).toUpperCase();

String prettyDateTime(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat("EEEE d MMM HH:mm:ss").format(date);
}

String prettyTime(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat("HH:mm:ss").format(date);
}
