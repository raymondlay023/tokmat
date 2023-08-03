import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/presentation/cubit/auth_cubit.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/cubit/user_cubit.dart';
import 'package:tokmat/presentation/pages/no_page_found.dart';
import 'package:tokmat/presentation/pages/widgets/photo_widget.dart';
import 'package:tokmat/presentation/pages/widgets/shimmer_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  UserEntity? _user;
  ShopEntity? _shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height / 7,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () => context.read<AuthCubit>().loggedOut(),
            ),
          ),
        ],
        title: Builder(
          builder: (context) {
            final shopState = context.watch<ShopCubit>().state;
            _shop =
                shopState.status == ShopStatus.success ? shopState.shop : null;

            final userState = context.watch<UserCubit>().state;
            _user =
                userState.status == UserStatus.success ? userState.user : null;

            if (userState.status == UserStatus.success) {
              return Row(
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: ClipOval(
                        child: photoWidget(
                            imageUrl: userState.user.profilePhotoUrl)),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, ${userState.user.name}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        '@${userState.user.username}',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              );
            } else if (userState.status == UserStatus.loading) {
              //* Can use the shimmer widget
              const Center(child: CircularProgressIndicator());
            } else if (userState.status == UserStatus.failure) {
              toast("Something went wrong!");
            }
            return NoPageFound();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 1),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile', arguments: _user);
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Ink(
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Edit Profil"),
                          Text("Mengubah detail profil Anda",
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, '/edit-shop', arguments: _shop),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Ink(
                  child: Row(
                    children: [
                      const Icon(Icons.store),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Edit Profil Toko"),
                          Text(
                            "Mengubah detail dari toko Anda",
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
