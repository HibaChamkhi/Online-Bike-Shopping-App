import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/data/products/dtos/product_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../domain/products/models/product.dart';



@injectable
class ProductsRemoteDataSource {
  ProductsRemoteDataSource();
  final supabase = Supabase.instance.client;

  @override
  Future<List<BikeModel>> getAllProducts() async {
    return handleError(() async {
      List<Map<String, dynamic>> response =
      await supabase.from('products').select('*');
      var products = response
          .map((productData) => BikeDto.fromJson(productData).toModel())
          .toList();
      return products;
    });
  }
}
