part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object?> get props => [];
}

class AddToBasketEvent extends BasketEvent {
  final BikeModel bikeModel;

  const AddToBasketEvent(this.bikeModel);
}
