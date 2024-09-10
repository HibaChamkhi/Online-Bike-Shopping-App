import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/data/products/data_sources/product_prefUtils.dart';
import 'package:online_bike_shopping_appuntitled/data/products/dtos/product_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/products/models/product.dart';

@injectable
class ProductsLocalDataSource {
  ProductsLocalDataSource( {required this.prefUtils ,required this.networkInfo,});
  final supabase = Supabase.instance.client;
  final PrefUtils prefUtils;
  final NetworkInfo networkInfo;



  Future<List<BikeModel>> fetchProductsFromCache() async {
    print("No internet. Fetching products from cache...");

    // Fetch products from local cache
    List<BikeModel> cachedProducts = prefUtils.getBikeModelList() ?? [];

    if (cachedProducts.isNotEmpty) {
      print("Cached products found.");
      return cachedProducts;
    }

    print("No cached products available.");
    // Ensure that the function always returns an empty list if no cache or products available
    return [];
  }

}
