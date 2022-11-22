import 'package:debug_tools_wifi/cache/logs_cache.dart';
import 'package:debug_tools_wifi/cache/storage.dart';
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/model/logs_data.dart';
import 'package:debug_tools_wifi/pages/monitor/model/monitor_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/parameter_base/model/parameters_base_data.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/parameters/page/camera/model/camera_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/camera/model/camera_parm_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/flow_control/model/flow_control_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/master_station/model/master_station_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/aperture_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/flowmeter_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/generator_power_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/monitor_point_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/monitor_point_parmset_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/water_level_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/model/mqtt_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/model/obs_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/model/platform_parm_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';

class MonitorController extends GetxController{
  
  final monitorData = MonitorData().getData.obs;

  final pointData = MonitorPointData().getData.obs;

  final BuildContext context;

  /// 事件类型
  int funcType = 0;

  /// 监测点数量
  final monitorNum = 0.obs;
  /// 核定流量
  final verificationFlow = 0.0.obs;
  /// 瞬时总流量
  final totalFlow = 0.0.obs;
  /// 终端软件版本号
  final version = ''.obs;
  /// 页面显示监测点
  final monitorListData = <List<RegisterData>>[].obs;
  /// 基础参数
  List baseParmListData = [];
  List serialPortListData = [];
  /// 监测点
  final registerPointData = <List<RegisterData>>[];
  /// 监测点参数设置
  List monitorPointSetList = [];
  /// 水位测量设置
  List waterLevelList = [];
  List waterLevelTwoList = [];
  /// 开度测量设置
  List apertureDataList = [];
  /// 流量计
  List flowmeterDataList = [];
  /// 发电机功率
  List generatorPowerDataList = [];
  /// 流量控制参数
  List flowControlDataList = [];
  /// 摄像头参数
  List cameraDataList = [];
  /// 摄像头设置参数
  List cameraParmDataList = [];
  /// 主站参数
  List masterStationDataList = [];
  /// 平台连接参数
  List platformParmDataList = [];
  /// MQTT参数
  List mqttDataList = [];
  List shortMqttDataList = [];
  /// OBS参数
  List obsDataList = [];
  List shortObsDataList = [];
  /// 流量值
  List flowNumberDataList = [];

  SocketConnect socketConnect = SocketConnect();

  MonitorController(this.context);

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    // parameterBaseController = Get.find<ParameterBaseController>();
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
    socketConnect.isConnect ? socketConnect.dispose() : '';
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


