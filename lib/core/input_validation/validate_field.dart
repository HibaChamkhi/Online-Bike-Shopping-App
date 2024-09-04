import 'package:flutter/cupertino.dart';

String? validateField(String value, hintText, BuildContext context) {

  if (value.trim().isEmpty) {
    return "$hintText can't be empty";
  }
  if (value.trim().length < 3 || value.trim().length > 30) {
    return "$hintText must be between 3 and 30 characters";
  }
  if (!value.trim().contains(RegExp(r'[a-zA-Z\u0600-\u06FF\s]+$')) ||
      value[0] == ' ') {
    return "This value is not valid";
  }
  if (value.trim().contains(RegExp(r'\d')) ||
      RegExp(r'[.,;!@#$%&*()_+=|<>?{}\[\]~-]').hasMatch(value.trim())) {
    return "The field must not contain any special characters";
  }
  return null;
}