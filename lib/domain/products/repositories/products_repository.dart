
import 'package:dartz/dartz.dart';
import '../models/product.dart';

abstract class ProductsRepository {
  Future<Either<Exception, List<BikeModel>>> getAllProducts();
  Future<Either<Exception, List<String>>> getAllFavoriteProductsByMe() ;
  Future<Either<Exception, Unit>> addProductToFavorite(String productId);
  Future<Either<Exception, Unit>> removeProductFromFavorite(String productId);

}
