import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/data/products/data_sources/products_local_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/products/models/product.dart';
import '../../../domain/products/repositories/products_repository.dart';
import '../data_sources/products_remote_data_source.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Exception, List<BikeModel>>> getAllProducts() async {
    return performNetworkRequest<List<BikeModel>>(
          () => remoteDataSource.fetchProductsFromSupabase(),
      networkInfo,
      localOperation: () async {
        return localDataSource.fetchProductsFromCache() ;
      },
    );
  }

  @override
  Future<Either<Exception, List<BikeModel>>> getAllFavoriteProductsByMe() async {
    return performNetworkRequest<List<BikeModel>>(
          () => remoteDataSource.getAllFavoriteProductsByMe(),
      networkInfo,
    );
  }

  @override
  Future<Either<Exception, Unit>> addProductToFavorite(String productId) async {
    return     performNetworkRequest<Unit>(
          () => remoteDataSource.addProductToFavorite(productId),
      networkInfo,
    );
  }

  @override
  Future<Either<Exception, Unit>> removeProductFromFavorite(String productId) async {
    return performNetworkRequest<Unit>(
          () => remoteDataSource.removeProductFromFavorite(productId),
      networkInfo,
    );
  }


}

