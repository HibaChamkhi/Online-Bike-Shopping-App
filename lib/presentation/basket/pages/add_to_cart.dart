import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/basket/bloc/basket_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/model/ui_state.dart';
import '../../../core/ui/styles/colors.dart';
import '../../../domain/products/models/product.dart';
import '../../products/bloc/product_bloc.dart';
import '../widgets/shopping_cart.dart';
import 'basket_page.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key, required this.bike});

  final BikeModel bike;

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BasketBloc>(),
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
      } else if (state.message == "success") {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const BasketPage(
                    inBottomNav: false,
                  )),
        );
      } else if (state.status == UIStatus.loading) {
        print("logggggggg");
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
      return InkWell(
        onTap: () {
          setState(() {
            BlocProvider.of<BasketBloc>(context)
                .add(AddToBasketEvent(widget.bike));
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
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
            'Add to Cart',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }
}
