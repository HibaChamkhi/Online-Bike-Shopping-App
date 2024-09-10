import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/profile/repositories/profile_repository.dart';
import '../data_sources/profile_local_data_source.dart';
import '../data_sources/profile_remote_data_source.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Exception, User>> getCurrentUser() async {
    return performNetworkRequest<User>(
      () => remoteDataSource.getCurrentUser(),
      networkInfo,
    );
  }

}