  /// 读取信息
  void onRead(List<int> event) {
    // 把event10进制转换为16进制
    String str = intListToDisplayString(event);
    debugPrint('onRead: 数据解析str: $str');
    // event 为10进制数
    debugPrint('数据解析event: $event');
    int eventType = event[7];
    print(eventType);
    List<int> data = event.sublist(9);
    debugPrint('数据解析data: $data');

    funcType = eventType;
    String regH = event[0].toRadixString(16);
    String regL = event[1].toRadixString(16);
    debugPrint('regH:$regH -- regL:$regL');
    if (eventType == 3) { // 读操作
      // 寄存器地址
      if(regH == '0' && regL == '0') {
        // 监测点
        MonitorData monitor = MonitorData().parseData(monitorData.value, data);
        parseInitData();
      } else if(regH == '0' && regL == '4e') {
        // 基本参数
        // 处理数据
        serialPortListData = [];
        List portList = ParametersBaseData().parseSeruakPortData(data);
        serialPortListData.addAll(portList);
      }
      else if(regH == '1' && regL == '0') {
        // 基本参数
        // 处理数据
        baseParmListData = [];
        List baseList = ParametersBaseData().parseData(data);
        baseParmListData.addAll(baseList);
        Future.delayed(const Duration(milliseconds: 100));
        String string = DataTool.sendGetMessageData('00', '4E', 4);
        sendMessage(string);
      } else if(regH == '1' && regL == 'e') {
        // 监测点设置
        MonitorPointData pData = MonitorPointData().parseData(pointData.value, data);
        registerPointData.clear();
        registerPointData.add(pointData.value.baseData);

      } else if((regH == '1'|| regH == '2' || regH == '3' || regH == '4' || regH == '5' || regH == '6') && regL == '10') {
        // 返回迭代器
        List<int> monitorType= event.sublist(9,13);
        int type = ByteTool.codeToInt(monitorType);
        monitorPointSetList = [];
        List dataList = MonitorPointParmSetData().getPointParmSetData(0, type, data);
        monitorPointSetList = dataList;

      } else if ((regH == '1' ||
              regH == '2' ||
              regH == '3' ||
              regH == '4' ||
              regH == '5' ||
              regH == '6') &&
          (regL == '50' || regL == '70')) {
        // 水位测量设置
        if(regL == '50') {
          // 水位点1
          waterLevelList = [];
          List waterList = WaterLevelData().getWaterLevelData(data);
          waterLevelList = waterList;
        } else {
          // 水位点2
          waterLevelTwoList = [];
          List waterTwoList = WaterLevelData().getWaterLevelData(data);
          waterLevelTwoList = waterTwoList;
        }

      } else if((regH == '1'|| regH == '2' || regH == '3' || regH == '4' || regH == '5' || regH == '6') && regL == '32') {
        // 开度
        apertureDataList = [];
        List apertureList = AperTureData().getAperTureData(data);
        apertureDataList = apertureList;
      } else if ((regL == '10' ||
              regL == '20' ||
              regL == '33' ||
              regL == '40' ||
              regL == '50' ||
              regL == '60') &&
          regH == '10') {
        // 流量
        flowmeterDataList = [];
        List lljList= FlowMeterData().getFlowMeterData(data);
        flowmeterDataList = lljList;
      } else if ((regH == '11' ||
              regH == '12' ||
              regH == '13' ||
              regH == '14' ||
              regH == '15' ||
              regH == '16' ||
              regH == '17') &&
          regL == '0') {
        // 功率
        generatorPowerDataList = [];
        List powerList= GeneratorPowerData().getGeneratorPowerData(data);
        generatorPowerDataList = powerList;
      } else if (regH == '7' && regL == '0') {
        // 流量控制
        flowControlDataList = [];
        List flowCList= FlowControlData().getFlowControlData(data);
        flowControlDataList = flowCList;
      } else if (regH == '8' && regL == '0') {
        // 摄像头
        cameraDataList = [];
        List cameraList= CameraData().getCameraData(data);
        cameraDataList = cameraList;
      } else if (regH == '8' && regL == '6') {
        getCameraParmData(1, data);
      } else if (regH == '8' && regL == '1a') {
        getCameraParmData(2, data);
      } else if (regH == '8' && regL == '2e') {
        getCameraParmData(3, data);
      } else if (regH == '8' && regL == '42') {
        getCameraParmData(4, data);
      } else if (regH == '9' && regL == '0') {
        // 主站参数
        masterStationDataList = [];
        List msterSList= MasterStationData().getmasterStationData(data);
        masterStationDataList = msterSList;
      } else if (regH == 'a' && regL == '8') {
        getPlatFormParmData(1, data);
      } else if (regH == 'a' && regL == '14') {
        getPlatFormParmData(2, data);
      } else if (regH == 'a' && regL == '20') {
        getPlatFormParmData(3, data);
      } else if (regH == 'a' && regL == '2c') {
        getPlatFormParmData(4, data);
      } else if (regH == 'b' && regL == '0') {
        // mqtt
        List mqttFirstList= MQTTData().getMQTTData(1,data);
        shortMqttDataList.addAll(mqttFirstList);
        Future.delayed(const Duration(milliseconds: 300),(){
          String string = DataTool.sendGetMessageData('0B', '50', 200);
          sendMessage(string);
        });
      } else if (regH == 'b' && regL == '50') {
        List mqttMiddleList= MQTTData().getMQTTData(2,data);
        mqttDataList = [];
        shortMqttDataList.addAll(mqttMiddleList);
        shortMqttDataList.insertAll(0, []);
        mqttDataList.addAll(shortMqttDataList);
        shortMqttDataList = [];
      } else if (regH == 'c' && regL == '0') {
        // obs
        List obsFirstList= OBSData().getOBSData(1,data);
        shortObsDataList.addAll(obsFirstList);
        Future.delayed(const Duration(milliseconds: 300),(){
          String string = DataTool.sendGetMessageData('0C', '40', 128);
          sendMessage(string);
        });
      } else if (regH == 'c' && regL == '40') {
        List obsMiddleList= OBSData().getOBSData(2,data);
        shortObsDataList.addAll(obsMiddleList);
        Future.delayed(const Duration(milliseconds: 300),(){
          String string = DataTool.sendGetMessageData('0C', '80', 144);
          sendMessage(string);
        });
      } else if (regH == 'c' && regL == '80') {
        List obsLastList= OBSData().getOBSData(3,data);
        obsDataList = [];
        shortObsDataList.addAll(obsLastList);
        obsDataList.addAll(shortObsDataList);
        shortObsDataList = [];
      } else if (regH == '0' && (regL == '8' || regL == '14' || regL == '20' || regL == '2C' || regL == '38' || regL == '44')) {
        // 流量值
        flowNumberDataList = [];
        List flowNL= MonitorPointParmSetData().getFlowNumberData(data);
        flowNumberDataList = flowNL;
      }

      update();
    } else if (eventType == 6 || eventType == 16){ // 写操作
      progressShowSuccess(context, '响应成功');
      /// 根据最新一次的召测命令刷新数据
      // calledMeasurement();
      if((regH == '1'|| regH == '2' || regH == '3' || regH == '4' || regH == '5' || regH == '6') && regL == '10') {
        // 检测点
        String string = DataTool.sendGetMessageData('0$regH', '10', 36);
        print('string:$string');
        sendMessage(string);
        return;
      }

      if((regH == '1' && regL == '0' ) /*||(regH == '0' && regL == '4e')*/) {
        // 基本参数
        // 处理数据
        Future.delayed(const Duration(milliseconds: 100));
        String string1 = DataTool.sendGetMessageData('01', '00', 28);
        sendMessage(string1);
        return;
      }

      if (regH == 'c') {
        Future.delayed(const Duration(milliseconds: 300),(){
          String string = DataTool.sendGetMessageData('0C', '00', 128);
          sendMessage(string);
        });
        return;
      } else if (regH == 'b') {
        Future.delayed(const Duration(milliseconds: 300),(){
          String string = DataTool.sendGetMessageData('0B', '00', 160);
          sendMessage(string);
        });
        return;
      }
      Future.delayed(const Duration(milliseconds: 1000), (){
        List<LogsData> currentData = LogsCache.getInstance().sendLogsList.toList();

        List<LogsData> dataList = currentData.reversed.toList();
        LogsData? logsData;
        for (int i = 0; i < dataList.length; i++) {
          LogsData data = dataList[i];
          List<int> hexList = stringToDisplayIntList(data.byteStr);
          int eventType = hexList[7];
          // print(eventType);
          if (eventType == 3) {
            logsData = data;
            break;
          }
        }
        if (logsData != null) {
          print(logsData.byteStr);
          String msg = logsData.byteStr;
          sendMessage(msg);
        }

      });
    } else {
      progressShowFail(context, '响应失败');
    }
    update();
  }

