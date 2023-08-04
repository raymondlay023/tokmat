import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/presentation/cubit/cart_cubit.dart';
import 'package:tokmat/presentation/cubit/user_cubit.dart';
import 'package:tokmat/presentation/cubit/product_cubit.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/cubit/transaction_cubit.dart';
import 'on_generate_route.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/cubit/credential_cubit.dart';
import 'injection_container.dart' as di;

import 'core/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<TransactionCubit>()),
        BlocProvider(create: (_) => di.sl<CartCubit>()),
        BlocProvider(create: (_) => di.sl<ProductCubit>()..getProducts()),
        BlocProvider(create: (_) => di.sl<ShopCubit>()..getShop()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        onGenerateRoute: OnGenerateRoute.route,
      ),
    );
  }
}
