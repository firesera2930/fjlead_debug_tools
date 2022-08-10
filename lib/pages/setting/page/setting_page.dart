import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// 应用设置页面
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('实时监测数据'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
        body: Column(
          children: [
            
            
            // Expanded(
            //   child: ListView(
            //     children: [
            //       functionItem(
            //         icon: Icon(Icons.data_thresholding, size: 36),
            //         text: '实时监测数据',
            //         nextPage: Container()
            //       )
            //     ],
            //   )
            // ), 
          ],
        ) 
      ),
    );
  }
}