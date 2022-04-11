import 'package:flutter/material.dart';

enum kdataFetchState { IS_LOADING, IS_LOADED, ERROR_ENCOUNTERED }

const Color lightThemePrimaryColor = Color(0xffFFFFFF);
const Color lightThemePrimaryColorDark = Color(0xffE5EBF0);
const Color lightThemeAccentColor = Color(0xff1e0bff);
const Color lightThemeButtonColor = Color(0xff1e0bff);
const Color lightThemeCardColor = Color(0xff212121);
const Color lightThemeSubtitleColor = Color(0xff838385);

const Color darkThemePrimaryColor = Color(0xff171919);
const Color darkThemePrimaryColorDark = Color(0xff2B2B2B);
const Color darkThemeAccentColor = Color(0xff0044d0);
const Color darkThemeButtonColor = Color(0xff0044d0);
const Color darkThemeCardColor = Color(0xffFFFFFF);
const Color darkThemeSubtitleColor = Color(0xff929294);

const Color amoledThemePrimaryColor = Color(0xff000000);
const Color amoledThemePrimaryColorDark = Color(0xff2B2B2B);
const Color amoledThemeAccentColor = Color(0xff770955);

final List<ThemeData> themes = [lightTheme, darkTheme];

const List<Color> cardColors = [
  Color(0xffadb6c6),
  Color(0xff963e63),
  Color(0xffe6a542),
  Color(0xff519b89),
  Color(0xffab8c67),
  Color(0xffde34a0),
  Color(0xff5a9def),
  Color(0xfff4663c),
  Color(0xffa9c95a),
];

final darkTheme = ThemeData(
  primaryColor: darkThemePrimaryColor,
  primaryColorDark: darkThemePrimaryColorDark,
  indicatorColor: darkThemeButtonColor,
  buttonColor: darkThemeButtonColor,
  accentColor: darkThemeAccentColor,
  hoverColor: darkThemeAccentColor,
  cardColor: darkThemeCardColor,
  canvasColor: Colors.transparent,
  primaryIconTheme: IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    headline4: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 16),
    headline5: TextStyle(
        fontFamily: 'FuturaPTBook.otf',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 16),
    subtitle1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: darkThemeSubtitleColor,
        fontSize: 12),
    bodyText2: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 12),
    bodyText1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 12),
    subtitle2: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 20),
    caption: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 28),
  ),
);

final lightTheme = ThemeData(
  primaryColorDark: lightThemePrimaryColorDark,
  primaryColor: lightThemePrimaryColor,
  buttonColor: lightThemeButtonColor,
  indicatorColor: lightThemeButtonColor,
  accentColor: lightThemeAccentColor,
  hoverColor: lightThemeAccentColor,
  cardColor: lightThemeCardColor,
  canvasColor: Colors.transparent,
  primaryIconTheme: IconThemeData(color: Colors.black),
  textTheme: TextTheme(
    headline4: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 16),
    headline5: TextStyle(
        fontFamily: 'FuturaPTBook.otf',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 16),
    subtitle1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: lightThemeSubtitleColor,
        fontSize: 12),
    bodyText2: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 12),
    bodyText1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 12),
    subtitle2: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 20),
    caption: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 28),
  ),
);
