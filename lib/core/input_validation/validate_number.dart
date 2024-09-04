import 'package:flutter/cupertino.dart';

String? validateNumber(String value, BuildContext context) {
  if (value.trim().isEmpty) {
    return "Phone number can't be empty";
  }
  return null;
}