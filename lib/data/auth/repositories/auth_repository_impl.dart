import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../core/error/error_utils.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Exception, Unit>> register({
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    return performNetworkRequest(
          () => remoteDataSource.signUp(
          userName: userName,
          email: email,
          number: phoneNumber,
          password: password),
      networkInfo,
    );
  }

  @override
  Future<Either<Exception, Unit>> signInUser(
      String email, String password) async {
    return performNetworkRequest(
          () => remoteDataSource.signInUser(email, password),
      networkInfo,
    );
  }
}
