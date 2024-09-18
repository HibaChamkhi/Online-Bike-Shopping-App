import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/domain/products/models/product.dart';

import '../../../core/model/ui_state.dart';
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
    on<GetBasketEvent>(_onGetBasketEvent);
    on<RemoveFromBasketEvent>(_onRemoveFromBasketEvent);
    on<UpdateQuantityEvent>(_onUpdateQuantityEvent);
  }

  Future<void> _onAddToBasketEvent(
      AddToBasketEvent event, Emitter<BasketState> emit) async {
    final result = await repository.addToBasket(event.bikeModel);
    final newData =  [...?state.data, event.bikeModel] ;
    handleLoadResult<String, BasketState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        String? data,
        String? message,
        UIStatus? status,
      }) {
        print('_onAddToBasketEvent $newData');

        return state.copyWith(
          status: status,
          message: data,
          data:newData,
        );

      },
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }



  Future<void> _onRemoveFromBasketEvent(
      RemoveFromBasketEvent event, Emitter<BasketState> emit) async {
    final result = await repository.removeFromBasket(event.bikeId);
    handleLoadResult<Unit, BasketState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            status: status,
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }

  Future<void> _onUpdateQuantityEvent(
      UpdateQuantityEvent event, Emitter<BasketState> emit) async {
    final result = await repository.updateQuantity(event.bikeId,event.increase);
    handleLoadResult<Unit, BasketState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            status: status,
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }

  Future<void> _onGetBasketEvent(
      GetBasketEvent event, Emitter<BasketState> emit) async {
    print("_onGetBasketEvent1 ${state.data}");
    final result = await repository.getBasket();
    handleLoadResult<List<BikeModel>, BasketState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        List<BikeModel>? data,
        String? message,
        UIStatus? status,
      })
      {
        print("_onGetBasketEvent2 ${data}");

        return state.copyWith(
        status: status,
        message: message,
        data: data,
      )
        ;},
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }
}

