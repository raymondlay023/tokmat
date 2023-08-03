import 'dart:io';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class UploadImageToStorageUseCase {
  final FirebaseRepository repository;

  UploadImageToStorageUseCase({required this.repository});

  Future<String> call(File? file, String childName, bool isUserProfile) {
    return repository.uploadImageToStorage(file, childName, isUserProfile);
  }
}
