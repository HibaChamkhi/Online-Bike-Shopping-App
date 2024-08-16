import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/used_functions.dart';
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
    emit(state.copyWith(registerStatus: RegisterStatus.loading));

    final failureOrSuccess = await authRepository.register(
        userName: event.userName,
        email: event.email,
        phoneNumber: event.number,
        password: event.password);

    emit(failureOrSuccess.fold(
      (failure) => state.copyWith(
          message: mapFailureToMessage(failure),
          registerStatus: RegisterStatus.error),
      (_) =>
          state.copyWith(registerStatus: RegisterStatus.success),
    ));
  }
}
