import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tokmat/data/datasources/remote_data_source/firebase_remote_data_source.dart';
import 'package:tokmat/presentation/cubit/get_user_cubit.dart';
import 'data/repositories/firebase_repository_impl.dart';
import 'domain/repositories/firebase_repository.dart';
import 'domain/usecases/user/create_user_usecase.dart';
import 'domain/usecases/user/get_current_uid_usecase.dart';
import 'domain/usecases/user/get_user_usercase.dart';
import 'domain/usecases/user/is_sign_in_usecase.dart';
import 'domain/usecases/user/sign_in_usecase.dart';
import 'domain/usecases/user/sign_out_usecase.dart';
import 'domain/usecases/user/sign_up_usecase.dart';
import 'domain/usecases/user/update_user_usecase.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/cubit/credential_cubit.dart';
import 'data/datasources/remote_data_source/firebase_remote_data_source_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AuthCubit(
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
      isSignInUseCase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => CredentialCubit(
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => GetUserCubit(
      getUserUseCase: sl.call(),
    ),
  );

  // User
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUserUseCase(repository: sl.call()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(
            firebaseAuth: sl.call(),
            firebaseFirestore: sl.call(),
          ));

  // Externals
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseFirestore);
}