  void prefsString(String? value) async {
    // print('value:$value');
    await StoragePrefs().setStringPrefs('sendMessage', value ??'');
  }

  void calledMeasurement() async{
    String? sendStr = await StoragePrefs().getString('sendMessage');
    sendMessage('sendStr:$sendStr');
  }

  /// 发送信息
  void sendMessage(String code){

    // List allS = code.split(' ');
    // List<int> hexBytes = [];
    // allS.forEach((element) {
    //   int? hex = ByteTool.hexToInt2(element);
    //   hexBytes.add(hex!);
    // });
    // debugPrint(hexBytes.toString());
    /// 此方法废弃（当16进制值大于3位数会发生错乱）
    List<int> bytes = HEX.decode(code.toString());
    debugPrint(bytes.toString());
    socketConnect.onTapSendBytes(bytes);
  }

  /// 解析初始化数据
  void parseInitData(){
    /// 终端软件版本号
    // version(MonitorData().getCharCodes(monitorData.value.tailData.first.value));
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
      monitorListData.clear();
      for(int i = 0; i < monitorNum.value; i++){
        switch (i+1) {
          case 1:
            monitorListData.add(monitorData.value.monitorOne);
            break;
          case 2:
            monitorListData.add(monitorData.value.monitorTwo);
            break;
          case 3:
            monitorListData.add(monitorData.value.monitorThree);
            break;
          case 4:
            monitorListData.add(monitorData.value.monitorFour);
            break;
          case 5:
            monitorListData.add(monitorData.value.monitorFive);
            break;
          case 6:
            monitorListData.add(monitorData.value.monitorSix);
            break;
          default:
            
        }
      }
    }
    update();
  }

  void getCameraParmData(int type, List<int> data) {
    cameraParmDataList = [];
    List cameraparmList= CameraParmData().getCameraParmData(type,data);
    cameraParmDataList = cameraparmList;
  }

  void getPlatFormParmData(int type, List<int> data) {
    platformParmDataList = [];
    List platList = PlatformParmData().getPlatformParmData(type, data);
    platformParmDataList = platList;
  }
}

