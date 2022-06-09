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

String readDateYYYYMMDD(DateTime dateTime){
  var format = new DateFormat('yyyy/MM/dd');
  var dateStr = '';

  dateStr = format.format(dateTime);

  return dateStr;
}

String readDateYYYYMM(DateTime dateTime){
  var format = new DateFormat('yyyy/MM');
  var dateStr = '';

  dateStr = format.format(dateTime);

  return dateStr;
}

String readTimestampYYYYMMDD(String timestamp){
  var format = new DateFormat('yyyy/MM/dd');
  var dateTime = new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000,);
  var dateStr = '';

  dateStr = format.format(dateTime);

  return dateStr;
}