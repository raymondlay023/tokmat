import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/domain/usecases/user/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  SignInCubit({
    required this.signInUseCase,
  }) : super(SignInState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignInStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignInStatus.initial));
  }

  Future<void> signInWithCredentials() async {
    emit(state.copyWith(status: SignInStatus.submitting));
    if (state.isValid) {
      try {
        await signInUseCase
            .call(UserEntity(email: state.email, password: state.password));
        emit(state.copyWith(status: SignInStatus.success));
      } catch (_) {
        emit(state.copyWith(status: SignInStatus.error));
      }
    } else {
      emit(state.copyWith(status: SignInStatus.error));
    }
  }
}
