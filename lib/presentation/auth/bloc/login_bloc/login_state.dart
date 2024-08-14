part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final String message;


  const LoginState(
      {
        this.message = "",
        this.loginStatus = LoginStatus.loading
      });

  LoginState copyWith({
    LoginStatus? loginStatus,
    String? message,

  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    message,
  ];
}

enum LoginStatus {loading, success, error}