part of login;


/// 登录界面
class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late LoginController loginController;
  late WelcomeController welcomeController;
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    loginController = Get.put(LoginController());
    welcomeController = Get.find<WelcomeController>();
    themeController = Get.find<ThemeController>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeMode(){
    Get.isDarkMode ? themeController.onChangeMode(ThemeMode.light) : themeController.onChangeMode(ThemeMode.dark);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              
              /// logo
              Positioned(
                top: 90,left: 0,right: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset('images/fjleadlogo.png')
                )
              ),

              /// 版权信息
              Positioned(
                top: 320,left: 0,right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        '力得',
                        style: TextStyle(fontSize: 36)
                      ),
                      Text(
                        '水电平台专用调试工具',
                        style: TextStyle(fontSize: 24)
                      ),
                    ],
                  )
                )
              ),

              /// 按钮
              Positioned(
                bottom: 90,left: 0,right: 0,
                child: Obx(() {
                  ColorScheme colorScheme = themeController.colorScheme.value;
                  bool isWIFI = loginController.connectivityResult.value == ConnectivityResult.wifi;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        Container(
                          height: 54,
                          width: double.infinity,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                              onSurface: isWIFI ? colorScheme.onSurface.withOpacity(0.6) : colorScheme.onSurface,
                              backgroundColor: isWIFI ? colorScheme.background.withOpacity(0.6) : colorScheme.background,
                            ),
                            child: Text(isWIFI ? 'WIFI 已连接' : 'WIFI 未连接',style: TextStyle(color: colorScheme.primary, fontSize: 16)),
                            onPressed: () {
                              freshConnect();
                            },
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          height: 54,
                          width: double.infinity,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                              onSurface: colorScheme.onSurface,
                              backgroundColor: colorScheme.background
                            ),
                            child: Text(isWIFI ? '进  入' : '跳转至手机WIFI设置',style: TextStyle(color: colorScheme.primary, fontSize: 16)),
                            onPressed: () {
                              jumpToNext(isWIFI);
                            },
                          ),
                        )
                      ],
                    )
                  );
                })
              ),

    
              /// 文字
              Positioned(
                bottom: 30,left: 0,right: 0,
                child: Center(
                  child: Column(
                    children: [
                      /// 显示版本
                      Obx(
                        () => Text(welcomeController.displayVersion.value, style: const TextStyle(fontSize: 10))
                      ),
                      /// 构建版本
                      Obx(
                        () => Text(welcomeController.displayBuild.value, style: const TextStyle(fontSize: 10))
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
    );
  }

  /// 刷新连接
  void freshConnect(){
    loginController.initConnectivity();
  }

  /// 进入主页 与 跳转设置项 
  void jumpToNext(bool init) async {
    progressShowLoading(context, '校验网络中...');
    await loginController.initConnectivity();
    bool isWIFI = loginController.connectivityResult.value == ConnectivityResult.wifi;

    await Future.delayed(Duration(milliseconds: 1000));
    progressShowSuccess(context, '校验完成!');

    if(init && isWIFI){
      Get.offAll(() => RootPage());
    }else if((init && !isWIFI) || (!init && isWIFI)){

    }else{
      SystemType systemType = DeviceCache.getInstance().systemType;
      if(systemType == SystemType.mobile){
        AppSettings.openWIFISettings();
      }else{
        progressShowFail(context,'请连接WIFI!');
      }
    }
  }
}