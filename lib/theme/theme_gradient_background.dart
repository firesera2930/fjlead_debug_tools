


import 'package:debug_tools_wifi/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 统一渐变色背景
class ThemeGradientBackground extends StatelessWidget {

  final Widget? child;
  const ThemeGradientBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ColorScheme theme = Get.isDarkMode ? darkColorScheme : lightColorScheme;

    return  MediaQuery(
      ///不受系统字体缩放影响
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors:[
              theme.onBackground,
              theme.secondary,
            ]
          ),
        ),
        child: child,
      )
    );
  }
}