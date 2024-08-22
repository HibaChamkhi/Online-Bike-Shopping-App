part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<BikeModel> products;
  final ProductStatus productStatus;
  final String messages;

  const ProductState({
    this.products = const [],
    this.messages = "",
    this.productStatus = ProductStatus.loading,
  });

  ProductState copyWith({
    List<BikeModel>? products,
    ProductStatus? productStatus,
    String? messages,
  }) {
    return ProductState(
      products: products ?? this.products,
      messages: messages ?? this.messages,
      productStatus: productStatus ?? this.productStatus,
    );
  }

  @override
  List<Object> get props => [
        products,
        productStatus,
        messages,
      ];
}

enum ProductStatus { loading, success, error }
