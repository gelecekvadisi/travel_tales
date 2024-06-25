import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_tales/firebase_options.dart';
import 'package:travel_tales/util/routes.dart';

import 'util/constants.dart';

void main() async {

  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Tales',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D41E1),
            foregroundColor: const Color(0xFFF8F9FE),
            minimumSize: const Size(double.infinity, 0),
            padding: const EdgeInsets.all(Constants.defaultPadding * 0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Constants.defaultRadius,
              ),
            ),
          ),
        ),
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
