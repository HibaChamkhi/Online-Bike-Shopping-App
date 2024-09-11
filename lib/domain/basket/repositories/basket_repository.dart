

import 'package:dartz/dartz.dart';

import '../../products/models/product.dart';

abstract class BasketRepository {
  Future<Either<Exception, List<BikeModel>>> getBasket() ;
  Future<Either<Exception, Unit>> addToBasket(BikeModel bikeModel) ;
}
