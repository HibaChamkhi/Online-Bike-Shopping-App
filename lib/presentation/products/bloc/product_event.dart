part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductEvent {}
class GetAllFavoriteProductsByMeEvent extends ProductEvent {}

class AddProductToFavoriteEvent extends ProductEvent {
  final String productId;

  const AddProductToFavoriteEvent(this.productId);
}

class RemoveProductFromFavoriteEvent extends ProductEvent {
  final String productId;

  const RemoveProductFromFavoriteEvent(this.productId);
}