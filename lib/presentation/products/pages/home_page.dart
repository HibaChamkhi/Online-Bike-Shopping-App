import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/home_widget.dart';

import '../../../core/di/injection.dart';
import '../../../core/model/ui_state.dart';
import '../../../data/products/data_sources/product_prefUtils.dart';
import '../bloc/product_bloc.dart';
import 'bottom_navigation_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()
        ..add(GetProductsEvent())
        ..add(GetAllFavoriteProductsByMeEvent()),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
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
      print("state ${state.favoriteProductsByMe}");
      return HomeScreen(state: state);
    });
  }
}
