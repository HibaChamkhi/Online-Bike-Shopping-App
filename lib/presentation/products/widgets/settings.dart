import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/widgets/discover_widget.dart';

import '../../../core/colors/colors.dart';
import '../../../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const CircleAvatar(
        //   radius: 50,
        //   backgroundImage: NetworkImage(
        //       'https://via.placeholder.com/150'), // Replace with actual image
        //   child: Align(
        //     alignment: Alignment.bottomRight,
        //     child: CircleAvatar(
        //       backgroundColor: Colors.white,
        //       radius: 15,
        //       child: Icon(Icons.camera_alt, size: 15, color: Colors.black),
        //     ),
        //   ),
        // ),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppConstants.oxfordBlue.withOpacity(.8),
          ),
          child: Column(
            children: [
              buildInfoRow('Username', 'Amanda Jane'),
              buildInfoRow('Email', 'amanda@gmail.com'),
              buildInfoRow('Phone', '+65 2311 333'),
              buildInfoRow('Date of birth', '20/05/1990'),
              buildInfoRow('Address', '123 Royal Street, New York'),
              SizedBox(height: 40.h),
              InkWell(
                onTap: () async {
                  await supabase.auth.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const DiscoverWidget(),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 130.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.pictonBlue,
                        AppConstants.royalBlue.withOpacity(.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:  TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Text(
            value,
            style:  TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
