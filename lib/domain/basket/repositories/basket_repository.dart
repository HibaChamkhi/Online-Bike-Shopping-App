import 'package:dartz/dartz.dart';

import '../../products/models/product.dart';

abstract class BasketRepository {
  Future<Either<Exception, List<BikeModel>>> getBasket();

  Future<Either<Exception, String>> addToBasket(BikeModel bikeModel);

  Future<Either<Exception, Unit>> removeFromBasket(String bikeId);

  Future<Either<Exception, Unit>> updateQuantity(
    String bikeId,
    bool increase,
  );
}
