import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/widgets/login_widget.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/widgets/register_widget.dart';

import '../../../core/colors/colors.dart';

class DiscoverWidget extends StatefulWidget {
  const DiscoverWidget({super.key});

  @override
  State<DiscoverWidget> createState() => _DiscoverWidgetState();
}

class _DiscoverWidgetState extends State<DiscoverWidget> {
  List<bool> isSelected = [true, false];
  bool isDeliverSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(top: 150.h),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 40.h),
                      child: Image.asset(
                        'assets/images/bicycl.png',
                      )),
                  Container(
                    width: 180.w,
                    child:  Text(
                      textAlign: TextAlign.center,
                      "Discover your first bike",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 25.sp),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
                    width: 300.w,
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Explore the bike you want to ride and all its accessories based on your interests",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSelectionButtons()
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppConstants.cornflowerBlueColor),
        // color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          _buildSelectionButton(
            label: 'Sign In',
            isSelected: isDeliverSelected,
            onTap: () {
              setState(() {
                isDeliverSelected = true;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginWidget(),
                  ),
                );
              });
            },
          ),
          _buildSelectionButton(
            label: 'Sign Up',
            isSelected: !isDeliverSelected,
            onTap: () {
              setState(() {
                isDeliverSelected = false;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RegisterWidget(),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppConstants.cornflowerBlueColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppConstants.cornflowerBlueColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
