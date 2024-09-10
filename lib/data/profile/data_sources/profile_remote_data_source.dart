import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/data/profile/data_sources/profile_prefUtils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';

@injectable
class ProfileRemoteDataSource {
  ProfileRemoteDataSource( {required this.prefUtils ,required this.networkInfo,});
  final supabase = Supabase.instance.client;
  final ProfilePrefUtils prefUtils;
  final NetworkInfo networkInfo;


  Future<User> getCurrentUser() async {
    return handleError(() async {
      final user = supabase.auth.currentUser;
      if (user != null) {
        return user;
      } else {
        throw Exception('No user is currently logged in');
      }
    });
  }


}
