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
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}

Future<Either<Exception, T>> performNetworkRequest<T>(
    Future<T> Function() networkOperation,
    NetworkInfo networkInfo, {
      Future<T> Function()? localOperation,
    }) async {
  if (await networkInfo.isConnected) {
    try {
      final result = await networkOperation();
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  } else {
    if (localOperation != null) {
      try {
        final result = await localOperation();
        return Right(result);
      } catch (e) {
        return Left(Exception('Offline Failure: ${e.toString()}'));
      }
    } else {
      return Left(Exception('No internet connection and no local data available'));
    }
  }
}


