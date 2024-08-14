import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/widgets/register_widget.dart';

import '../../../core/colors/colors.dart';
import '../../../core/colors/theme.dart';
import '../../../core/utils/input_validation.dart';
import '../../../core/widgets/input_field.dart';
import '../../../core/widgets/main_button.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: AppTheme.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    size: 30.h,
                  )),
              SizedBox(height: 40.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello again",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 200.w,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Welcome back you've been missed!",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    InputField(
                        hintText: 'example@email.com',
                        controller: _emailController,
                        validator: (value) => validateEmail(value!, context)),
                    SizedBox(height: 20.h),
                    InputField(
                      hintText: 'Password',
                      isPassword: true,
                      controller: _passwordController,
                      validator: (value) => validatePassword(value!, context),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              MainButton(
                buttonFunction: () {},
                text: "Sign In",
                // isLoading: widget.isLoading
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "I'm new user ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Register now',
                          style: const TextStyle(
                              color: AppConstants.cornflowerBlueColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Register now tapped!');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterWidget(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
