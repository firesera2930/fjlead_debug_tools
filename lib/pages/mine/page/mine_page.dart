import 'package:debug_tools_wifi/app/app_config.dart';
import 'package:debug_tools_wifi/pages/mine/page/instrument_page.dart';
import 'package:debug_tools_wifi/pages/mine/page/setting_page.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// 我的页面
class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  String displayBuild = '';
  String displayVersion = '';

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 初始化数据
  void initData(){
    displayBuild = AppConfig.getInstance().displayBuild;
    displayVersion = AppConfig.getInstance().displayVersion;
  }


  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            
            headerWidget(),
            Expanded(
              child: ListView(
                children: [
                  functionItem(
                    icon: Icon(Icons.settings, size: 36),
                    text: '应用设置',
                    nextPage: SettingPage()
                  ),
                  functionItem(
                    icon: Icon(Icons.info_outline, size: 36),
                    text: '关于',
                    nextPage: InstrumentPage()
                  )
                ],
              )
            ), 
          ],
        ) 
      ),
    );
  }

  /// 页面头部
  Widget headerWidget() {
    return Container(
      height: 220,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),
            Text('力得',style: TextStyle(fontSize: 32)),
            Text('水电平台专用调试工具',style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(displayVersion, style: TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(displayBuild, style: TextStyle(fontSize: 12)),
              ],
            ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }

  /// 功能项
  Widget functionItem({
    required Icon icon,
    required String text,
    required Widget nextPage
  }){
    return InkWell(
      onTap: (){
        Get.to(() => nextPage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                child: icon
              ),
              Center(
                child: Text(text, style: TextStyle(fontSize: 16),),
              ),
            ],
          ),
        ),
      )
    );
  }
}