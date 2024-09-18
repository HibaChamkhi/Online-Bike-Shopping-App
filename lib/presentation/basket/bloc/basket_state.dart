part of 'basket_bloc.dart';

class BasketState extends UIState<List<BikeModel>> {
  const BasketState({
    super.status,
    super.message,
    super.data = const [],
  });

  @override
  BasketState copyWith({
    UIStatus? status,
    String? message,
    List<BikeModel>? data,
  }) {
    return BasketState(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
