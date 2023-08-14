import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/cubit/user_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/photo_widget.dart';

import '../../core/const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Builder(builder: (context) {
              final userState = context.watch<UserCubit>().state;
              final shopState = context.watch<ShopCubit>().state;
              return Card(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Halo, ${userState.user.name}!",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text("@${userState.user.username}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black45)),
                            ],
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ClipOval(
                              child: photoWidget(
                                  defaultImage: OtherConst.defaultImagePath,
                                  imageUrl: userState.user.profilePhotoUrl),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "${shopState.shop.name}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            }),
            const SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Date"),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            Placeholder(fallbackHeight: 78, fallbackWidth: 320),
            const SizedBox(height: 25),
            Placeholder(fallbackHeight: 320, fallbackWidth: 352),
          ],
        ),
      ),
    ));
  }
}
