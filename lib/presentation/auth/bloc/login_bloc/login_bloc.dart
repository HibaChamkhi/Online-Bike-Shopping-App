import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/ui_state.dart';
import '../../../../core/utils/handle_product_load_result.dart';
import '../../../../domain/auth/repositories/auth_repository.dart';
import 'login_state.dart';

part 'login_event.dart';


@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginUserEvent>(_onLoginUserEvent);
  }
  Future<void> _onLoginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {

    final result = await authRepository.signInUser(event.email, event.password);

    handleLoadResult<Unit, LoginState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        UIStatus? status, // Correct type here
      }) =>
          state.copyWith(
            status: status, // Pass UIStatus, not UIState
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }



  // Future<void> _onLoginUserEvent(
  //     LoginUserEvent event, Emitter<LoginState> emit) async {
  //   emit(state.copyWith(loginStatus: LoginStatus.loading));
  //
  //   final failureOrSuccess =
  //       await authRepository.signInUser(event.email, event.password);
  //
  //   emit(failureOrSuccess.fold(
  //     (failure) => state.copyWith(
  //         message: mapExceptionToMessage(failure),
  //         loginStatus: LoginStatus.error),
  //     (_) => state.copyWith(message: '', loginStatus: LoginStatus.success),
  //   ));
  // }
}
