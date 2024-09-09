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
    on<GetAllFavoriteProductsByMeEvent>(_onGetAllFavoriteProductsByMeEvent);
    on<AddProductToFavoriteEvent>(_onAddProductToFavoriteEvent);
    on<RemoveProductFromFavoriteEvent>(_onRemoveProductFromFavoriteEvent);
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

  Future<void> _onGetAllFavoriteProductsByMeEvent(
    GetAllFavoriteProductsByMeEvent event, Emitter<ProductState> emit) async {
    final result = await repository.getAllFavoriteProductsByMe();
    handleLoadResult<List<BikeModel>, ProductState, FavoriteProductStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        List<BikeModel>? data,
        String? message,
        FavoriteProductStatus? status,
      }) =>
          state.copyWith(
            favoriteProductsByMe: data ?? [],
            messages: message,
            favoriteProductStatus: status,
          ),
      loadingStatus: FavoriteProductStatus.loading,
      successStatus: FavoriteProductStatus.success,
      errorStatus: FavoriteProductStatus.error,
    );
  }

  Future<void> _onAddProductToFavoriteEvent(
      AddProductToFavoriteEvent event, Emitter<ProductState> emit) async {
    final result = await repository.addProductToFavorite(event.productId);

    handleLoadResult<Unit, ProductState, ProductStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        ProductStatus? status,
      }) =>
          state.copyWith(
            messages: message,
            productStatus: status,
          ),
      loadingStatus: ProductStatus.loading,
      successStatus: ProductStatus.success,
      errorStatus: ProductStatus.error,
    );
  }

  Future<void> _onRemoveProductFromFavoriteEvent(
      RemoveProductFromFavoriteEvent event, Emitter<ProductState> emit) async {
    final result = await repository.removeProductFromFavorite(event.productId);

    handleLoadResult<Unit, ProductState, ProductStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        ProductStatus? status,
      }) =>
          state.copyWith(
            messages: message,
            productStatus: status,
          ),
      loadingStatus: ProductStatus.loading,
      successStatus: ProductStatus.success,
      errorStatus: ProductStatus.error,
    );
  }
}



