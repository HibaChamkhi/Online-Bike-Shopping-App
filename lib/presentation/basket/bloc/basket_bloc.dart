import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/domain/products/models/product.dart';

import '../../../core/utils/handle_product_load_result.dart';
import '../../../domain/basket/repositories/basket_repository.dart';

part 'basket_event.dart';
part 'basket_state.dart';
@injectable
class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketRepository repository;

  BasketBloc({
    required this.repository,
  }) : super(const BasketState()) {
    on<AddToBasketEvent>(_onAddToBasketEvent);
  }

  Future<void> _onAddToBasketEvent(
      AddToBasketEvent event, Emitter<BasketState> emit) async {
    final result = await repository.addToBasket(event.bikeModel);
    handleLoadResult<Unit, BasketState, BasketStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        BasketStatus? status,
      }) =>
          state.copyWith(
            messages: message,
            basketStatus: status,
          ),
      loadingStatus: BasketStatus.loading,
      successStatus: BasketStatus.success,
      errorStatus: BasketStatus.error,
    );
  }
}