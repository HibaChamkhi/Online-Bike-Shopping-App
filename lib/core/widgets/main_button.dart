import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/core/colors/colors.dart';

class MainButton extends StatefulWidget {
  final String text;
  final bool isLoading;
  final Function() buttonFunction;

  const MainButton({
    super.key,
    required this.buttonFunction,
    required this.text,
    this.isLoading = false,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.buttonFunction,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h),
          backgroundColor: AppConstants.cornflowerBlueColor
      ),
      child: Container(
        alignment: Alignment.center,
        child: widget.isLoading
            ? const CircularProgressIndicator(
                color: Colors.black,
              )
            : Text(
                    widget.text,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
      ),
    );
  }
}
