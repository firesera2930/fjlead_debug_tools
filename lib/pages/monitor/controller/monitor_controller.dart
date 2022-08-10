import 'dart:typed_data';

import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/model/monitor_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';

class MonitorController extends GetxController{
  
  final monitorData = MonitorData().getData.obs;

  SocketConnect socketConnect = SocketConnect();

  MonitorController();

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    onInitConnect();
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

  /// 初始化连接 并且 监听返回数据
  void onInitConnect(){
    socketConnect.onTapConnect(
      onFinish:() => update(),
    ).then((value) => socketConnect.lisenData(
      onRead: onRead,
      connectState: (b){
        update();
      }
    ));
  }

  /// 读取信息
  void onRead(List<int> event){
    String str = intListToDisplayString(event);
    List<int> data = event.sublist(9);
    
    Uint8List resultList = Uint8List.fromList(data);
    ByteData byteData = ByteData.view(resultList.buffer);
    int res = byteData.getInt32(0);
    MonitorData monitor = MonitorData().parseData(monitorData.value, data);
    String charCode = MonitorData().getCharCodes(monitor.data[39].value);

    int high = ByteTool.high(1000);
    int low = ByteTool.low(1000);

    debugPrint('high: $high');
    debugPrint('low: $low');

    debugPrint('数据解析: $res');
    debugPrint('数据解析2: $charCode');
    debugPrint('数据解析3: ${monitor.data[39].value}');
    debugPrint('onRead: ' + str);

    update();
  }

  void sendMessage(String code){
    String list = '00 00 00 00 00 06 68 03 00 00 00 56';
    int size = 0;
    
    for(var item in monitorData.value.data){
      size += item.length;
    }
    int fontSize = size~/2;
    String str = HEX.encode([fontSize]);

    List<int> bytes = HEX.decode(list.toString());
    debugPrint(bytes.toString());
    String string = intListToDisplayString(bytes);
    debugPrint(string);

    debugPrint(stringToDisplayIntList(string).toString());
    socketConnect.onTapSendBytes(bytes);
  }
}