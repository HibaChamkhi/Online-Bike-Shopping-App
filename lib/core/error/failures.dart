import 'package:equatable/equatable.dart';
abstract class Failure extends Equatable {
  String? get message => null;
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  final String message;

  ServerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}