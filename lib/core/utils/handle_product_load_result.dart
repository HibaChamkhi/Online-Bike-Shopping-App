import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/map_exception_to_message.dart';

void handleLoadResult<T, S, E>({
  required Either<Exception, T> result,
  required Emitter<S> emit,
  required S state,
  required S Function({
  T? data,
  String? message,
  E? status,
  }) copyWith,
  required E loadingStatus,
  required E successStatus,
  required E errorStatus,
}) {

  // Emit loading state
  emit(copyWith(
    status: loadingStatus,
  ));
  // Handle the result
  result.fold(
        (failure) {
          print(failure);
          final errorMessage = mapExceptionToMessage(failure);
      emit(copyWith(
        message: errorMessage,
        status: errorStatus,
      ));
    },
        (data) {
      emit(copyWith(
        data: data,
        status: successStatus,
      ));
    },
  );
}
