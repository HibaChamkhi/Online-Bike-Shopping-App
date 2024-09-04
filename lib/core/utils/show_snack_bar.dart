import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../presentation/auth/pages/sign_in_page.dart';
void showSnackBar(
    BuildContext context, String message, Color snackBarBackgroundColor,
    {int height = 0, void Function()? onSnackBarCompleted}) async {
  final snackBar = SnackBar(
    backgroundColor: snackBarBackgroundColor,
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(bottom: 50.h + height, right: 20, left: 20),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBar)
      .closed
      .whenComplete(onSnackBarCompleted ?? () {});
}

navigateToLoginScreen(BuildContext context) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return const SignInPage();
  }));
}
