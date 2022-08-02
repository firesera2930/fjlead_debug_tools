import 'dart:typed_data';

import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/model/monitor_data.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';



/// 实时监测数据
class MonitorPage extends StatefulWidget {
  const MonitorPage({Key? key}) : super(key: key);

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {

  late ThemeController themeController;
  late MonitorController monitorController;
  SocketConnect _socketConnect = SocketConnect();
  MonitorData monitorData = MonitorData().getData;

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    monitorController = Get.put(MonitorController());
    onInitConnect();
  }

  /// 初始化连接 并且 监听返回数据
  void onInitConnect(){
    _socketConnect.onTapConnect().then((value) => _socketConnect.lisenData(onRead: onRead));
  }

  void onRead(List<int> event){
    String str = intListToDisplayString(event);
    List<int> data = event.sublist(9);
    
    Uint8List resultList = Uint8List.fromList(data);
    ByteData byteData = ByteData.view(resultList.buffer);
    int res = byteData.getInt32(0);
    MonitorData monitor = MonitorData().parseData(monitorData, data);
    String charCode = MonitorData().getCharCodes(monitor.data[39].value);

    int high = ByteTool.high(1000);
    int low = ByteTool.low(1000);

    debugPrint('high: $high');
    debugPrint('low: $low');

    debugPrint('数据解析: $res');
    debugPrint('数据解析2: $charCode');
    debugPrint('数据解析3: ${monitor.data[39].value}');
    debugPrint('onRead: ' + str);
  }
  
  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('实时监测数据'),
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
          actions: [
            SizedBox(
              height: 24,
              width: 24,
              child: Icon(Icons.menu),
            ),
            Container(
              width: 10,
            )
          ]
        ),
        body: Column(
          children: [
            Container(
              height: 20,
            ),
            
            stateWidget(),
            Expanded(
              child: ListView(
                children: [
                  functionItem(
                    icon: Icon(Icons.data_thresholding, size: 36),
                    text: '实时监测数据',
                    nextPage: Container()
                  )
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
    required Widget nextPage
  }){
    return InkWell(
      onTap: () async {
        
        String list = '000000000006680300000056';
        int size = 0;
        
        for(var item in monitorData.data){
          size += item.length;
        }
        int fontSize = size~/2;
        String str = HEX.encode([fontSize]);

        debugPrint(size.toString());

        debugPrint(str);

        List<int> bytes = HEX.decode(list.toString());
        
        _socketConnect.onTapSendBytes(bytes);
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


  Widget stateWidget(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Text('连接状态', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}