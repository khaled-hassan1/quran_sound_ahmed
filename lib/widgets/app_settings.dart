import 'package:flutter/material.dart';

import '../provider/lang_provider.dart';

class AppSettings {
  static const double heightContainer = 150;
  static const Color black12 = Color.fromRGBO(0, 0, 0, 0.122);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const TextDirection ltr = TextDirection.ltr;
  static const TextDirection rtl = TextDirection.rtl;
  static const TextAlign textAlignCenter = TextAlign.center;
  static TextStyle copyWith =
      AppSettings.textStyle2.copyWith(fontSize: 12.50, fontFamily: 'Kufam');
  static const List<Color> colors1 = [Colors.white10, Colors.white30];
  static List<Color> colors2 = [
    Colors.green.shade500,
    Colors.greenAccent.shade700
  ];

  static List<Color> colorizeColorsLight = [Colors.greenAccent.shade700];

  static List<Color> colorizeColorsDark = [
    AppSettings.white,
    // const Color.fromARGB(255, 255, 237, 75)
  ];

  static List<Color> colorizeColorsDark2 = [
    // AppSettings.white,
    Colors.yellowAccent.shade400
  ];

  static const TextStyle colorizeTextStyle = TextStyle(
    fontSize: 18.0,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
  );

  static const Color purple1 = Color.fromRGBO(174, 150, 240, 0.925);
  static const Color white70 = Colors.white70;
  static const Color color = Color.fromARGB(255, 241, 238, 238);
  static const Color transparent = Colors.transparent;
  static Color green = Colors.green.shade900;
  static const double iconSize = 30;
  static const TextAlign left = TextAlign.left;
  static const TextAlign right = TextAlign.right;
  static const BoxFit cover = BoxFit.cover;
  static const Color blue = Colors.blue;
  static const TextStyle textStyle1 = TextStyle(fontSize: 18, color: white);
  static const TextStyle textStyle2 = TextStyle(
      fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 17.0);

  static SizedBox sizedBoxHeight(double height) => SizedBox(
        height: height,
      );
  static SizedBox sizedBoxWidth(double width) => SizedBox(
        width: width,
      );

  static EdgeInsets edgeInsetsSymmetric(double horizontal) =>
      EdgeInsets.symmetric(horizontal: horizontal);
  static EdgeInsets edgeInsetsAll(double number) => EdgeInsets.all(number);
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutesPart = twoDigits(duration.inMinutes.remainder(60));
    String secondsPart = twoDigits(duration.inSeconds.remainder(60));
    return '$minutesPart:$secondsPart';
  }

  static BorderRadius borderRadiusCircle(double radius) =>
      BorderRadius.circular(radius);
  static Radius radiusLerp() =>
      Radius.lerp(Radius.zero, const Radius.circular(40), 1)!;

  static Align scrollText(Widget child, LangProvider langProvider) => Align(
        alignment:
            langProvider.isArabic ? Alignment.topLeft : Alignment.topRight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: child,
        ),
      );
  static AssetImage assetImage(String assetImage) => AssetImage(assetImage);
  static Align align(AlignmentGeometry alignment, Padding child) => Align(
        alignment: alignment,
        child: child,
      );
  static Padding padding(Text child) => Padding(
        padding: AppSettings.edgeInsetsAll(6),
        child: child,
      );
}
