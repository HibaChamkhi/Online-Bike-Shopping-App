import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/model/ui_state.dart';
import '../../../core/utils/handle_product_load_result.dart';
import '../../../domain/profile/repositories/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({
    required this.repository,
  }) : super(const ProfileState()) {
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
  }

  Future<void> _onGetCurrentUserEvent(
      GetCurrentUserEvent event, Emitter<ProfileState> emit) async {
    final result = await repository.getCurrentUser();

    handleLoadResult<User, ProfileState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        User? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            data: data,
            message: message,
            status: status,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }
}
