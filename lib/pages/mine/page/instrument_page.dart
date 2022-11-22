

import 'dart:async';
import 'dart:io';

import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class InstrumentPage extends StatefulWidget {
  const InstrumentPage({Key? key}) : super(key: key);

  @override
  State<InstrumentPage> createState() => _InstrumentPageState();
}

class _InstrumentPageState extends State<InstrumentPage> {

  late ThemeController themeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('关于'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
        body: Container(
          // child: InAppWebView(
          //   initialUrlRequest: URLRequest(
          //     url: Uri.parse('https://www.baidu.com')
          //   ),
          // ),
        ),
      ),
    );
  }
}
