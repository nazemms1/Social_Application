import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData  darktheme=ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme:  AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle:TextStyle(
      fontFamily: 'Jannah',

      color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold,) ,
    iconTheme:IconThemeData(color: Colors.white,),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,

    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme:   BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor:  HexColor('333739'),
    elevation: 10.0,
  ),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.3,

    ),
  ),
 fontFamily: 'Jannah',
);

ThemeData lighttheme=ThemeData(

    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      titleTextStyle:TextStyle(
        fontFamily: 'Jannah',

        color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold,) ,
      iconTheme:IconThemeData(color: Colors.black,),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,

      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(

      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor:  Colors.white,
      elevation: 10.0,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3,
      ),
    ),
  fontFamily: 'Jannah',
);