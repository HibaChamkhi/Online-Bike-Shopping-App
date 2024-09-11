import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/widgets/discover_widget.dart';
import 'package:online_bike_shopping_appuntitled/presentation/profile/bloc/profile_bloc.dart';
import '../../../core/ui/styles/colors.dart';
import '../../../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.state});
  final ProfileState state;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // If profile status is 'loading', show a loader
    if (widget.state.profileStatus == ProfileStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // If user data is loaded, display the settings screen
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
              buildInfoRow('Username', widget.state.user!.userMetadata?["full_name"] ?? 'N/A'),
              buildInfoRow('Email', widget.state.user!.userMetadata?["email"] ?? 'N/A'),
              buildInfoRow('Phone', widget.state.user!.userMetadata?["phone_number"] ?? 'N/A'),
              buildInfoRow('Date of birth', '20/05/1990'),
              buildInfoRow('Address', '123 Royal Street, New York'),
              SizedBox(height: 40.h),
              InkWell(
                onTap: () async {
                  bool? confirmLogout = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.black, // Set the background color to black
                        title: const Text(
                          'Confirm Logout',
                          style: TextStyle(color: Colors.white), // Set title text color to white
                        ),
                        content: const Text(
                          'Are you sure you want to logout?',
                          style: TextStyle(color: Colors.white), // Set content text color to white
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false); // User pressed cancel
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white), // Set button text color to white
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true); // User pressed logout
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.white), // Set button text color to white
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  // If user confirmed, proceed with logout
                  if (confirmLogout == true) {
                    await supabase.auth.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const DiscoverWidget(),
                      ),
                    );
                  }
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
