import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/presentation/cubit/auth_cubit.dart';
import 'package:tokmat/presentation/pages/edit_profile_page.dart';
import 'package:tokmat/presentation/pages/edit_shop_page.dart';
import 'package:tokmat/presentation/pages/main_page.dart';
import 'package:tokmat/presentation/pages/sign_in_page.dart';
import 'package:tokmat/presentation/pages/sign_up_page.dart';
import 'package:tokmat/presentation/pages/splash_page.dart';

import 'core/const.dart';
import 'domain/entities/user_entity.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return routeBuilder(SplashPage());

      case PageConst.signInPage:
        return routeBuilder(
            BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
          return authState is Authenticated
              ? MainPage(uid: authState.uid)
              : SignInPage();
        }));

      case PageConst.signUpPage:
        return routeBuilder(SignUpPage());

      case PageConst.editProfilePage:
        if (args is UserEntity) {
          return routeBuilder(EditProfilePage(
            user: args,
          ));
        }

      case PageConst.editShopPage:
        return routeBuilder(EditShopPage());

      default:
        const NoPageFound();
    }
  }
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text("Page Not Found!", style: TextStyle(fontSize: 44))),
    );
  }
}

routeBuilder(Widget child) => MaterialPageRoute(builder: (context) => child);
