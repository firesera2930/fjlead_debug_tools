part of login;

class LoginController extends GetxController{

  final connectivityResult = ConnectivityResult.none.obs;

  LoginController();

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
    initConnectivity();
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

  /// 初始化连接状态获取
  Future<void> initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    connectivityResult(result);
    update();
  }
}