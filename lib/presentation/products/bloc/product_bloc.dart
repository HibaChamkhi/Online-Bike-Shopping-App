import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../core/model/ui_state.dart';
import '../../../core/utils/handle_product_load_result.dart';
import '../../../domain/basket/repositories/basket_repository.dart';
import '../../../domain/products/models/product.dart';
import '../../../domain/products/repositories/products_repository.dart';

part 'product_event.dart';

part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository repository;
  // final BasketRepository basketRepository;

  ProductBloc({
    // required this.basketRepository,
    required this.repository,
  }) : super(const ProductState()) {
    on<GetProductsEvent>(_onGetProductsEvent);
    on<GetAllFavoriteProductsByMeEvent>(_onGetAllFavoriteProductsByMeEvent);
    on<AddProductToFavoriteEvent>(_onAddProductToFavoriteEvent);
    on<RemoveProductFromFavoriteEvent>(_onRemoveProductFromFavoriteEvent);
    // on<AddToBasketEvent>(_onAddToBasketEvent);
  }

  // Future<void> _onAddToBasketEvent(
  //     AddToBasketEvent event, Emitter<ProductState> emit) async {
  //   final result = await basketRepository.addToBasket(event.bikeModel);
  //
  //   handleLoadResult<String, ProductState, UIStatus>(
  //     result: result,
  //     emit: emit,
  //     state: state,
  //     copyWith: ({
  //       String? data,
  //       String? message,
  //       UIStatus? status,
  //     }) =>
  //         state.copyWith(
  //           status: status,
  //           message: message,
  //         ),
  //     loadingStatus: UIStatus.loading,
  //     successStatus: UIStatus.success,
  //     errorStatus: UIStatus.error,
  //   );
  // }

  Future<void> _onGetProductsEvent(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    final result = await repository.getAllProducts();

    handleLoadResult<List<BikeModel>, ProductState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        List<BikeModel>? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            data: data,
            status: status,
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }

  Future<void> _onGetAllFavoriteProductsByMeEvent(
      GetAllFavoriteProductsByMeEvent event, Emitter<ProductState> emit) async {
    final result = await repository.getAllFavoriteProductsByMe();

    handleLoadResult<List<BikeModel>, ProductState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        List<BikeModel>? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            favoriteProductsByMe: data,
            favoriteProductStatus: status,
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }

  Future<void> _onAddProductToFavoriteEvent(
      AddProductToFavoriteEvent event, Emitter<ProductState> emit) async {
    final result = await repository.addProductToFavorite(event.productId);

    handleLoadResult<Unit, ProductState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            status: status,
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }

  Future<void> _onRemoveProductFromFavoriteEvent(
      RemoveProductFromFavoriteEvent event, Emitter<ProductState> emit) async {
    final result = await repository.removeProductFromFavorite(event.productId);

    handleLoadResult<Unit, ProductState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            status: status,
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }
}
