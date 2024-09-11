import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/products/models/product.dart';
import '../../products/dtos/product_dto.dart';
import 'basket_prefUtils.dart';

@injectable
class BasketRemoteDataSource {
  BasketRemoteDataSource( {required this.prefUtils ,required this.networkInfo,});
  final supabase = Supabase.instance.client;
  final BasketPrefUtils prefUtils;
  final NetworkInfo networkInfo;


  Future<Unit> addToBasket({
    required BikeModel bikeModel,
    int quantity = 1, // Default quantity is 1
  }) async {
    return await handleError(() async {
      final response = await supabase.from('basket').insert({
        'user_id': supabase.auth.currentUser?.id,
        'id': bikeModel.id,
        'name': bikeModel.name,
        'description': bikeModel.description,
        'price': bikeModel.price,
        'category': bikeModel.categoryId,
        'image': bikeModel.image,
        'discount': bikeModel.discount,
        'quantity': quantity, // Adding the quantity field
      });

      if (response.error != null) {
        // Handle error
        print('Error adding bike to basket: ${response.error!.message}');
        return unit; // Return `unit` when there is an error
      } else {
        // Successfully added to basket
        print('Bike added to basket successfully.');
        return unit; // Return `unit` upon success
      }
    });
  }



  Future<List<BikeModel>> fetchBasketProductFromSupabase() async {
    // Fetch products from Supabase
    return handleError(() async {
      List<Map<String, dynamic>> response =
      await supabase.from('products').select('*');
      var products = response
          .map((productData) => BikeDto.fromJson(productData).toModel())
          .toList();

      // Save fetched products to cache
      prefUtils.saveProductToBasket(products);
      return products;
    });
  }
}
