
import 'package:dartz/dartz.dart';
import 'package:online_bike_shopping_appuntitled/data/products/models/product_model.dart';
import '../../../core/error/failures.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<BikeModel>>> getAllProducts();

}
