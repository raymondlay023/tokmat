import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/domain/usecases/user/get_user_usercase.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetUserUseCase getUserUseCase;
  GetUserCubit({required this.getUserUseCase}) : super(GetUserInitial());

  Future<void> getUser({required String uid}) async {
    emit(GetUserLoading());
    print("loading..");
    try {
      final streamResponse = getUserUseCase.call(uid);
      print("stream response..");
      streamResponse.listen((users) {
        emit(GetUserLoaded(user: users.first));
      });
    } catch (_) {
      emit(GetUserFailure());
    }
  }
}
