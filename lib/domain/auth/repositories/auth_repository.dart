import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class AuthRepository {

  Future<Either<Failure, Unit>> register(
      {
        required String userName,
        required String email,
        required String phoneNumber,
        required String password,
      });

  Future<Either<Failure, Unit>> signInUser(String email, String password) ;
}
