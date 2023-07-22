import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/presentation/cubit/auth_cubit.dart';
import 'package:tokmat/presentation/cubit/get_user_cubit.dart';

class SettingsPage extends StatelessWidget {
  final UserEntity user;
  const SettingsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/default-profile-picture.png',
                width: 75,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, ${user.name}',
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  '@${user.username}',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: 1),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile', arguments: user);
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Ink(
                  child: Row(
                    children: [
                      const Icon(Icons.key),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Edit Profil"),
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
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/edit-shop'),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Ink(
                  child: Row(
                    children: [
                      const Icon(Icons.key),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Edit Profil Toko"),
                          Text("Mengubah detail dari toko Anda",
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                              ))
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
