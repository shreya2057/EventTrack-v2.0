import 'package:flutter/material.dart';

import 'light_color.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    backgroundColor: LightColor.background,
    primaryColor: LightColor.purple,
    accentColor: LightColor.purpleExtraLight,
    cardTheme: CardTheme(color: LightColor.background),
    textTheme: TextTheme(headline4: TextStyle(color: LightColor.black)),
    iconTheme: IconThemeData(color: LightColor.iconColor),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.grey,
    // primaryTextTheme: GoogleFonts.sarabunTextTheme().copyWith(
    //   bodyText2: TextStyle(color: LightColor.titleTextColor),
    // ),
  );

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(
        color: Color(0xffb4b4b4),
        blurRadius: 10,
        offset: Offset(0, 2),
        spreadRadius: 3),
  ];
}
