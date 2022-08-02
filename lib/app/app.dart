import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bmprogresshud/bmprogresshud.dart';

import 'package:debug_tools_wifi/pages/welcome/welcome.dart';
import 'package:debug_tools_wifi/theme/theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressHud(
      isGlobalHud: true,
      child: GetMaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        debugShowCheckedModeBanner: false,
        home: const WelcomePage(),
      )
    );
  }
}