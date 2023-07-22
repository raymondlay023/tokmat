import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class GetUserUseCase {
  final FirebaseRepository repository;

  GetUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getUser(uid);
  }
}
