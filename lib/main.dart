import 'package:flutter/material.dart';
import 'package:travel_tales/pages/login_page.dart';

import 'util/constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: LoginPage(),
    );
  }
}
