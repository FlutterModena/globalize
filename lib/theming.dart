import 'package:flutter/material.dart';

const bg_1 = Color(0xFF2F3542);
const bg_2 = Color(0xFFFAFAFA);
var bg_3 = const Color(0xFF747D8C).withAlpha(20);
const bg_4 = Color(0xFF272D38);

var disabled = const Color(0xFFCECECE).withAlpha(50);
const typoMain = Color(0xFFFEFEFE);
const typoSecondary = Color(0xFFCECECE);
const typoSpecial = Color(0xFFFF3E3E);
const typoOnColor = Color(0xFF272D38);

ThemeData appTheme(BuildContext context) => ThemeData(
      fontFamily: 'DM Sans',
      scaffoldBackgroundColor: bg_1,
      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(
          fontSize: 16,
          color: typoMain,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontSize: 16,
            color: typoMain,
          ),
          hintStyle: TextStyle(
            fontSize: 16,
            color: typoMain,
          ),
          contentPadding: EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: typoMain, width: 2),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hoverColor: Colors.transparent,
        suffixIconColor: typoMain,
        prefixIconColor: typoMain,
        fillColor: bg_3,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(24),
      ),
      buttonTheme: const ButtonThemeData(),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
