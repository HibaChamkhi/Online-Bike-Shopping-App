part of 'product_bloc.dart';

class ProductState extends UIState<List<BikeModel>> {
  final List<BikeModel> favoriteProductsByMe;
  final UIStatus favoriteProductStatus;

  const ProductState({
    super.status = UIStatus.loading,
    super.message = '',
    super.data = const [],
    this.favoriteProductsByMe = const [],
    this.favoriteProductStatus = UIStatus.loading,
  });

  @override
  ProductState copyWith({
    List<BikeModel>? data,
    List<BikeModel>? favoriteProductsByMe,
    UIStatus? status,
    UIStatus? favoriteProductStatus,
    String? message,
  }) {
    return ProductState(
      data: data ?? this.data,
      favoriteProductsByMe: favoriteProductsByMe ?? this.favoriteProductsByMe,
      status: status ?? this.status,
      favoriteProductStatus: favoriteProductStatus ?? this.favoriteProductStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    // data,
    favoriteProductsByMe,
    status,
    favoriteProductStatus,
    message,
  ];
}
