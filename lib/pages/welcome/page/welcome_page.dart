import 'package:debug_tools_wifi/pages/welcome/controller/welcome_controller.dart';
import 'package:debug_tools_wifi/theme/color_schemes.dart';
import 'package:debug_tools_wifi/theme/theme_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 欢迎页面
class WelcomePage extends StatelessWidget {

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(WelcomeController());
   

    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: <Widget>[

                /// 中央水背景图
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                        aspectRatio: 1125 / 664,
                        child: Image.asset('images/welcome/water.png')),
                  ),
                ),

                /// 发电从未如此简单 slogan
                Positioned(bottom: 90,left: 0,right: 0,
                    child: SizedBox(height: 28,
                        child: AspectRatio(aspectRatio: 366 / 84,
                            child: Image.asset('images/welcome/slogan.png')))),

                /// 显示版本
                Positioned(
                  bottom: 54,left: 0,right: 0,
                  child: Center(
                    child: Obx(
                      () => Text(controller.displayVersion.value, style: const TextStyle(color: Colors.white70, fontSize: 10))
                    )
                  ),
                ),

                /// 构建版本
                Positioned(
                  bottom: 40,left: 0,right: 0,
                  child: Center(
                    child: Obx(
                      () => Text(controller.displayBuild.value, style: const TextStyle(color: Colors.white70, fontSize: 10))
                    )
                  ),
                ),  

                /// 版权信息
                const Positioned(bottom: 8,left: 0,right: 0,
                    child: Center(child: Text('Copyright @ fjlead 2020-2022',
                    style: TextStyle(color: Colors.white70, fontSize: 10)))),
              ],
            ),
          ),
        ),
      )
    );
  }
}