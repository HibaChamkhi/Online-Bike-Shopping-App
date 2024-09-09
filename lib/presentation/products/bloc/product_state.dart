part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<BikeModel> products;
  final List<String> favoriteProductsByMe;
  final ProductStatus productStatus;
  final String messages;

  const ProductState({
    this.products = const [],
    this.favoriteProductsByMe = const [],
    this.messages = "",
    this.productStatus = ProductStatus.loading,
  });

  ProductState copyWith({
    List<BikeModel>? products,
    List<String>? favoriteProductsByMe,
    ProductStatus? productStatus,
    String? messages,
  }) {
    return ProductState(
      products: products ?? this.products,
      favoriteProductsByMe: favoriteProductsByMe ?? this.favoriteProductsByMe,
      messages: messages ?? this.messages,
      productStatus: productStatus ?? this.productStatus,
    );
  }

  @override
  List<Object> get props => [
        products,
        favoriteProductsByMe,
        productStatus,
        messages,
      ];
}

enum ProductStatus { loading, success, error }
