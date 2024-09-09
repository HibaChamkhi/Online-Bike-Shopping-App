import 'package:dartz/dartz.dart';
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

  Future<List<BikeModel>> getAllFaivriteProductsByMe() async {
    return handleError(() async {
      List<Map<String, dynamic>> response =
      await supabase.from('products').select('*');
      var products = response
          .map((productData) => BikeDto.fromJson(productData).toModel())
          .toList();
      return products;
    });
  }

  String getCurrentUserId() {
    final user = supabase.auth.currentUser;
    if (user != null) {
      return user.id;
    } else {
      throw Exception('No user is currently logged in');
    }
  }

// Function to add a product to the favorite table
  @override
  Future<Unit> addProductToFavorite(String productId) async {
    final userId = getCurrentUserId();
    return handleError(() async {
      await supabase.from('favorite').insert({
        'userId': userId,
        'id': productId,
      });
      return unit; // Return an empty Unit instance upon successful insertion
    });
  }

// Function to remove a product from the favorite table
  @override
  Future<Unit> removeProductFromFavorite(String productId) async {
    final userId = getCurrentUserId();
    return handleError(() async {
      await supabase
          .from('favorite')
          .delete()
          .eq('userId', userId)
          .eq('id', productId);
      return unit; // Return an empty Unit instance upon successful deletion
    });
  }



  @override
  Future<List<String>> getAllFavoriteProductsByMe() async {
    final userId = getCurrentUserId();

    return handleError(() async {
      // Step 1: Fetch products liked by me
      List<Map<String, dynamic>> myFavoritesResponse =
      await supabase.from('favorite').select('id').eq('userId', userId);


      List<String> myFavoriteProductIds =
      myFavoritesResponse.map((favorite) => favorite['id'].toString()).toList();
      print("myFavoriteProductIds $myFavoriteProductIds");

      return myFavoriteProductIds;
    });
  }






// Function to get all favorite products of the current user
  // Future<List<BikeModel>> getUserFavoriteProducts(String userId) async {
  //   return handleError(() async {
  //     // Get the list of product IDs from the favorite table
  //     List<Map<String, dynamic>> favoriteResponse = await supabase
  //         .from('favorite')
  //         .select('product_id')
  //         .eq('user_id', userId);
  //
  //     // Extract product IDs
  //     var productIds = favoriteResponse.map((e) => e['product_id']).toList();
  //
  //     if (productIds.isEmpty) {
  //       return [];
  //     }
  //
  //     // Fetch the products using the product IDs
  //     List<Map<String, dynamic>> productResponse = await supabase
  //         .from('products')
  //         .select('*')
  //         .contains('id', productIds);
  //
  //     var products = productResponse
  //         .map((productData) => BikeDto.fromJson(productData).toModel())
  //         .toList();
  //
  //     return products;
  //   });
  // }
}
