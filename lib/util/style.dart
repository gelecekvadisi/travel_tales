import 'package:flutter/material.dart';

enum ImagesAsset {
  /// ai.png
  ai('ic_ai'),

  /// apple.png
  apple('ic_apple'),

  /// default_profile.png
  google('ic_default_profile'),

  /// logo.png
  logo('ic_logo');

  final String name;

  String get toPng => 'assets/images/$name.png';
  String get toJpeg => 'assets/images/$name.jpeg';
  String get toSvg => 'assets/images/$name.svg';
  String get toGif => 'assets/images/$name.gif';
  String get toJpg => 'assets/images/$name.jpg';

  const ImagesAsset(this.name);
}

class Style {
  static const Color primaryColor = Color(0xFF0D41E1);
  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFEBEBEB);
  static const Color textColor = Color(0xFF2B2C34);
}