import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String getArabicRelativeTimeString() {
    DateTime now = DateTime.now();

    Duration difference = now.difference(this);
    int daysDifference = difference.inDays;

    switch (daysDifference) {
      case 0:
        return "اليوم";
      case 1:
        return "منذ يوم";
      case 2:
        return "منذ يومين";
      default:
        return "منذ $daysDifference أيام";
    }
  }

  String formatToArabicTime() {
    final timeFormat = DateFormat('hh:mm a', 'ar');
    return timeFormat.format(this);
  }
}
