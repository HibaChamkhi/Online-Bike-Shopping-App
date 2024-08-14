import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/exception.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> signUp(
      {
        required String userName,
        required String number,
        required String email,
        required String password,
      });

  Future<Unit> signInUser(String email, String password);

}
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  final supabase = Supabase.instance.client;

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
      return Future.value(unit);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }


  @override
  Future<Unit> signInUser(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final User? user = res.user;
      if (user == null) {
        return Future.error('Error signing in: user is null');
      } else {
        return Future.value(unit);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}
