import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/widgets/login_widget.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/pages/home_page.dart';
import '../../../core/di/injection.dart';
import '../../../core/model/ui_state.dart';
import '../../../core/ui/styles/colors.dart';
import '../../products/pages/bottom_navigation_bar_widget.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginBloc>()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == UIStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          else if (state.status == UIStatus.loading) {
            Center(
              child: SizedBox(
                height: 60.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppConstants.cornflowerBlueColor,
                  ),
                ),
              ),
            );
          } else if (state.status == UIStatus.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BottomNavigationBarPage(),
                ));
            });
          }


        },
        builder: (context, state) {
          return const LoginWidget();
        },
      ),
    );
  }
}
