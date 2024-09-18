import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/di/injection.dart';
import '../../../core/model/ui_state.dart';
import '../../products/bloc/product_bloc.dart';
import '../widgets/registered_products_widget.dart';

class RegisteredProductPage extends StatefulWidget {
  const RegisteredProductPage({
    super.key,
  });

  @override
  State<RegisteredProductPage> createState() => _RegisteredProductPageState();
}

class _RegisteredProductPageState extends State<RegisteredProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()
        ..add(GetAllFavoriteProductsByMeEvent()),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
      if (state.status == UIStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      } else if (state.status ==
          UIStatus.loading) {
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
      return RegisteredProductWidgets(state: state);
    });
  }
}
