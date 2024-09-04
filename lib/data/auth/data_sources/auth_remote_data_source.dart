import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/error_utils.dart';
import '../../../core/error/exception.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSource(this._supabaseClient);

  Future<Unit> signUp({
    required String userName,
    required String number,
    required String email,
    required String password,
  }) async {
    return handleError(() async {
      await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': userName,
          'phone_number': number,
        },
      );
      return unit;
    });
  }

  Future<Unit> signInUser(String email, String password) async {
    return handleError(() async {
      final AuthResponse res = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final User? user = res.user;

      if (user == null) {
        throw Exception('Error signing in: user is null');
      } else {
        return unit;
      }
    });
  }
}



