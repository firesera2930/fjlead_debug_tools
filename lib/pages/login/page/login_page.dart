import 'package:debug_tools_wifi/pages/welcome/controller/welcome_controller.dart';
import 'package:debug_tools_wifi/theme/theme_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<WelcomeController>();

    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                

                /// 发电从未如此简单 slogan
                Positioned(
                  bottom: 90,left: 0,right: 0,
                  child: Container(
                    color: Colors.black,
                    child: TextButton(
                      child: const Text('切换'),
                      onPressed: (){
                        Get.isDarkMode ? Get.changeThemeMode(ThemeMode.light) : Get.changeThemeMode(ThemeMode.dark);
                        setState(() {});
                      },
                    ),
                  )
                  
                ),

     
                /// 显示版本
                Positioned(
                  bottom: 54,left: 0,right: 0,
                  child: Center(
                    child: Obx(
                      () => Text(controller.displayVersion.value, style: const TextStyle(fontSize: 10))
                    )
                  ),
                ),

                /// 构建版本
                Positioned(
                  bottom: 40,left: 0,right: 0,
                  child: Center(
                    child: Obx(
                      () => Text(controller.displayBuild.value, style: const TextStyle(fontSize: 10))
                    )
                  ),
                ),  

                /// 版权信息
                const Positioned(bottom: 8,left: 0,right: 0,
                    child: Center(child: Text('Copyright @ fjlead 2020-2022',
                    style: TextStyle(fontSize: 10)))),
              ],
            ),
          ),
        ),
      )
    );
  }
}