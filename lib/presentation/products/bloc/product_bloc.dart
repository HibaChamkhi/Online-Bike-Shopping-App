import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../core/utils/handle_product_load_result.dart';
import '../../../domain/products/models/product.dart';
import '../../../domain/products/repositories/products_repository.dart';

part 'product_event.dart';
part 'product_state.dart';





@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository repository;

  ProductBloc({
    required this.repository,
  }) : super(const ProductState()) {
    on<GetProductsEvent>(_onGetProductsEvent);
  }

  Future<void> _onGetProductsEvent(
      GetProductsEvent event, Emitter<ProductState> emit) async {

    final result = await repository.getAllProducts();

    handleLoadResult<List<BikeModel>, ProductState, ProductStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        List<BikeModel>? data,
        String? message,
        ProductStatus? status,
      }) =>
          state.copyWith(
            products: data ?? [],
            messages: message,
            productStatus: status,
          ),
      loadingStatus: ProductStatus.loading,
      successStatus: ProductStatus.success,
      errorStatus: ProductStatus.error,
    );
  }

}

  // Future<void> _onGetProductsEvent(
  //     GetProductsEvent event,
  //     Emitter<ProductState> emit,
  //     ) async {
  //   emit(state.copyWith(productStatus: ProductStatus.loading, products: []));
  //   final result = await repository.getAllProducts();
  //   _handleProductLoadResult(result, emit);
  // }

  // void _handleProductLoadResult(
  //     Either<Exception, List<BikeModel>> result,
  //     Emitter<ProductState> emit,
  //     ) {
  //   result.fold(
  //         (failure) {
  //       final errorMessage = mapExceptionToMessage(failure);
  //       emit(state.copyWith(
  //         productStatus: ProductStatus.error,
  //         messages: errorMessage,
  //       ));
  //     },
  //         (products) {
  //       emit(state.copyWith(
  //         productStatus: ProductStatus.success,
  //         products: products,
  //       ));
  //     },
  //   );
  // }


