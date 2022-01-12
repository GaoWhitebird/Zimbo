import 'package:intl/intl.dart';

String readTimestampHH(String timestamp) {
    var format = new DateFormat('hh:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000,);
    var time = '';

    time = format.format(date);

    return time;
}

String readTimestampYYYYDD(String timestamp) {
    var format = new DateFormat('MMM d, yyyy');
    var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000,);
    var dateStr = '';

    dateStr = format.format(date);

    return dateStr;
}