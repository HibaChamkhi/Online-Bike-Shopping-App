import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/input_validation/validate_email.dart';
import '../../../core/input_validation/validate_field.dart';
import '../../../core/input_validation/validate_number.dart';
import '../../../core/input_validation/validate_password.dart';

import '../../../core/ui/styles/colors.dart';
import '../../../core/ui/styles/theme.dart';
import '../../../core/ui/widgets/input_field.dart';
import '../../../core/ui/widgets/main_button.dart';
import '../../../core/utils/show_snack_bar.dart';

class RegisterWidget extends StatefulWidget {
  final bool isLoading;
  final Function(String, String, String, String) registerFunction;

  const RegisterWidget(
      {Key? key, required this.isLoading, required this.registerFunction})
      : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: AppTheme.padding,
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 30.h,
                      ),
                  ),
                  SizedBox(height: 40.h),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          InputField(
                              hintText: 'Full Name',
                              controller: _nameController,
                              validator: (value) =>
                                  validateField(value!, 'Name', context)),
                          SizedBox(height: 20.h),
                          InputField(
                              hintText: 'Phone number',
                              controller: _numberController,
                              validator: (value) => validateNumber(value!, context)),
                          SizedBox(height: 20.h),
                          InputField(
                              hintText: 'Email address',
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
                  ),
                  SizedBox(height: 100.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        MainButton(
                          buttonFunction: () {
                            validateCredentialsThenRegisterUser(context);
                          },
                          text: "Sign Up",
                          // isLoading: widget.isLoading
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("I'm already a member",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700])),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateToLoginScreen(context);
                              },
                              child: Text("Sign In",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppConstants.cornflowerBlueColor,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateCredentialsThenRegisterUser(context) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final String name;
      final String email;
      final String password;
      final String number;

      name = _nameController.text;
      email = _emailController.text;
      password = _passwordController.text;
      number = _numberController.text;

      widget.registerFunction(name, email, number, password);
    }
  }
}
