import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servispasaoglu_v3/main.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      fontFamily: 'Eurostile',
      primaryColor: Colors.white,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color.fromARGB(255, 211, 211, 211),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.white, // Color for Android
              statusBarBrightness:
                  Brightness.dark // Dark == white status bar -- for IOS.
              ),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16.0),
          color: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      colorScheme: const ColorScheme.light(
        background: Color.fromARGB(255, 211, 211, 211),
        error: Colors.red,
        onError: Colors.black,
        surface: Color.fromARGB(255, 211, 211, 211),
        onSurface: Colors.black,
        primary: Colors.white,
        onPrimary: Colors.black,
        primaryContainer: Colors.white,
        secondary: Color.fromARGB(255, 255, 40, 0),
        onSecondary: Colors.white,
        secondaryContainer: Color.fromARGB(170, 255, 40, 0),
        onBackground: Colors.black,
      ),
      cardTheme: CardTheme(
          color: Colors.grey.shade200, shadowColor: Colors.grey.shade50),
      iconTheme: const IconThemeData(color: Colors.black87),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
      )),
      bottomAppBarTheme:
          const BottomAppBarTheme(color: Color.fromARGB(255, 255, 40, 0)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 255, 40, 0)),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 255, 40, 0),
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ));

  static final ThemeData darkTheme = ThemeData(
      fontFamily: 'Eurostile',
      useMaterial3: true,
      primaryColor: HexColor.fromHex("#c0c6c8"),
      scaffoldBackgroundColor: HexColor.fromHex("#121212"),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.black, // Color for Android
              statusBarBrightness:
                  Brightness.dark // Dark == white status bar -- for IOS.
              ),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16.0),
          color: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      colorScheme: ColorScheme.dark(
        primary: HexColor.fromHex("#c0c6c8"),
        onPrimary: Colors.black,
        primaryContainer: Colors.grey.shade200,
        secondary: HexColor.fromHex("#03DAC6"),
        secondaryContainer: Colors.grey,
        onSecondary: Colors.black,
        background: HexColor.fromHex("#121212"),
        onBackground: HexColor.fromHex("#FFFFFF"),
        error: HexColor.fromHex("#CF6679"),
        onError: Colors.black,
        surface: HexColor.fromHex("#121212"),
        onSurface: HexColor.fromHex("#FFFFFF"),
      ),
      cardTheme: CardTheme(
          color: Colors.grey.shade600, shadowColor: Colors.grey.shade50),
      iconTheme: const IconThemeData(color: Colors.white54),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
      )),
      bottomAppBarTheme:
          const BottomAppBarTheme(color: Color.fromARGB(255, 255, 40, 0)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 255, 40, 0)),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 255, 40, 0),
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ));
}
