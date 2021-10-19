String getDateText({required DateTime date}) {
  if (date == null) {
    return 'Select Date';
  } else {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '${day}/${month}/${year}';
  }
}
