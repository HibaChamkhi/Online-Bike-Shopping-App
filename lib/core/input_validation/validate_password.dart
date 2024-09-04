import 'package:flutter/cupertino.dart';

String? validatePassword(
    String password, BuildContext context) {

  if (password.trim().isEmpty) {
    return "Password can't be empty";
  }
  if (password.trim().length < 6 || password.trim().length > 16) {
    return "Password must contain at least 6 and at most 16 characters";
  }

  if (!password.contains(RegExp(r'\d')) ||
      !password.contains(RegExp(r'[A-Z]')) ||
      !password.contains(RegExp(r'[a-z]')) ||
      !RegExp(r'[.!@#$%&*()_+=|<>?{}\[\]~-]').hasMatch(password.trim())) {
    return "Example Password: 'erZ45H@3PK789'";
  }
  return null;
}