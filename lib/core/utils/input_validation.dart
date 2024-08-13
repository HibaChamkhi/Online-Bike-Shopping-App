import 'package:flutter/material.dart';

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

String? validatePasswordForLogin(String password, BuildContext context) {

  if (password.trim().isEmpty) {
    return "Password can't be empty";
  }
  return null;
}
String? validateEmptyField(
    String value, String hintText, BuildContext context) {

  if (value.trim().isEmpty) {
    return "$hintText can't be empty";
  }
  return null;
}

String? validateEmail(String value, BuildContext context) {

  // Regular expression for email validation
  final RegExp emailRegex = RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  // Remove spaces from the email

  if (value.trim().isEmpty) {
    return "Enter an email address";
  } else if (!emailRegex.hasMatch(value.trim())) {
    return "Enter a valid email address";
  }

  return null; // Return null if email is valid
}

String? validateCheckbox(bool value, BuildContext context) {
  if (!value) {
    return "This field must be checked";
  }
  return null;
}
