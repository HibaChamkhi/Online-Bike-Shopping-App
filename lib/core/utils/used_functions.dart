import '../error/failures.dart';

String? mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure _:
      return failure.message;
    default:
      return 'Unexpected Error, please try again later';
  }
}
