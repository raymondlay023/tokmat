import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/domain/usecases/user/get_user_usercase.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetUserUseCase getUserUseCase;
  GetUserCubit({required this.getUserUseCase}) : super(GetUserInitial());

  Future<void> getUser() async {
    emit(GetUserLoading());
    print("getUserCubit loading..");
    try {
      final user = await getUserUseCase.call();
      print("user getUserCubit : $user");
      emit(GetUserLoaded(user: user));
    } catch (_) {
      emit(GetUserFailure());
    }
  }
}
