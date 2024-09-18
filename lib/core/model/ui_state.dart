
import 'package:equatable/equatable.dart';

class UIState<T> extends Equatable {
  final UIStatus status;
  final String message;
  final T? data;

  const UIState({
    this.status = UIStatus.loading,
    this.message = "",
    this.data,
  });

  UIState<T> copyWith({
    UIStatus? status,
    String? message,
    T? data,
  }) {
    return UIState<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    data,
  ];
}

enum UIStatus { loading, success, error }
