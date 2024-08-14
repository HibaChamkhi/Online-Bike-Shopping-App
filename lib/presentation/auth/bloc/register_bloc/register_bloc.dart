import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/auth/repositories/auth_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  // Future<void> _onRegisterUserEvent(
  //     RegisterUserEvent event, Emitter<RegisterState> emit) async {
  //   emit(state.copyWith(Registertatus: RegisterStatus.loading));
  //
  //   final failureOrSuccess = await authRepository.register(
  //       email: event.email,
  //       userName: event.userName,
  //       phoneNumber: event.number,
  //       password: event.password);
  //
  //   emit(failureOrSuccess.fold(
  //     (failure) => state.copyWith(
  //         message: _mapFailureToMessage(failure),
  //         loginStatus: LoginStatus.error),
  //     (_) => state.copyWith(message: '', loginStatus: LoginStatus.success),
  //   ));
  // }
}
