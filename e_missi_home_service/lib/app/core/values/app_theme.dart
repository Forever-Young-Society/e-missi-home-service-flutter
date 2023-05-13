/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:flutter/cupertino.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    Color? buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      canvasColor: background,
      primaryColorDark: Colors.red,
      primarySwatch: Colors.red,
      cardColor: background,
      dividerColor: divider,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      backgroundColor: background,
      primaryColor: accentColor,
      colorScheme: ColorScheme.fromSwatch(
          accentColor: darkkPurple, brightness: brightness),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appColor,
        selectionColor: Colors.orange.shade50,
        selectionHandleColor: appColor,
      ),
      toggleableActiveColor: accentColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: brightness),
        color: Colors.black,
        toolbarTextStyle: TextStyle(
          color: secondaryText,
          fontSize: 18.0.sp,
        ),
        iconTheme: IconThemeData(color: darkGreen, size: height_25),
      ),
      iconTheme: IconThemeData(
        color: darkGreen,
        size: height_25,
      ),
      errorColor: error,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: Colors.purple,
          primaryContainer: accentColor,
          secondary: accentColor,
          secondaryContainer: accentColor,
          surface: background,
          background: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onBackground: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkGreen, width: 1.5),
        ),
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryText.withOpacity(0.5),
        ),
      ),
      fontFamily: 'Urbanist',
      unselectedWidgetColor: HexColor('#DADCDD'),
      textTheme: TextTheme(
        headline1: baseTextTheme.headline1?.copyWith(
          color: primaryText,
          fontSize: font_22,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w700,
        ),
        headline2: baseTextTheme.headline2?.copyWith(
          color: primaryText,
          fontSize: font_18,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w600,
        ),
        bodyText1: baseTextTheme.bodyText1?.copyWith(
          color: primaryText,
          fontSize: font_16,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w500,
        ),
        bodyText2: baseTextTheme.bodyText2?.copyWith(
          color: primaryText,
          fontSize: font_14,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w500,
        ),
        button: baseTextTheme.button?.copyWith(
          color: primaryText,
          fontSize: font_16,
          fontWeight: FontWeight.w600,
        ),
        caption: baseTextTheme.caption?.copyWith(
          color: primaryText,
          fontSize: font_11,
          fontWeight: FontWeight.w300,
        ),
        overline: baseTextTheme.overline?.copyWith(
          color: secondaryText,
          fontSize: font_11,
          fontWeight: FontWeight.w500,
        ),
        subtitle1: baseTextTheme.subtitle1?.copyWith(
          color: primaryText,
          fontSize: font_14,
          fontWeight: FontWeight.w500,
        ),
        subtitle2: baseTextTheme.subtitle2?.copyWith(
          color: secondaryText,
          fontSize: font_12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: Colors.white,
        cardBackground: Colors.white,
        primaryText: Colors.black,
        secondaryText: Colors.white,
        accentColor: secondaryAppColor,
        divider: secondaryAppColor,
        buttonBackground: Colors.black38,
        buttonText: secondaryAppColor,
        disabled: secondaryAppColor,
        error: Colors.red,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: Colors.black,
        cardBackground: secondaryDarkAppColor,
        primaryText: Colors.white,
        secondaryText: Colors.black,
        accentColor: Colors.transparent,
        divider: Colors.black45,
        buttonBackground: Colors.white,
        buttonText: secondaryDarkAppColor,
        disabled: secondaryDarkAppColor,
        error: Colors.red,
      );
}
