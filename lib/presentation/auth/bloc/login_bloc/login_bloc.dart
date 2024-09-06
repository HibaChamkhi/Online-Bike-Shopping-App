import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/handle_product_load_result.dart';
import '../../../../core/utils/map_exception_to_message.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../domain/auth/repositories/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginUserEvent>(_onLoginUserEvent);
  }
  Future<void> _onLoginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {

    final result = await authRepository.signInUser(event.email, event.password);

    handleLoadResult<Unit, LoginState, LoginStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        LoginStatus? status,
      }) =>
          state.copyWith(
            loginStatus: status,
            message: message,
          ),
      loadingStatus: LoginStatus.loading,
      successStatus: LoginStatus.success,
      errorStatus: LoginStatus.error,
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
