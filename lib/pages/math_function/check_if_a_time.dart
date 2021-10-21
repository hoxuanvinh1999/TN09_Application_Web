bool check_if_a_time({required String check}) {
  if (check.length != 5) {
    return false;
  } else {
    if (check[2] != ':') {
      return false;
    }
    if (int.tryParse(check.substring(0, 2)) == null ||
        int.tryParse(check.substring(3, 5)) == null) {
      return false;
    }
    int hour = int.parse(check.substring(0, 2));
    int minute = int.parse(check.substring(3, 5));
    if (hour > 24 || hour < 0 || minute > 60 || minute < 0) {
      return false;
    }
  }
  return true;
}
