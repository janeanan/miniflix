import 'package:intl/intl.dart';

class UiConfiguration {
  static const String baseImage = "https://image.tmdb.org/t/p/original/";
}

class DateFormatter {
  static final _thaiDateFormat = DateFormat('EEE, M/d/y');

  static String formatDateTime(String isoDateTime) {
    final dateTime = DateTime.parse(isoDateTime).toLocal();
    return _thaiDateFormat.format(dateTime);
  }
}
