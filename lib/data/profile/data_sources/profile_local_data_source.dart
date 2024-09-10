import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_bike_shopping_appuntitled/data/profile/data_sources/profile_prefUtils.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/network/network_info.dart';


@injectable
class ProfileLocalDataSource {
  ProfileLocalDataSource( {required this.profilePrefUtils ,required this.networkInfo,});
  final supabase = Supabase.instance.client;
  final ProfilePrefUtils profilePrefUtils;
  final NetworkInfo networkInfo;





}
