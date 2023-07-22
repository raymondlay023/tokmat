import 'package:flutter/material.dart';
import 'package:tokmat/core/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Placeholder(
              fallbackHeight: 150,
              fallbackWidth: 320,
            ),
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard',
                  style:
                      headerTextStyle.copyWith(fontWeight: FontWeight.normal),
                ),
                Placeholder(
                  fallbackHeight: 33,
                  fallbackWidth: 101,
                ),
              ],
            ),
            SizedBox(height: 25),
            Placeholder(fallbackHeight: 78, fallbackWidth: 320),
            SizedBox(height: 25),
            Placeholder(fallbackHeight: 320, fallbackWidth: 352),
          ],
        ),
      ),
    ));
  }
}
