import 'package:flutter/material.dart';

class Style {
  static const Color primaryColor = Color(0xFF0D41E1);
  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFEBEBEB);
  static const Color textColor = Color(0xFF2B2C34);

  static const double defaultBorderWidth = 2;

  static ButtonStyle socialButtonStyle(ThemeData theme) {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: textColor,
      shape: theme.elevatedButtonTheme.style?.shape?.resolve({})?.copyWith(
        side: const BorderSide(
          color: borderColor,
          width: defaultBorderWidth,
        ),
      ),
    );
  }
}
