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

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    String? profilePhotoUrl,
  }) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.call(
        UserEntity(
          name: name,
          username: username,
          email: email,
          password: password,
          profilePhotoUrl: profilePhotoUrl ?? "",
        ),
      );
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }
}
