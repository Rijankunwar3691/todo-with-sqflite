class DateTimeConverter {
  stringToDateTime(String dateTime) {
    print(dateTime);
    DateTime convertedDateTime = DateTime.parse(dateTime);
    print(convertedDateTime);

    return convertedDateTime;
  }
}
