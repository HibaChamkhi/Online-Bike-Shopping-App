import 'package:online_bike_shopping_appuntitled/data/products/models/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/exception.dart';

abstract class ProductsRemoteDataSource {
  Future<List<BikeModel>> getAllProducts();
}

@Injectable(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  ProductsRemoteDataSourceImpl();
  final supabase = Supabase.instance.client;

  @override
  Future<List<BikeModel>> getAllProducts()async {
    try {
      List<Map<String, dynamic>> response =
      await supabase.from('products').select('*');
      var coffees = response
          .map((coffeeData) => BikeModel.fromJson(coffeeData))
          .toList();
      print("coffees ${coffees}");
      return coffees;
    } catch (e) {
      print("error ${e}");

      throw ServerException(message: e.toString());
    }
  }
}
