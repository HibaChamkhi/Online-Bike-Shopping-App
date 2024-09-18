import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/ui_state.dart';
import '../../../../core/utils/handle_product_load_result.dart';
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

    handleLoadResult<Unit, RegisterState, UIStatus>(
      result: result,
      emit: emit,
      state: state,
      copyWith: ({
        Unit? data,
        String? message,
        UIStatus? status,
      }) =>
          state.copyWith(
            status: status, // Use UIStatus
            message: message,
          ),
      loadingStatus: UIStatus.loading,
      successStatus: UIStatus.success,
      errorStatus: UIStatus.error,
    );
  }
}

