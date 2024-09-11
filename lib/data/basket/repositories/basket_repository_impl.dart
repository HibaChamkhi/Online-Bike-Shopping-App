import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/basket/repositories/basket_repository.dart';
import '../../../domain/products/models/product.dart';
import '../data_sources/basket_local_data_source.dart';
import '../data_sources/basket_remote_data_source.dart';


@Injectable(as: BasketRepository)
class BasketRepositoryImpl implements BasketRepository {
  final BasketRemoteDataSource remoteDataSource;
  final BasketLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BasketRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Exception, List<BikeModel>>> getBasket() async {
    return performNetworkRequest<List<BikeModel>>(
          () => remoteDataSource.fetchBasketProductFromSupabase(),
      networkInfo,
      localOperation: () async {
        return localDataSource.getBasketFromCache() ;
      },
    );
  }

  @override
  Future<Either<Exception,Unit>> addToBasket(BikeModel bikeModel) async {
    return performNetworkRequest<Unit>(
          () => remoteDataSource.addToBasket(bikeModel: bikeModel),
      networkInfo,
    );
  }
}

