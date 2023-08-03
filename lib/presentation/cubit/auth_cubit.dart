import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/user/get_current_uid_usecase.dart';
import '../../domain/usecases/user/is_sign_in_usecase.dart';
import '../../domain/usecases/user/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  AuthCubit({
    required this.signOutUseCase,
    required this.getCurrentUidUseCase,
    required this.isSignInUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> loggedOut() async {
    await signOutUseCase.call();
    emit(Unauthenticated());
  }

  // Debug
  @override
  void onChange(Change<AuthState> change) {
    print("current: ${change.currentState}" + "\n next: ${change.nextState}");
    super.onChange(change);
  }
}
