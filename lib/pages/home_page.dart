import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
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
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Constants.defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(),
            const SizedBox(
              height: Constants.defaultPadding,
            ),
            Text(
              "Begin Your Voyage Here",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // SizedBox(height: Constants.defaultPadding/2,),
            Text(
              "Unlock your next travel experiance",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
            const SizedBox(
              height: Constants.defaultPadding,
            ),
            _buildCities(),
            const SizedBox(
              height: Constants.defaultPadding,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildPostItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: Constants.defaultPadding/2,);
              },
            ),
          ],
        ),
      ),
    );
  }

  LayoutBuilder _buildPostItem() {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = width / 9 * 5;
      return InkWell(
        borderRadius: BorderRadius.circular(Constants.defaultRadius * 2),
        onDoubleTap: () {},
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.defaultRadius * 2),
              image: const DecorationImage(
                  image: NetworkImage("https://picsum.photos/900/500"))),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildPostInfoCard(context)),
        ),
      );
    });
  }

  Container _buildPostInfoCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Constants.defaultPadding / 3),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.defaultRadius * 2),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Constants.defaultPadding / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Furkan Yağmur ● Ankara, Türkiye",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                        ),
                        Text(
                          "Ankara Kalesi",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                      ),
                      Flexible(
                        child: Text(
                          "1400000",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    DateFormat("dd/MM/yyyy").format(DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildCities() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildImageStack("Ankara"),
        ),
        Expanded(
          child: _buildImageStack("Adıyaman"),
        ),
        Expanded(
          child: _buildImageStack("Kütahya"),
        ),
        // Expanded(child: Placeholder()),
        // Expanded(child: Placeholder()),
      ],
    );
  }

  Widget _buildImageStack(String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.defaultPadding / 2),
          child: LayoutBuilder(builder: (context, constraints) {
            double width = constraints.maxWidth * 0.8;
            double height = width * 1.4;
            return Stack(
              children: [
                Transform(
                  transform: Matrix4.rotationZ(-pi / 12),
                  origin: Offset(width / 2, height / 2),
                  child: _buildImage(
                    height: height,
                    width: width,
                    imageUrl: "https://picsum.photos/200/300",
                    margin: EdgeInsets.zero,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(
                    angle: pi / 12,
                    child: _buildImage(
                        height: height,
                        width: width,
                        imageUrl: "https://picsum.photos/200/300",
                        margin: EdgeInsets.only(top: height * 0.08)),
                  ),
                ),
                Align(
                  // top: height*0.15,
                  // left: 0,
                  // right: 0,
                  alignment: Alignment.bottomCenter,
                  child: _buildImage(
                    haveBorder: true,
                    height: height,
                    width: width,
                    imageUrl: "https://picsum.photos/200/300",
                    margin: EdgeInsets.only(top: height * 0.15),
                  ),
                ),
              ],
            );
          }),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildImage({
    required double height,
    required double width,
    required String imageUrl,
    required EdgeInsetsGeometry margin,
    bool haveBorder = false,
  }) {
    return Padding(
      padding: margin,
      child: Material(
        borderRadius: BorderRadius.circular(Constants.defaultRadius * 2),
        elevation: haveBorder ? 10 : 0,
        // shape: RoundedRectangleBorder(
        // ),

        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: haveBorder
                ? Border.all(
                    width: 3,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  )
                : null,
            borderRadius: BorderRadius.circular(Constants.defaultRadius * 2),
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Container _buildSearchBar() {
    return Container(
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
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Ne aramak istiyorsunuz?",
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(
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
                  padding: const EdgeInsets.all(10),
                  iconSize: 30,
                  backgroundColor: Colors.white),
              onPressed: () {},
              icon: const Icon(Icons.tune),
            ),
          ],
        ),
      ),
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
