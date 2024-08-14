import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> signUp(
      {
        required String userName,
        required String number,
        required String email,
        required String password,
      });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl({required this.supabase,});

  @override
  Future<Unit> signUp(
      {
        required String userName,
        required String number,
        required String email,
        required String password,
      }) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': userName,
          'phone_number': number,
        },
      );
      UserResponse? user = await supabase.auth.getUser();

      await supabase.from('members').insert({
        'user_id': user.user?.id,
        'username': userName,
      });

      await supabase.auth.signOut();
      return Future.value(unit);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

}
