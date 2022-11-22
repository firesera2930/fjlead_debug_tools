part of welcome;

/// 欢迎页面控制
class WelcomeController extends GetxController{

  /// 当前版本
  final displayVersion = ''.obs;
  /// 构建时间
  final displayBuild = ''.obs;

  // String wifiName = '';
  // String wifiBSSID = '';
  // String wifiIP = '';
  // String wifiIPv6 = '';
  // String wifiSubmask = '';
  // String wifiBroadcast = '';
  // String wifiGateway = '';

  WelcomeController();

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
    startVersionDisplayAndCheckTask();
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

  /// 展示版本号
  void showVersions() async {
    displayVersion(AppConfig.getInstance().displayVersion);
    displayBuild(AppConfig.getInstance().displayBuild);
    update();
  }

  /// 版本控制与展示
  void startVersionDisplayAndCheckTask() async {
    try {
      /// 系统信息获取
      await DeviceCache.inspectDevice();
      showVersions();
      await Future.delayed(const Duration(milliseconds: 1500));
      enterApp();
    }
    // 接口失败,或者本地版本获取失败,APP也可以进入 
    catch (e) {
      enterApp();
    }
  }

  /// 进入App
  void enterApp() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.offAll(() => const LoginPage(), transition: Transition.fade, duration: const Duration(seconds: 1));
  }

  // void connect() async {

  //   await Future.delayed(const Duration(seconds: 2));

  //   ConnectivityResult result = await Connectivity().checkConnectivity();
  //   if(result == ConnectivityResult.wifi){
  //     debugPrint('当前网络是WIFI网络');
  //     final info = NetworkInfo();
  //     wifiName = await info.getWifiName() ?? ''; // FooNetwork
  //     wifiBSSID = await info.getWifiBSSID() ?? ''; // 11:22:33:44:55:66
  //     wifiIP = await info.getWifiIP() ?? ''; // 192.168.1.43
  //     wifiIPv6 = await info.getWifiIPv6() ?? ''; // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  //     wifiSubmask = await info.getWifiSubmask() ?? ''; // 255.255.255.0
  //     wifiBroadcast = await info.getWifiBroadcast() ?? ''; // 192.168.1.255
  //     wifiGateway = await info.getWifiGatewayIP() ?? ''; // 192.168.1.1

  //     debugPrint(wifiName);
  //     debugPrint(wifiBSSID);
  //     debugPrint(wifiIP);
  //     debugPrint(wifiIPv6);
  //     debugPrint(wifiSubmask);
  //     debugPrint(wifiBroadcast);
  //     debugPrint(wifiGateway);

  //     if(Platform.isIOS){
  //       info.requestLocationServiceAuthorization();
  //     }
  //   }
  //   NetworkInterface.list().then((List<NetworkInterface> list){
  //     for (var element in list) {
  //       debugPrint(element.name + '   ' + element.addresses.toString());
  //       wifiIP = element.addresses.first.address;
  //     }
  //   });
  // }
}