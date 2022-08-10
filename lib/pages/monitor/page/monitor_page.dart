import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/monitor/widget/monitor_baseinfo_widget.dart';
import 'package:debug_tools_wifi/pages/monitor/widget/monitor_state_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



/// 实时监测数据
class MonitorPage extends StatefulWidget {
  const MonitorPage({Key? key}) : super(key: key);

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {

  late ThemeController themeController;
  late MonitorController monitorController;
  
  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    monitorController = Get.put(MonitorController());
    initData();
  }

  /// 初始化加载一次数据
  void initData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    monitorController.sendMessage('');
  }
  
  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('实时监测数据'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: 20,
            ),
            
            MonitorStateWidget(),
            MonitorBaseInfoWidget(),
            Expanded(
              child: ListView(
                children: [
                  //MonitorSiteWidget(),
                ],
              )
            ), 

          ],
        ) 
      ),
    );
  }

  /// 功能项
  Widget functionItem({
    required Icon icon,
    required String text,
    required Widget nextPage }){
      
    return InkWell(
      onTap: (){
        //Get.to(() => ReportRootPage());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          height: 80,
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