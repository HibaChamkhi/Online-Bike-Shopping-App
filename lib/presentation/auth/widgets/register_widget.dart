import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/core/colors/theme.dart';
import 'package:online_bike_shopping_appuntitled/core/widgets/input_field.dart';

import '../../../core/utils/input_validation.dart';
import '../../../core/widgets/main_button.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _nameController = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Create account",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    InputField(
                        hintText: 'Full Name',
                        prefixIcon: 'assets/icons/user_icon.svg',
                        controller: _nameController,
                        validator: (value) =>
                            validateField(value!, 'Name', context)),
                    SizedBox(height: 20.h),
                    InputField(
                        hintText: 'example@email.com',
                        prefixIcon: 'assets/icons/email_icon.svg',
                        controller: _emailController,
                        validator: (value) => validateEmail(value!, context)),
                    SizedBox(height: 20.h),
                    InputField(
                      hintText: 'Password',
                      prefixIcon: 'assets/icons/password_icon.svg',
                      isPassword: true,
                      controller: _passwordController,
                      validator: (value) => validatePassword(value!, context),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              MainButton(
                buttonFunction: () {
                  validateCredentialsThenRegisterUser(context);
                },
                text: "Sign Up",
                // isLoading: widget.isLoading
              ),
              SizedBox(height: 50.h),
            ],
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

      name = _nameController.text;
      email = _emailController.text;
      password = _passwordController.text;

      // widget.registerFunction(name, email, password);
    }
  }
}
