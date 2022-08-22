import 'package:debug_tools_wifi/model/monitor_data.dart';
import 'package:debug_tools_wifi/model/register.dart';
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

  /// 页面显示监测点
  List<List<RegisterData>> registerData = [];
  
  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    monitorController = Get.put(MonitorController(context));
    initData();
  }

  /// 初始化加载一次数据
  void initData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    monitorController.sendMessage('00 00 00 00 00 06 68 03 00 00 00 56');
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
              child: Obx(() => ListView.builder(
                itemCount: monitorController.registerData.length,
                itemBuilder: (BuildContext context, int i){
                  return functionItem(
                    icon: Icon(Icons.settings),
                    data: monitorController.registerData[i],
                    i: i,
                    nextPage: Container()
                  );
                }
                  //MonitorSiteWidget(),
              ))
            ), 

          ],
        ) 
      ),
    );
  }

  /// 功能项
  Widget functionItem({
    required Icon icon,
    required List<RegisterData> data,
    required int i,
    required Widget nextPage }){
      
    String title = '监测点${i+1}';
    String typeStr = monitorType[monitorController.codeToInt(data.first.value)] ?? '';
    bool isLong = (typeStr == '发电机功率') || (typeStr == '泄流闸');
 
    return InkWell(
      onTap: (){
        //Get.to(() => ReportRootPage());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          height: 140 + (isLong ? 20 : 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(title, style: TextStyle(fontSize: 16),),
                  ),
                  Container(
                    height: 36,
                    width: 36,
                    child: icon
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text('监测类型', style: TextStyle(fontSize: 16),),
                  ),
                  Center(
                    child: Text(typeStr, style: TextStyle(fontSize: 16),),
                  ),
                ],
              ),
              Container(
                height: 5,
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return registerDataWidget(
                      title: title, 
                      typeStr: typeStr, 
                      data: data[index]);
                  },
                )
              ),
            ],
          )
        ),
      )
    );
  }

  /// 数据
  Widget registerDataWidget({
    required String title,
    required String typeStr,
    required RegisterData data}){

    List<String> list = data.content.split(title); 
    int dataCode = monitorController.codeToInt(data.value);
    String dataStr = '';
    bool isShow = true;

    switch (list.last) {
      case '监测类型': 
        dataStr = monitorType[dataCode] ?? '';
        isShow = false;
        break;
      case '流量': 
        dataStr = '${monitorController.codeToInt(data.value) / data.multiple}' + ' m³/s';
        break;
      case '水位1': 
      case '水位2': 
        dataStr = '${monitorController.codeToInt(data.value) / data.multiple}' + ' m';
        break;
      case '开度': 
        dataStr = '${monitorController.codeToInt(data.value) / data.multiple}' + ' m';
        isShow = typeStr == '泄流闸';
        break;
      case '功率': 
        dataStr = '${monitorController.codeToInt(data.value) / data.multiple}' + ' kW';
        isShow = typeStr == '发电机功率';
        break;
      default:
    }
    
    return isShow ? Container(
      height: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(list.last, style: TextStyle(fontSize: 16),),
          ),
          Center(
            child: Text(dataStr, style: TextStyle(fontSize: 16),),
          ),
        ],
      )
    ) : Container();
  }
}