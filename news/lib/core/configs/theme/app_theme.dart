import 'package:flutter/material.dart';
import 'package:news/core/configs/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
      strokeWidth: 2
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      onPrimary: Colors.black,
      onSecondary: Color(0xff4E4B66),
      brightness: Brightness.light,
      onSecondaryContainer: Colors.white,
    ),
    primaryColor: AppColors.primary,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightBackground,
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary
    ),
    searchBarTheme: SearchBarThemeData(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),),

        backgroundColor: WidgetStatePropertyAll(Colors.white)
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightBackground,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2), // viền khi focus
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: const TextStyle(
        color: Color(0xff4E4B66),
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.all(12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(width: 2, color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(width: 2, color: Colors.black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: AppColors.primary,width: 1.2,),
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    ),

  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        strokeWidth: 2
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      brightness: Brightness.dark,
      onSecondaryContainer: Colors.black,
    ),

    primaryColor: AppColors.primary,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkBackground,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary
      ),
    searchBarTheme: SearchBarThemeData(

        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      backgroundColor: WidgetStatePropertyAll(Color(0xff3A3B3C))
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xff3A3B3C),
      hintStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.all(12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(fontSize: 16, color: Colors.white),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    ),
  );
}
