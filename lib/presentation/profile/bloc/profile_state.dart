part of 'profile_bloc.dart';

class ProfileState extends UIState<User> {
  const ProfileState({
    super.data,
    super.message = '',
    super.status = UIStatus.loading,
  });

  @override
  ProfileState copyWith({
    User? data,
    UIStatus? status,
    String? message,
  }) {
    return ProfileState(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [data, status, message];
}
