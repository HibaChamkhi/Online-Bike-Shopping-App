part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final RegisterStatus registerStatus;
  final String message;

  const RegisterState(
      {this.message = "", this.registerStatus = RegisterStatus.loading});

  RegisterState copyWith({
    RegisterStatus? registerStatus,
    String? message,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        registerStatus,
        message,
      ];
}

enum RegisterStatus { loading, success, error }
