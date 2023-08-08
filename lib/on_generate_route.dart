import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/cubit/auth_cubit.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/pages/add_product_page.dart';
import 'package:tokmat/presentation/pages/add_shop_page.dart';
import 'package:tokmat/presentation/pages/add_transaction_page.dart';
import 'package:tokmat/presentation/pages/detail_transaction_page.dart';
import 'package:tokmat/presentation/pages/edit_product_page.dart';
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
        return routeBuilder(const SplashPage());

      case PageConst.mainPage:
        return routeBuilder(const MainPage());

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
                    return shopState.status == ShopStatus.success
                        ? const MainPage()
                        : const AddShopPage();
                  })
                : const SignUpPage();
          },
        ));

      case PageConst.editProfilePage:
        if (args is UserEntity) {
          return routeBuilder(EditProfilePage(
            user: args,
          ));
        }

      case PageConst.addProductPage:
        return routeBuilder(const AddProductPage());

      case PageConst.editShopPage:
        if (args is ShopEntity) {
          return routeBuilder(EditShopPage(
            shop: args,
          ));
        }

      case PageConst.addTransactionPage:
        return routeBuilder(const AddTransactionPage());

      case PageConst.productPage:
        return routeBuilder(const ProductPage());

      case PageConst.editProductPage:
        if (args is ProductEntity) {
          return routeBuilder(EditProductPage(
            product: args,
          ));
        }

      case PageConst.detailTransactionPage:
        if (args is TransactionEntity) {
          return routeBuilder(DetailTransactionPage(
            transaction: args,
          ));
        }

      default:
        const NoPageFound();
    }
  }
}

routeBuilder(Widget child) => MaterialPageRoute(builder: (context) => child);
