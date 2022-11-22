import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:debug_tools_wifi/cache/device_cache.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/pages/login/login.dart';
import 'package:debug_tools_wifi/pages/parameters/page/camera/page/camera_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/flow_control/page/flow_control_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/master_station/page/master_station_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/page/monitor_point_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/parameter_base/page/parameters_base_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/page/platform_page.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ParametersPage extends StatefulWidget {
  const ParametersPage({Key? key}) : super(key: key);

  @override
  State<ParametersPage> createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {

  late ThemeController themeController;
  late LoginController loginController;

  List parameterList = ['基本参数','监测点参数','流量控制参数','摄像头参数','平台连接参数','设备信息'];

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    loginController = Get.put(LoginController());

    refreshNetWork();
  }

  void refreshNetWork() async{
    await Future.delayed(const Duration(milliseconds: 300));
    loginController.initConnectivity();
  }
  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('运行参数设置'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 60,padding: EdgeInsets.only(left: 15,right: 15),child: wifiWidget(),),
              Expanded(
                  child: ListView.builder(
                itemCount: parameterList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: ListTile(
                      title: Text(parameterList[index]),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(() => ParametersBasePage());
                          break;
                        case 1:
                          Get.to(() => MonitorPointPage());
                          break;
                        case 2:
                          Get.to(() => FlowControlPage());
                          break;
                        case 3:
                          Get.to(() => CameraPage());
                          break;
                        case 4:
                          Get.to(() => PlatformPage());
                          break;
                        case 5:
                          Get.to(() => MasterStationPage());
                          break;
                      }
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
  Widget wifiWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(() {
              bool isWIFI = loginController.connectivityResult.value == ConnectivityResult.wifi;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('当前网络状态：',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Text(isWIFI ? 'WIFI 已连接' : 'WIFI 未连接',style: TextStyle(color: isWIFI ? Colors.blue:Colors.red)),
                ],
              );
            }),
          ),
          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Text('当前网络状态：',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          //       Text('已连接',style: TextStyle(color: Colors.blue)),
          //
          //     ],
          //   ),
          // ),
          SizedBox(width: 20,),
          ElevatedButton(
            child: Text('去设置',style: TextStyle(fontSize: 13),),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(5, 5)),
              padding: MaterialStateProperty.all(EdgeInsets.only(left: 5,right: 5)),),
            onPressed: (){
              SystemType systemType = DeviceCache.getInstance().systemType;
              if(systemType == SystemType.mobile){
                AppSettings.openWIFISettings();
              }else{
                progressShowFail(context,'请连接WIFI!');
              }
            },
          ),
        ],
      ),
    );
  }
}
