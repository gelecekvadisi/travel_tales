import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_tales/pages/home_page.dart';
import 'package:travel_tales/pages/login_page.dart';
import 'package:travel_tales/pages/register_page.dart';

class Routes {
  static const String loginPage = "login_page";
  static const String registerPage = "register_page";
  static const String homePage = "home_page";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case "/":
      case loginPage:
        page = LoginPage();
        break;
      case registerPage:
        page = RegisterPage();
        break;
      case homePage:
        page = const HomePage();
        break;
      default:
      page = const Scaffold(body: Center(child: Text("Sayfa Bulunamadı!"),),);
    }
    return _generatePageRoute(page);
  }

  static Route<dynamic>? _generatePageRoute(Widget widget) {
    builder(context) => widget;
    if (Platform.isIOS) {
      return CupertinoPageRoute(builder: builder);
    }
    return MaterialPageRoute(builder: builder);
  }
}
