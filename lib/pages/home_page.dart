import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_tales/util/constants.dart';
import 'package:travel_tales/util/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ppUrl =
      "https://t4.ftcdn.net/jpg/06/08/55/73/360_F_608557356_ELcD2pwQO9pduTRL30umabzgJoQn5fnd.jpg";

  Color greyColor = const Color(0xFFE5E5E5);
  Color greyBorderColor = const Color(0xFFC5C5C5);

  late InputBorder textFieldBorder;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      FlutterNativeSplash.remove();
    });

    textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(
        width: 1,
        color: greyBorderColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 48 + Constants.defaultPadding/2,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(Constants.defaultPadding, 0, 0, 0),
          child: CircleAvatar(
            minRadius: 24,
            backgroundImage: NetworkImage(
              ppUrl,
              // fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Constants.defaultPadding/2),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.defaultPadding/2),
        child: Column(
          children: [
            Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          border: textFieldBorder,
                          enabledBorder: textFieldBorder,
                          focusedBorder: textFieldBorder,
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Ne aramak istiyorsunuz?",
                          alignLabelWithHint: true,
        
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                          shape: CircleBorder(
                            side: BorderSide(
                              width: 1,
                              color: greyBorderColor,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          iconSize: 30,
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      icon: Icon(Icons.tune),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
