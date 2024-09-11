import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/products/models/product.dart';
import '../../products/dtos/product_dto.dart';

abstract class BasketPrefUtils {
  saveProductToBasket(List<BikeModel> bikeModels) ;
  getProductFromBasket() ;
}

@Injectable(as: BasketPrefUtils)
class PrefUtilsImpl implements BasketPrefUtils {
  final SharedPreferences sharedPreferences;

  PrefUtilsImpl({required this.sharedPreferences, });


  @override
  Future<void> saveProductToBasket(List<BikeModel> bikeModels) async {
    // Convert list of BikeModel to a list of BikeDto and then to JSON
    List<Map<String, dynamic>> jsonList = bikeModels
        .map((bikeModel) => BikeDto.fromModel(bikeModel).toJson())
        .toList();

    // Encode the list as a JSON string
    String jsonString = jsonEncode(jsonList);

    // Save the JSON string to SharedPreferences
    await sharedPreferences.setString("basket", jsonString);
  }

  @override
  List<BikeModel>? getProductFromBasket() {
    String? jsonString = sharedPreferences.getString("basket");

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    // Decode the JSON string back to a list of Map<String, dynamic>
    List<dynamic> jsonList = jsonDecode(jsonString);

    // Convert each item in the list to BikeModel using BikeDto
    List<BikeModel> bikeModels = jsonList
        .map((json) => BikeDto.fromJson(json as Map<String, dynamic>).toModel())
        .toList();

    return bikeModels;
  }
}
