import 'package:intl/intl.dart';

bool validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return false;
  }
  const pattern =
      r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}

String formatDate(DateTime date) {
  return DateFormat('MMMM dd, yyyy').format(date);
}
