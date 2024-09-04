import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/map_exception_to_message.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../data/products/dtos/product_dto.dart';
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
    on<ProductEvent>((event, emit) async {
      if (event is GetProductsEvent) {
        emit(
            state.copyWith(productStatus: ProductStatus.loading, products: []));
        final failureOrSuggestedProducts = await repository.getAllProducts();
        failureOrSuggestedProducts.fold(
            (suggestedOrFailure) => emit(state.copyWith(
                  messages: mapExceptionToMessage(suggestedOrFailure),
                  productStatus: ProductStatus.error,
                )),
            (newsValue) => emit(state.copyWith(
                productStatus: ProductStatus.success, products: newsValue)));
      }
    });
  }
}
