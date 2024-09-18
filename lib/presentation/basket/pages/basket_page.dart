import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/basket/bloc/basket_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/model/ui_state.dart';
import '../widgets/shopping_cart.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key, required this.inBottomNav});

  final bool inBottomNav;

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BasketBloc>()..add(GetBasketEvent()),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<BasketBloc, BasketState>(listener: (context, state) {
      if (state.status == UIStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      } else if (state.status == UIStatus.loading) {
        Center(
          child: SizedBox(
            height: 60.h,
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFC67C4E),
              ),
            ),
          ),
        );
      }
    }, builder: (context, state) {
      print("data basket ${state.data}");
      return ShoppingCart(
        state: state,
        inBottomNav: widget.inBottomNav,
      );
    });
  }
}
