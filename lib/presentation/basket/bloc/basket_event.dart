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

class RemoveFromBasketEvent extends BasketEvent {
  final String bikeId;

  const RemoveFromBasketEvent(this.bikeId);
}

class UpdateQuantityEvent extends BasketEvent {
  final String bikeId;
  final bool increase;
  const UpdateQuantityEvent(this.bikeId, this.increase);
}

class GetBasketEvent extends BasketEvent {}
