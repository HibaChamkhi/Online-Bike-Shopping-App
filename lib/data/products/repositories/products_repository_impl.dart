import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../../../core/error/error_utils.dart';
import '../../../domain/products/models/product.dart';
import '../../../domain/products/repositories/products_repository.dart';
import '../data_sources/products_remote_data_source.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Exception, List<BikeModel>>> getAllProducts() async {
    return performNetworkRequest(
          () => remoteDataSource.getAllProducts(),
      networkInfo,
    );
  }

  @override
  Future<Either<Exception, List<String>>> getAllFavoriteProductsByMe() async {
    return performNetworkRequest(
          () => remoteDataSource.getAllFavoriteProductsByMe(),
      networkInfo,
    );
  }

  @override
  Future<Either<Exception, Unit>> addProductToFavorite(String productId) async {
    return performNetworkRequest(
          () => remoteDataSource.addProductToFavorite(productId),
      networkInfo,
    );
  }

  @override
  Future<Either<Exception, Unit>> removeProductFromFavorite(String productId) async {
    return performNetworkRequest(
          () => remoteDataSource.removeProductFromFavorite(productId),
      networkInfo,
    );
  }
}
