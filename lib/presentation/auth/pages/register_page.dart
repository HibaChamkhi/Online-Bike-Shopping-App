import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bike_shopping_appuntitled/core/colors/colors.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/pages/sign_in_page.dart';
import '../../../core/utils/used_functions.dart';
import '../../../injection.dart';
import '../bloc/register_bloc/register_bloc.dart';
import '../widgets/register_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<RegisterBloc>(),
        child: _buildBody(),);
  }

  Widget _buildBody() {
    return Center(
      child:
          BlocConsumer<RegisterBloc, RegisterState>(listener: (context, state) {
        if (state.message.isNotEmpty) {
          showSnackBar(context, state.message, Colors.red);
        } else if (state.registerStatus == RegisterStatus.success) {
          navigateToLoginScreen(context);
          showSnackBar(context, 'User registered successfully.',
              AppConstants.cornflowerBlueColor.withOpacity(0.8));
        }
      }, builder: (context, state) {
        return RegisterWidget(
            isLoading: state.registerStatus == RegisterStatus.loading,
            registerFunction: (name, email, number, password) {
              BlocProvider.of<RegisterBloc>(context).add(RegisterUserEvent(
                userName: name,
                email: email,
                password: password,
                number: number,
              ));
            });
      }),
    );
  }
}