part of 'profile_bloc.dart';

 class ProfileState extends Equatable {
  final User? user;
  final ProfileStatus profileStatus;
  final String messages;

  const ProfileState({
    this.user ,
    this.messages = "",
    this.profileStatus = ProfileStatus.loading,
  });

  ProfileState copyWith({
   User? user,
    ProfileStatus? profileStatus,
    String? messages,
  }) {
    return ProfileState(
      user: user ?? this.user,
      messages: messages ?? this.messages,
      profileStatus: profileStatus ?? this.profileStatus,
    );
  }

  @override
  List<Object> get props => [
    //user
    profileStatus,
    messages,
  ];
}

enum ProfileStatus { loading, success, error }