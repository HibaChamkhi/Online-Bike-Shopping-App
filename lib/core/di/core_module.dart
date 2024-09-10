import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class CoreModule {
  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  InternetConnectionChecker get dataConnectionChecker =>
      InternetConnectionChecker();

}
