import 'package:intl/intl.dart';

String sendDate({String? dateString}) {
  try {
    DateTime date = DateTime.parse(dateString!);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    return formatted;
  } catch (e) {
    return "";
  }
}


getDate(String startime, String endtime) {
  if (startime != null &&
      startime.isNotEmpty &&
      endtime != null &&
      endtime.isNotEmpty) {
    String date = DateFormat("dd MMMM yyyy").format(DateTime.parse(startime));
    String startTime = DateFormat("hh:mm a").format(DateTime.parse(startime));
    String endTime = DateFormat("hh:mm a").format(DateTime.parse(endtime));
    return date + " - " + startTime + " - " + endTime;
  } else {
    return "";
  }
}

getStartEndTIme(String startime, String endtime) {
  if (startime != null &&
      startime.isNotEmpty &&
      endtime != null &&
      endtime.isNotEmpty) {
    String startTime = DateFormat("hh:mm a").format(DateTime.parse(startime));
    String endTime = DateFormat("hh:mm a").format(DateTime.parse(endtime));
    return startTime + " - " + endTime;
  } else {
    return "";
  }
}

getDateString(String startime) {
  if (startime != null && startime.isNotEmpty) {
    String date = DateFormat("dd MMMM yyyy").format(DateTime.parse(startime));
    return date;
  } else {
    return "";
  }
}

