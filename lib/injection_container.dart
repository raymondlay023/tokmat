import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tokmat/data/datasources/remote_data_source/firebase_remote_data_source.dart';
import 'package:tokmat/domain/usecases/product/create_product_usecase.dart';
import 'package:tokmat/domain/usecases/product/get_products_use_case.dart';
import 'package:tokmat/domain/usecases/shop/create_shop_usecase.dart';
import 'package:tokmat/domain/usecases/shop/get_shop_usecase.dart';
import 'package:tokmat/domain/usecases/transactions/create_transaction_usecase.dart';
import 'package:tokmat/presentation/cubit/cart_cubit.dart';
import 'package:tokmat/presentation/cubit/get_user_cubit.dart';
import 'package:tokmat/presentation/cubit/product_cubit.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/cubit/transaction_cubit.dart';
import 'data/repositories/firebase_repository_impl.dart';
import 'domain/repositories/firebase_repository.dart';
import 'domain/usecases/transactions/get_transactions_usecase.dart';
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

  sl.registerFactory(() => ShopCubit(
        createShopUseCase: sl.call(),
        getShopUseCase: sl.call(),
      ));

  sl.registerFactory(() => TransactionCubit(
        createTransactionUseCase: sl.call(),
        getTransactionsUseCase: sl.call(),
      ));

  sl.registerFactory(() => CartCubit());

  sl.registerFactory(() => ProductCubit(
        createProductUseCase: sl.call(),
        getProductsUseCase: sl.call(),
      ));

  // User
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => CreateTransactionUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetTransactionsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateProductUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateShopUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetShopUseCase(repository: sl.call()));

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
