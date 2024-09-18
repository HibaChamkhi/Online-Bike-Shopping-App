import '../../../../core/model/ui_state.dart';

class LoginState extends UIState<void> {
  const LoginState({
    super.status,
    super.message,
  });

  @override
  LoginState copyWith({
    UIStatus? status, // Use UIStatus here
    String? message,
    void data,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
