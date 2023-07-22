import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class CreateUserUseCase {
  final FirebaseRepository repository;

  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
