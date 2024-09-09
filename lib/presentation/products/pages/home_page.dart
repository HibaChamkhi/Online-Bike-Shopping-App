import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../bloc/product_bloc.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/home_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key,});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()..add(GetProductsEvent())..add(GetAllFavoriteProductsByMeEvent()),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.productStatus == ProductStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.messages),
              ),
            );
          }
          else if (state.productStatus == ProductStatus.loading) {
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
        },
        builder: (context, state) {
          print(state.products);
          return   BottomNavigationBarWidget(products:state.products, favoriteProductsByMe:state.favoriteProductsByMe,loading: state.productStatus,);
        });
  }

// Future<void> _onRefresh(BuildContext context) async {
//   BlocProvider.of<ProductBloc>(context)
//       .add(const GetAllProductsEvent());
// }
}
