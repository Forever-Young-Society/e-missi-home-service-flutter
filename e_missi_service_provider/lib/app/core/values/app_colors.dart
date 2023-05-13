/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:flutter/material.dart';

const Color pageBackground = Color(0xFFFAFBFD);
const Color defaultRippleColor = Color(0x0338686A);
Color blackColor = Colors.black;
Color blackLightColor = const Color.fromRGBO(94, 94, 94, 1.0);
Color appColor = const Color.fromRGBO(97, 43, 128, 1.0);
Color appLightColor = const Color.fromRGBO(245, 239, 253, 1.0);
Color buttonColors = const Color.fromRGBO(251, 144, 19, 1.0);
Color buttonLightColor = const Color.fromRGBO(253, 210, 161, 1.0);
Color loginBoxGradient = const Color(0xFFFF9984);
Color loginBoxBack = const Color(0xFFFFCBC0);
Color greenColor = const Color.fromRGBO(52, 187, 125, 1.0);
Color darkGreen = HexColor("#5DE52A");
Color secondaryAppColor = HexColor('#22DDA6');
Color secondaryDarkAppColor = Colors.white;
Color whiteColor = const Color(0xFFFFFFFF);
Color redColor = const Color(0xFFF30808);
Color redLightColor = const Color(0xFF831111);

Color purple = const Color(0xFF322D71);
Color darkkPurple = const Color(0xFF632D82);
Color lightPink = const Color(0xFFF5E7FD);
Color blue = const Color(0xFFE8EDFD);
Color lightgreen = const Color(0xFFEBFEEA);
Color lightGreen = const Color(0xFFE7F3F5);
Color darkPurple = const Color(0xFF632D82);
const Color COLOR_russianVoilet = Color.fromRGBO(49, 37, 98, 1.0);
Color lightPurple = const Color(0xFF797DD1);
Color lightBlue = const Color(0xFFB1CDFF);
const Color color_black_grey = Color.fromRGBO(76, 76, 76, 1.0);

class HexColor extends Color {
  static int getcolorfromHex(String hexcolor) {
    hexcolor = hexcolor.toUpperCase().replaceAll("#", "");
    if (hexcolor.length == 6) {
      hexcolor = "FF" + hexcolor;
    }
    return int.parse(hexcolor, radix: 16);
  }

  HexColor(final String hexColor) : super(getcolorfromHex(hexColor));
}

Color purpleColor = const Color(0xFF797DD1);
