import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:travel_tales/pages/home/add_post_page.dart';
import 'package:travel_tales/pages/home/feed_page.dart';
import 'package:travel_tales/pages/home/map_page.dart';
import 'package:travel_tales/pages/home/profile_page.dart';
import 'package:travel_tales/util/constants.dart';
import 'package:travel_tales/util/routes.dart';
import 'package:travel_tales/util/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ppUrl =
      "https://t4.ftcdn.net/jpg/06/08/55/73/360_F_608557356_ELcD2pwQO9pduTRL30umabzgJoQn5fnd.jpg";

  final List<Widget> pageList = [
    FeedPage(),
    const MapPage(),
    const AddPostPage(),
    const ProfilePage(),
  ];

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        margin: const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding / 2),
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        borderRadius: 1000,
        itemBorderRadius: 1000,
        backgroundColor: Theme.of(context).cardColor,
        selectedBackgroundColor: const Color(0xFF469A88),
        selectedItemColor: Theme.of(context).cardColor,
        unselectedItemColor: const Color(0xFF469A88),
        iconSize: 24.0,
        width: 250,
        // itemBuilder: (context, items) {
        //   return Padding(
        //     padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
        //     child: Icon(items.icon),
        //   );
        // },
        items: [
          FloatingNavbarItem(icon: Icons.home_outlined),
          FloatingNavbarItem(icon: Icons.map_outlined),
          FloatingNavbarItem(icon: Icons.add_a_photo_outlined),
          FloatingNavbarItem(icon: Icons.person_outline),
        ],
      ),
      body: pageList[currentPageIndex],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 48 + Constants.defaultPadding / 2,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(Constants.defaultPadding, 0, 0, 0),
        child: CircleAvatar(
          minRadius: 24,
          backgroundImage: NetworkImage(
            ppUrl,
            // fit: BoxFit.cover,
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: Constants.defaultPadding / 2),
          child: CircleAvatar(
            minRadius: 24,
            child: Icon(Icons.notifications_outlined),
          ),
        )
      ],
      title: Text(
        "Furkan Yağmur",
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.normal),
      ),
      centerTitle: true,
    );
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.loginPage,
      (route) => false,
    );
  }
}
