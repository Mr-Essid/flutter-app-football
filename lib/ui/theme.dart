import 'package:flutter/material.dart';

const primaryColor = Color(0xff000000); // Black
const onPrimaryColor = Color(0xffffffff); // Opposite of black is white

const secondaryColor = Colors.green; // Green
const onSecondaryColor = Color(0xffff00ff); // Opposite of green is magenta

const tertiaryColor = Color(0xFFFFD700); // Gold
const onTertiaryColor = Color(0xff0028ff); // Opposite of gold is blue

const containerColor = Colors.white; // White
const onContainerColor = Color(0xff000000); // Opposite of white is black

const surfaceColor = Color(0xFFEDEDED); // Light grey
const onSurfaceColor = Color(0xff121212); // Opposite of light grey is dark grey

const labelColors = Colors.grey; // Grey
const onLabelColors = Color(0xff7f7f7f); // Opposite of grey is inverse grey

const errorColor = Colors.red; // Red
const onErrorColor = Color(0xff00ffff); // Opposite of red is cyan

const textData = TextTheme(titleLarge: TextStyle());

final customTheme = ThemeData(
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontFamily: 'cairo_bold', fontSize: 24, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontFamily: 'cairo_bold', fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: 'cairo_bold', fontSize: 22, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
        fontFamily: 'cairo_meduim',
        fontSize: 20,
        fontWeight: FontWeight.normal),
    bodySmall: TextStyle(
        fontFamily: 'cairo_meduim',
        fontSize: 18,
        fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(
        fontFamily: 'cairo_meduim',
        fontSize: 16,
        fontWeight: FontWeight.normal),
    labelLarge: TextStyle(
        fontFamily: 'cairo_small', fontSize: 16, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
        fontFamily: 'cairo_small', fontSize: 14, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        fontFamily: 'cairo_small', fontSize: 12, fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      tertiary: tertiaryColor,
      onTertiary: Colors.white,
      onPrimary: onPrimaryColor,
      onSecondary: Colors.grey,
      onError: onErrorColor,
      onSurface: onSurfaceColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: surfaceColor),
);
