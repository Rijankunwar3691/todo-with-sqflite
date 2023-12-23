import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todowithmvc/model/date_time_converter.dart';

final dateTimeConverterProvider = Provider<DateTimeConverter>((ref) {
  return DateTimeConverter();
});
