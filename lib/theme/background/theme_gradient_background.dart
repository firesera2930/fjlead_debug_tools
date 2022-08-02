part of theme;


/// 统一渐变色背景
class ThemeGradientBackground extends StatelessWidget {

  final Widget? child;
  const ThemeGradientBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeController themeController = Get.put(ThemeController());

    return  MediaQuery(
      ///不受系统字体缩放影响
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Obx(() {
        ColorScheme theme = themeController.colorScheme.value;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight, // 右上
              end: Alignment.bottomLeft, // 左下
              colors:[
                theme.onBackground,
                theme.secondary,
              ]
            ),
          ),
          child: child,
        );
      })
    );
  }
}