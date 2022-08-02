part of theme;

/// 主题控制器
class ThemeController extends GetxController{


  /// 当前主题模式
  final themeMode = ThemeMode.system.obs;
  /// 当前配色方案
  final colorScheme = lightColorScheme.obs;
  ThemeController();

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    colorScheme(Get.isDarkMode ? darkColorScheme : lightColorScheme);
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }

  /// 切换主题
  void onChangeMode(ThemeMode mode){
    if(mode == ThemeMode.system){
      if(Get.isDarkMode){
        Get.changeThemeMode(ThemeMode.light);
        colorScheme(lightColorScheme);
      }else{
        Get.changeThemeMode(ThemeMode.dark);
        colorScheme(darkColorScheme);
      }
    }else if(mode == ThemeMode.dark){
      Get.changeThemeMode(ThemeMode.dark);
      colorScheme(darkColorScheme);
    }else if(mode == ThemeMode.light){
      Get.changeThemeMode(ThemeMode.light);
      colorScheme(lightColorScheme);
    } 
    themeMode(mode);
    update();
  }

  

}