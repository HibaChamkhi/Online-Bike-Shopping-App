import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/data/products/data_sources/product_prefUtils.dart';
import 'package:online_bike_shopping_appuntitled/data/products/dtos/product_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/products/models/product.dart';

@injectable
class ProductsRemoteDataSource {
  ProductsRemoteDataSource( {required this.prefUtils ,required this.networkInfo,});
  final supabase = Supabase.instance.client;
  final PrefUtils prefUtils;
  final NetworkInfo networkInfo;


  Future<List<BikeModel>> fetchProductsFromSupabase() async {
    print("Connected to the internet. Fetching products from Supabase...");
    // Fetch products from Supabase
    return handleError(() async {
      List<Map<String, dynamic>> response =
      await supabase.from('products').select('*');
      var products = response
          .map((productData) => BikeDto.fromJson(productData).toModel())
          .toList();

      // Save fetched products to cache
      prefUtils.saveBikeModelList(products);
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

// Function to add a product to the favorite table
  @override
  Future<Unit> addProductToFavorite(String productId) async {
    return handleError(() async {
      await supabase.from('favorite').insert({
        'userId': supabase.auth.currentUser?.id,
        'id': productId,
      });
      return unit; // Return an empty Unit instance upon successful insertion
    });
  }

// Function to remove a product from the favorite table
  @override
  Future<Unit> removeProductFromFavorite(String productId) async {
    return handleError(() async {
      await supabase
          .from('favorite')
          .delete()
          .eq('userId', supabase.auth.currentUser?.id ?? "" )
          .eq('id', productId);
      return unit; // Return an empty Unit instance upon successful deletion
    });
  }


  @override
  Future<List<BikeModel>> getAllFavoriteProductsByMe() async {

    return handleError(() async {
      // Step 1: Fetch favorite product IDs for the current user
      List<Map<String, dynamic>> myFavoritesResponse =
      await supabase.from('favorite').select('id').eq('userId', supabase.auth.currentUser?.id ?? "");

      // Step 2: Extract the list of favorite product IDs
      List<String> myFavoriteProductIds =
      myFavoritesResponse.map((favorite) => favorite['id'].toString()).toList();

      // Step 3: Fetch the bike details using the favorite product IDs
      if (myFavoriteProductIds.isNotEmpty) {
        List<Map<String, dynamic>> favoriteBikesResponse =
        await supabase.from('products').select('*').inFilter('id', myFavoriteProductIds); // 'id' is from the products table

        // Step 4: Convert the response into a list of BikeModel
        List<BikeModel> favoriteBikes = favoriteBikesResponse
            .map((bikeData) => BikeDto.fromJson(bikeData).toModel())
            .toList();
        print("dataaa : $favoriteBikes");
        return favoriteBikes;
      } else {
        return [];
      }
    });
  }


}
