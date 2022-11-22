
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/pages/monitor/model/monitor_data.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/monitor/widget/monitor_baseinfo_widget.dart';
import 'package:debug_tools_wifi/pages/monitor/widget/monitor_state_widget.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/page/monitor_point_parmset_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/parameters_page.dart';
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
    await Future.delayed(const Duration(milliseconds: 1000));
    // monitorController.sendMessage('00 00 00 00 00 06 68 03 00 00 00 56');
    String string1 = DataTool.sendGetMessageData('00', '00', 208);
    print(string1);
    monitorController.sendMessage(string1);
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
          actions: [
            IconButton(onPressed: ()=>Get.to(()=>ParametersPage()), icon: Icon(Icons.settings), color: Colors.white,),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 20,
            ),
            // 连接状态
            MonitorStateWidget(),
            // 基础信息
            MonitorBaseInfoWidget(),
            // 监测点数据
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: monitorController.monitorListData.length,
                itemBuilder: (BuildContext context, int i){
                  return functionItem(
                    icon: Icon(Icons.settings),
                    data: monitorController.monitorListData[i],
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
    String typeStr = monitorType[ByteTool.codeToInt(data.first.value)] ?? '';
    bool isLong = (typeStr == '发电机功率') || (typeStr == '泄流闸');
    List<RegisterData> dotData = monitorController.monitorData.value.monitorFlow;
    RegisterData dotRegDataOne1 = dotData[2*i];
    RegisterData dotRegDataTwo2 = dotData[2*i + 1];
    int dotOne1 = ByteTool.codeToInt(dotRegDataOne1.value);
    int dotTwo2 = ByteTool.codeToInt(dotRegDataTwo2.value);
 
    return InkWell(
      onTap: (){
        //Get.to(() => ReportRootPage());
        int type = ByteTool.codeToInt(data.first.value);
        Get.to(()=>MonitorPointParmSetPage(), arguments: {'type':type,'index':i+1});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          height: 140 + (isLong ? 20 : 0)+(dotOne1 == 6 ? -20 : 0)+(dotTwo2 == 6 ? -20 : 0),
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
                      data: data[index],
                      index: i);
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
    required RegisterData data,
    required int index}){

    List<RegisterData> dotData = monitorController.monitorData.value.monitorFlow;
    RegisterData dotRegDataOne = dotData[2*index];
    RegisterData dotRegDataTwo = dotData[2*index + 1];
    int dotOne = ByteTool.codeToInt(dotRegDataOne.value);
    int dotTwo = ByteTool.codeToInt(dotRegDataTwo.value);

    List<String> list = data.content.split(title); 
    int dataCode = ByteTool.codeToInt(data.value);
    String dataStr = '';
    bool isShow = true;

    switch (list.last) {
      case '监测类型': 
        dataStr = monitorType[dataCode] ?? '';
        isShow = false;
        break;
      case '流量': 
        dataStr = '${ByteTool.codeToInt(data.value) / data.multiple}' + ' m³/s';
        break;
      case '水位1':
        dataStr = '${ByteTool.codeToInt(data.value) / data.multiple}' + ' m';
        isShow = dotOne == 6 ? false : true;
        break;
      case '水位2': 
        dataStr = '${ByteTool.codeToInt(data.value) / data.multiple}' + ' m';
        isShow = dotTwo == 6 ? false : true;
        break;
      case '开度': 
        dataStr = '${ByteTool.codeToInt(data.value) / data.multiple}' + ' m';
        isShow = typeStr == '泄流闸';
        break;
      case '功率': 
        dataStr = '${ByteTool.codeToInt(data.value) / data.multiple}' + ' kW';
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