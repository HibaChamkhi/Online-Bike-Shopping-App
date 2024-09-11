import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/products/models/product.dart';
import '../../basket/data_sources/basket_prefUtils.dart';

@injectable
class BasketLocalDataSource {
  BasketLocalDataSource( {required this.prefUtils ,required this.networkInfo,});
  final supabase = Supabase.instance.client;
  final BasketPrefUtils prefUtils;
  final NetworkInfo networkInfo;


  Future<List<BikeModel>> getBasketFromCache() async {
    // Fetch Basket from local cache
    List<BikeModel> cachedBasket = prefUtils.getProductFromBasket() ?? [];
    if (cachedBasket.isNotEmpty) {
      print("Cached Basket found.");
      return cachedBasket;
    }
    print("No cached Basket available.");
    // Ensure that the function always returns an empty list if no cache or Basket available
    return [];
  }

}
