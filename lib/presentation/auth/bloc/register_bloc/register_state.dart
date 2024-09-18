part of 'register_bloc.dart';

class RegisterState extends UIState<void> {
  const RegisterState({
    super.status,
    super.message,
  });

  @override
  RegisterState copyWith({
    UIStatus? status,
    String? message,
    void data, // This is void because it's not returning specific data here
  }) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
