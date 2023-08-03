import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/presentation/cubit/auth_cubit.dart';
import 'package:tokmat/presentation/cubit/get_user_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/shimmer_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final getUserState = context.watch<GetUserCubit>().state;
    final currentUser =
        getUserState is GetUserLoaded ? getUserState.user : null;

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
            BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, getUserState) {
                if (getUserState is GetUserLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, ${getUserState.user.name}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        '@${getUserState.user.username}',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  );
                } else if (getUserState is GetUserLoading) {
                  Column(
                    children: [
                      ShimmerWidget.rectangular(
                        height: 15,
                        width: MediaQuery.of(context).size.width / 5,
                      ),
                      ShimmerWidget.rectangular(
                        height: 15,
                        width: MediaQuery.of(context).size.width / 5,
                      )
                    ],
                  );
                } else if (getUserState is GetUserFailure) {
                  toast("Something went wrong!");
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 1),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile',
                    arguments: currentUser);
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
            const Divider(height: 1),
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
