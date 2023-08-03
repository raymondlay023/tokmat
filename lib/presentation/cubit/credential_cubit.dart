import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user/sign_in_usecase.dart';
import '../../domain/usecases/user/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  CredentialCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(CredentialInitial());

  Future<void> signIn(UserEntity user) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(UserEntity(
        email: user.email,
        password: user.password,
      ));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUp(UserEntity user) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.call(
        UserEntity(
          name: user.name,
          username: user.username,
          email: user.email,
          password: user.password,
          profilePhotoUrl: user.profilePhotoUrl ?? "",
        ),
      );
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }

  // Debug
  @override
  void onChange(Change<CredentialState> change) {
    print("current: ${change.currentState}" + "\n next: ${change.nextState}");
    super.onChange(change);
  }
}
