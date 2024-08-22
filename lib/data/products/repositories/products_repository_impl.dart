import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/core/error/failures.dart';
import 'package:online_bike_shopping_appuntitled/data/products/models/product_model.dart';
import '../../../../core/network/network_info.dart';
import '../../../core/error/exception.dart';
import '../../../domain/products/repositories/products_repository.dart';
import '../data_sources/products_remote_data_source.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<BikeModel>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse =
        await remoteDataSource.getAllProducts();
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
