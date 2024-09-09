part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<BikeModel> products;
  final List<BikeModel> favoriteProductsByMe;
  final ProductStatus productStatus;
  final FavoriteProductStatus favoriteProductStatus;
  final String messages;

  const ProductState({
    this.products = const [],
    this.favoriteProductsByMe = const [],
    this.messages = "",
    this.productStatus = ProductStatus.loading,
    this.favoriteProductStatus = FavoriteProductStatus.loading,
  });

  ProductState copyWith({
    List<BikeModel>? products,
    List<BikeModel>? favoriteProductsByMe,
    ProductStatus? productStatus,
    FavoriteProductStatus? favoriteProductStatus,
    String? messages,
  }) {
    return ProductState(
      products: products ?? this.products,
      favoriteProductStatus:
          favoriteProductStatus ?? this.favoriteProductStatus,
      favoriteProductsByMe: favoriteProductsByMe ?? this.favoriteProductsByMe,
      messages: messages ?? this.messages,
      productStatus: productStatus ?? this.productStatus,
    );
  }

  @override
  List<Object> get props => [
        products,
        favoriteProductsByMe,
        favoriteProductStatus,
        productStatus,
        messages,
      ];
}

enum ProductStatus { loading, success, error }

enum FavoriteProductStatus { loading, success, error }
