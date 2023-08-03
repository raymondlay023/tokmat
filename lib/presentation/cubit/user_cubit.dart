import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/domain/usecases/user/get_user_usercase.dart';
import 'package:tokmat/domain/usecases/user/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  UserCubit({
    required this.getUserUseCase,
    required this.updateUserUseCase,
  }) : super(UserState.initial());

  Future<void> getUser() async {
    emit(state.copyWith(status: UserStatus.failure));
    print("userCubit getUser loading..");
    try {
      final user = await getUserUseCase.call();
      print("userCubit getUser : $user");
      emit(UserState(status: UserStatus.success, user: user));
    } catch (_) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }

  Future<void> updateUser(UserEntity user) async {
    emit(state.copyWith(status: UserStatus.loading));
    print("userCubit updateUser loading...");
    try {
      await updateUserUseCase
          .call(UserEntity(
            profilePhotoUrl: user.profilePhotoUrl,
            username: user.username,
            name: user.name,
          ))
          .then((_) => print("userCubit updateUser success"));
      emit(state.copyWith(status: UserStatus.success));
    } catch (_) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }
}
