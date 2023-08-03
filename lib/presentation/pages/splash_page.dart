import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tokmat/core/const.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration duration = Duration(seconds: 2);

  @override
  void initState() {
    Timer(duration,
        () => Navigator.pushReplacementNamed(context, PageConst.signInPage));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/tokmat-logo.png')),
    );
  }
}
