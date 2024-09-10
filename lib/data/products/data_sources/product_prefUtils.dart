import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/domain/products/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dtos/product_dto.dart';

abstract class PrefUtils {
  void saveBikeModelList(List<BikeModel> bikeModels);
  List<BikeModel>? getBikeModelList();
}

@Injectable(as: PrefUtils)
class PrefUtilsImpl implements PrefUtils {
  final SharedPreferences sharedPreferences;

  PrefUtilsImpl({required this.sharedPreferences, });


  @override
  Future<void> saveBikeModelList(List<BikeModel> bikeModels) async {
    // Convert list of BikeModel to a list of BikeDto and then to JSON
    List<Map<String, dynamic>> jsonList = bikeModels
        .map((bikeModel) => BikeDto.fromModel(bikeModel).toJson())
        .toList();

    // Encode the list as a JSON string
    String jsonString = jsonEncode(jsonList);

    // Save the JSON string to SharedPreferences
    await sharedPreferences.setString("bikeList", jsonString);
  }

  @override
  List<BikeModel>? getBikeModelList() {
    String? jsonString = sharedPreferences.getString("bikeList");

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
