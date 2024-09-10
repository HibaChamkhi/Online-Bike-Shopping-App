
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


abstract class ProfileRepository {
  Future<Either<Exception, User>> getCurrentUser();
}
