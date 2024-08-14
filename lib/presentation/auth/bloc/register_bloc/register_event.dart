part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}
class RegisterUserEvent extends RegisterEvent {
  final String userName;
  final String email;
  final String number;
  final String password;

  RegisterUserEvent({
    required this.userName,
    required this.email,
    required this.number,
    required this.password,
  });

  @override
  List<Object> get props => [
    userName,
    email,
    number,
    password,
  ];
}