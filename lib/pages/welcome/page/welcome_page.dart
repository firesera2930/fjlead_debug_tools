part of welcome;


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

                Positioned(
                  bottom: 30,left: 0,right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        /// 显示版本
                        Obx(
                          () => Text(controller.displayVersion.value, style: const TextStyle(fontSize: 10))
                        ),
                        /// 构建版本
                        Obx(
                          () => Text(controller.displayBuild.value, style: const TextStyle(fontSize: 10))
                        ),
                        /// 版权信息
                        Text(
                          'Copyright @ fjlead 2020-2022',
                          style: TextStyle(fontSize: 10)
                        )
                      ]
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}