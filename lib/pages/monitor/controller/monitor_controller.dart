import 'dart:typed_data';

import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/model/monitor_data.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';

class MonitorController extends GetxController{
  
  final monitorData = MonitorData().getData.obs;

  final BuildContext context;

  /// 监测点数量
  final monitorNum = 0.obs;
  /// 核定流量
  final verificationFlow = 0.0.obs;
  /// 瞬时总流量
  final totalFlow = 0.0.obs;
  /// 终端软件版本号
  final version = ''.obs;
  /// 页面显示监测点
  final registerData = <List<RegisterData>>[].obs;
  

  SocketConnect socketConnect = SocketConnect();

  MonitorController(this.context);

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
      onFinish:(){
        progressShowSuccess(context, '连接成功!');
        update();
      }, 
      onError: () => progressShowFail(context, '连接失败!')
    ).then((value) => socketConnect.lisenData(
      onRead: onRead,
      connectState: (b){
        update();
      }
    ));
  }

  /// 16位解析数字
  int codeToInt(List<int> code){
    Uint8List resultList = Uint8List.fromList(code);
    ByteData byteData = ByteData.view(resultList.buffer);
    return  byteData.getInt32(0);
  }

  /// 读取信息
  void onRead(List<int> event){
    String str = intListToDisplayString(event);
    List<int> data = event.sublist(9);
    
    int res = codeToInt(data);
    MonitorData monitor = MonitorData().parseData(monitorData.value, data);
    String charCode = MonitorData().getCharCodes(monitor.data[39].value);


    debugPrint('数据解析: $res');
    debugPrint('数据解析2: $charCode');
    debugPrint('数据解析3: ${monitor.data[39].value}');
    debugPrint('onRead: ' + str);
   
    parseInitData();
    update();
  }

  /// 发送信息
  void sendMessage(String code){
    List<int> bytes = HEX.decode(code.toString());
    debugPrint(bytes.toString());
    socketConnect.onTapSendBytes(bytes);
  }

  /// 解析初始化数据
  void parseInitData(){
    /// 终端软件版本号
    version(MonitorData().getCharCodes(monitorData.value.tailData.first.value));
    /// 监测点数量
    monitorNum(0);
    /// 核定流量
    verificationFlow(0);
    /// 瞬时总流量
    totalFlow(0);

    monitorData.value.basicData.forEach((element){
      if(element.content == '监测点数量'){
        monitorNum(ByteTool.messageToData(element.value));
      }else if(element.content == '核定流量'){
        verificationFlow(ByteTool.messageToData(element.value) / 10000);
      }else if(element.content == '瞬时总流量'){
        totalFlow(ByteTool.messageToData(element.value) / 10000);
      }
    });
    getList();
    update();
  }

  /// 获取
  void getList(){
    if(monitorNum.value > 0){
      for(int i = 0; i < monitorNum.value; i++){
        switch (monitorNum.value) {
          case 1:
            registerData.add(monitorData.value.monitorOne);
            break;
          case 2:
            registerData.add(monitorData.value.monitorTwo);
            break;
          case 3:
            registerData.add(monitorData.value.monitorThree);
            break;
          case 4:
            registerData.add(monitorData.value.monitorFour);
            break;
          case 5:
            registerData.add(monitorData.value.monitorFive);
            break;
          case 6:
            registerData.add(monitorData.value.monitorSix);
            break;
          default:
            
        }
      }
    }
    update();
  }
  
}