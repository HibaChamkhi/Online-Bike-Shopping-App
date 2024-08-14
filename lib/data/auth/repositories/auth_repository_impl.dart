import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
@Injectable(as: AuthRepositoryImpl)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> register({
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.signUp(
            userName: userName,
            email: email,
            number: phoneNumber,
            password: password);
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
