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
  BasketRemoteDataSource({
    required this.prefUtils,
    required this.networkInfo,
  });

  final supabase = Supabase.instance.client;
  final BasketPrefUtils prefUtils;
  final NetworkInfo networkInfo;

  Future<String> addToBasket({
    required BikeModel bikeModel,
    int quantity = 1,
  }) async {
    return handleError(() async {
      // Check if the product already exists in the basket
      final response = await supabase
          .from('basket')
          .select()
          .eq('id', bikeModel.id)
          .eq('userId', supabase.auth.currentUser?.id ?? "")
          .maybeSingle();
      if (response == null) {
        // If product does not exist, insert a new record
        await supabase.from('basket').insert({
          "id": bikeModel.id,
          'userId': supabase.auth.currentUser?.id ?? "",
          'name': bikeModel.name,
          'description': bikeModel.description,
          'price': bikeModel.price,
          'category': bikeModel.categoryId,
          'image': bikeModel.image,
          '3dImage': bikeModel.image3d,
          'discount': bikeModel.discount,
          'quantity': quantity,
        });
        return "success";
      } else {
        return "Product already exists in the basket";
      }
    });
  }

  Future<List<BikeModel>> fetchBasketProductFromSupabase() async {
    return handleError(() async {
      // Fetch products from Supabase for the current user
      List<Map<String, dynamic>> response = await supabase
          .from('basket')
          .select('*')
          .eq('userId', supabase.auth.currentUser?.id ?? "");

      var products = response
          .map((productData) => BikeDto.fromJson(productData).toModel())
          .toList();

      // Save fetched products to cache
      prefUtils.saveProductToBasket(products);
      print(" products $products");
      return products;
    });
  }


  Future<Unit> removeFromBasket({required String bikeId}) async {
    return handleError(() async {
      // Remove product from the basket using its ID
      await supabase
          .from('basket')
          .delete()
          .eq('id', bikeId)
          .eq('userId', supabase.auth.currentUser?.id ?? "");
      return unit; // Return an empty Unit instance upon successful deletion
    });
  }

  Future<Unit> updateQuantity({
    required String bikeId,
    required bool increase, // true to increase, false to decrease
  }) async {
    return handleError(() async {
      final userId = supabase.auth.currentUser?.id ?? "";
      final response = await supabase
          .from('basket')
          .select('quantity')
          .eq('id', bikeId)
          .eq('userId', userId)
          .maybeSingle();
      print("quantity $response");
      if (response != null) {
        final currentQuantity = response['quantity'] as int;
        final newQuantity = increase
            ? currentQuantity + 1
            : (currentQuantity > 1 ? currentQuantity - 1 : currentQuantity);

        if (newQuantity != currentQuantity) {
          await supabase
              .from('basket')
              .update({'quantity': newQuantity})
              .eq('id', bikeId)
              .eq('userId', userId);
        }
      }

      return unit;
    });
  }
}
