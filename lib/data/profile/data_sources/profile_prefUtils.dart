import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/domain/products/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfilePrefUtils {

}

@Injectable(as: ProfilePrefUtils)
class ProfilePrefUtilsImpl implements ProfilePrefUtils {
  final SharedPreferences sharedPreferences;

  ProfilePrefUtilsImpl({required this.sharedPreferences, });




}
