
import 'package:dartz/dartz.dart';
import '../models/product.dart';

abstract class ProductsRepository {
  Future<Either<Exception, List<BikeModel>>> getAllProducts();

}
