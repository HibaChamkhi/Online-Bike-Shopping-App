import 'package:dartz/dartz.dart';


abstract class AuthRepository {
  Future<Either<Exception, Unit>> register({
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
  });

  Future<Either<Exception, Unit>> signInUser(String email, String password);
}
