import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/handle_product_load_result.dart';
import '../../../../core/utils/map_exception_to_message.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../domain/auth/repositories/auth_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(const RegisterState()) {
    on<RegisterUserEvent>(_onRegisterUserEvent);
  }

  Future<void> _onRegisterUserEvent(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    final result = await authRepository.register(
      userName: event.userName,
      email: event.email,
      phoneNumber: event.number,
      password: event.password,
    );
    handleLoadResult<Unit, RegisterState, RegisterStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        RegisterStatus? status,
      }) =>
          state.copyWith(
        registerStatus: status,
        message: message,
      ),
      loadingStatus: RegisterStatus.loading,
      successStatus: RegisterStatus.success,
      errorStatus: RegisterStatus.error,
    );
  }

// Future<void> _onRegisterUserEvent(
//     RegisterUserEvent event, Emitter<RegisterState> emit) async {
//   emit(state.copyWith(registerStatus: RegisterStatus.loading));
//
//   final failureOrSuccess = await authRepository.register(
//       userName: event.userName,
//       email: event.email,
//       phoneNumber: event.number,
//       password: event.password);
//
//   emit(failureOrSuccess.fold(
//     (failure) => state.copyWith(
//         message: mapExceptionToMessage(failure),
//         registerStatus: RegisterStatus.error),
//     (_) =>
//         state.copyWith(registerStatus: RegisterStatus.success),
//   ));
// }
}
