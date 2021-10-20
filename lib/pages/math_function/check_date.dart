import 'package:intl/intl.dart';

String checkday({required DateTime check_date}) {
  String result = '';
  String check_date_format = DateFormat('EEEE').format(check_date);
  switch (check_date_format) {
    case 'Monday':
      {
        result = 'Lundi';
        break;
      }
    case 'Tuesday':
      {
        result = 'Mardi';
        break;
      }
    case 'Wednesday':
      {
        result = 'Mercredi';
        break;
      }
    case 'Thursday':
      {
        result = 'Jeudi';
        break;
      }
    case 'Friday':
      {
        result = 'Vendredi';
        break;
      }
    case 'Saturday':
      {
        result = 'Samedi';
        break;
      }
    case 'Sunday':
      {
        result = 'Dimanche';
        break;
      }
    default:
      {
        result = 'Lundi';
        break;
      }
  }
  return result;
}
