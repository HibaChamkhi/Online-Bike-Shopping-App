part of 'basket_bloc.dart';

class BasketState extends Equatable {
  final BasketStatus basketStatus;
  final String messages;

  const BasketState({
    this.messages = "",
    this.basketStatus = BasketStatus.loading,
  });

  BasketState copyWith({
    BasketStatus? basketStatus,
    String? messages,
  }) {
    return BasketState(
      messages: messages ?? this.messages,
      basketStatus: basketStatus ?? this.basketStatus,
    );
  }

  @override
  List<Object> get props => [
        basketStatus,
        messages,
      ];
}

enum BasketStatus { loading, success, error }
