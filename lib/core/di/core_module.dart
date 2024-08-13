import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

@module
abstract class CoreModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  InternetConnectionChecker get dataConnectionChecker =>
      InternetConnectionChecker();
}
