import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_tales/providers/all_providers.dart';
import 'package:travel_tales/util/routes.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _navigatePage(context, ref);
    },);




    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          "SplashScreen"
        ),
      ),
    );
  }

  _navigatePage(BuildContext context, WidgetRef ref) {
    bool haveAccount = ref.read(authProvider).haveAccount();

    if (haveAccount) {
      Navigator.pushReplacementNamed(context, Routes.homePage);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginPage);
    }
  }
}