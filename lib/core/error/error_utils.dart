import 'package:supabase_flutter/supabase_flutter.dart';

import '../network/network_info.dart';
import 'exception.dart';
import 'package:dartz/dartz.dart';



// Example of the handleError function
Future<T> handleError<T>(Future<T> Function() operation) async {
  try {
    return await operation();
  } catch (e) {
    if (e is AuthException) {
      throw ServerException(message: e.message);
    } else {
      throw ServerException(message: e.toString());
    }
  }
}

Future<Either<Exception, T>> performNetworkRequest<T>(
    Future<T> Function() operation,
    NetworkInfo networkInfo,
    ) async {
  if (await networkInfo.isConnected) {
    try {
      final result = await operation();
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  } else {
    return Left(Exception('Offline Failure'));
  }
}
