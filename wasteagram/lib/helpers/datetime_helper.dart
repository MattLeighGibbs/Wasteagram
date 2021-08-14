import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatetimeHelper {
  static String timeStampToDateTimeString(Object object) {
    Timestamp? stamp = object as Timestamp?;
    if (stamp == null) {
      return "NULL";
    } else {
      return formatDateTime(timeStampToDateTime(stamp)).toString();
    }
  }

  static DateTime timeStampToDateTime(Timestamp stamp) {
    String stampAsDateString = stamp.toDate().toString();
    return DateTime.parse(stampAsDateString);
  }

  static String formatDateTime(DateTime dt) {
    return DateFormat.yMMMd().format(dt);
  }
}
