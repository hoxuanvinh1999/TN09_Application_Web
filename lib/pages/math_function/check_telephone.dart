bool checkTelephone(String telephone) {
  return RegExp(r'(^0?[0-9]{9}$)').hasMatch(telephone);
}
