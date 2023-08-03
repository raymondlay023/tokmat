import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/presentation/cubit/auth_cubit.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/pages/add_product_page.dart';
import 'package:tokmat/presentation/pages/add_shop_page.dart';
import 'package:tokmat/presentation/pages/add_transaction_page.dart';
import 'package:tokmat/presentation/pages/edit_profile_page.dart';
import 'package:tokmat/presentation/pages/edit_shop_page.dart';
import 'package:tokmat/presentation/pages/main_page.dart';
import 'package:tokmat/presentation/pages/product_page.dart';
import 'package:tokmat/presentation/pages/sign_in_page.dart';
import 'package:tokmat/presentation/pages/sign_up_page.dart';
import 'package:tokmat/presentation/pages/splash_page.dart';

import 'core/const.dart';
import 'domain/entities/user_entity.dart';
import 'presentation/pages/no_page_found.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return routeBuilder(SplashPage());

      case PageConst.mainPage:
        return routeBuilder(MainPage());

      case PageConst.signInPage:
        return routeBuilder(
            BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
          return authState is Authenticated ? MainPage() : SignInPage();
        }));

      case PageConst.signUpPage:
        return routeBuilder(BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return authState is Authenticated
                ? BlocBuilder<ShopCubit, ShopState>(
                    builder: (context, shopState) {
                    return shopState is ShopAvailable
                        ? MainPage()
                        : AddShopPage();
                  })
                : SignUpPage();
          },
        ));

      case PageConst.editProfilePage:
        if (args is UserEntity) {
          return routeBuilder(EditProfilePage(
            user: args,
          ));
        }

      case PageConst.addProductPage:
        return routeBuilder(AddProductPage());

      case PageConst.editShopPage:
        return routeBuilder(EditShopPage());

      case PageConst.addTransactionPage:
        return routeBuilder(AddTransactionPage());

      case PageConst.productPage:
        return routeBuilder(ProductPage());

      case PageConst.addProductPage:
        return routeBuilder(AddProductPage());

      default:
        const NoPageFound();
    }
  }
}

routeBuilder(Widget child) => MaterialPageRoute(builder: (context) => child);
