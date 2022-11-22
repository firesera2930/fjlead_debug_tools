
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/monitor_point_data.dart';

class MonitorPointParmSetData {

  List getPointParmSetData(int pointIndex,int monitorType, List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(codeData);
    switch (monitorType) {
      case 0: registerList.addAll(dischargeTrayData);
      break;
      case 1: registerList.addAll(dischargePipe);
      break;
      case 2: registerList.addAll(dischargeOpenCanalData);
      break;
      case 3: registerList.addAll(generatorPowerData);
      break;
      case 4: registerList.addAll(measuringWeirData);
      break;
      case 5: registerList.addAll(outletEntranceData);
      break;
    }

    int l = 0;
    int al = 0;
    for (int i = 0; i < registerList.length; i++) {
      List list = [];
      RegisterData registerData = registerList[i];
      if (i > 0) {
        RegisterData registerDataOld = registerList[i - 1];
        l = l + registerDataOld.length;
      }
      al = l + registerData.length;
      List hexList = data.sublist(l, al);
      list.add(registerData);
      list.add(hexList);
      allData.add(list);
    }

    return allData;
  }


  List getFlowNumberData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(flowNumberData);
    int l = 0;
    int al = 0;
    for (int i = 0; i < registerList.length; i++) {
      List list = [];
      RegisterData registerData = registerList[i];
      if (i > 0) {
        RegisterData registerDataOld = registerList[i - 1];
        l = l + registerDataOld.length;
      }
      al = l + registerData.length;
      List hexList = data.sublist(l, al);
      list.add(registerData);
      list.add(hexList);
      allData.add(list);
    }

    return allData;
  }

}

/// 基础信息
List<RegisterData> codeData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x10,
    addressHigh: '01',
    addressLow: '10',
    content: '监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔。用下拉列表框选择。',
  ),
];

/// 泄流匣
List<RegisterData> dischargeTrayData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x12,
    addressHigh: '01',
    addressLow: '12',
    content: '闸流流量系数',
    instructions: '0.000～2.000，(数据放大1000倍)',
    multiple: 1000,
    minValue: 0,
    maxValue: 2,
    defaultString: '0.000～2.000',
  ),
  /// 1.4
  // RegisterData(
  //   registerAddressHigh: 0x01,
  //   registerAddressLow: 0x12,
  //   addressHigh: '01',
  //   addressLow: '12',
  //   content: '闸流流量系数',
  //   instructions: '0.000～1.000，(数据放大1000倍)',
  //   multiple: 1000,
  //   minValue: 0,
  //   maxValue: 1,
  //   defaultString: '0.000～1.000',
  // ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x14,
    addressHigh: '01',
    addressLow: '14',
    content: '淹没系数',
    instructions: '0.001～1.000，(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.001,
    maxValue: 1,
    defaultString: '0.001～1.000',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x16,
    addressHigh: '01',
    addressLow: '16',
    content: '闸门底坎高',
    instructions: '0.00～9999.99，(数据放大100倍)，单位： m',
    multiple: 100,
    unit: 'm',
    minValue: 0,
    maxValue: 9999.99,
    defaultString: '0.00～9999.99'
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x18,
    addressHigh: '01',
    addressLow: '18',
    content: '闸门宽度',
    instructions: '0.000～99.999，数(数据放大1000倍)，单位： m',
    multiple: 1000,
    unit: 'm',
    minValue: 0,
    maxValue: 99.999,
    defaultString: '0.000~99.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1A,
    addressHigh: '01',
    addressLow: '1A',
    content: '弧形闸半径',
    instructions: '0.000～99.999，(数据放大1000倍)，单位： m',
    multiple: 1000,
    unit: 'm',
    minValue: 0,
    maxValue: 99.999,
    defaultString: '0.000~99.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1C,
    addressHigh: '01',
    addressLow: '1C',
    content: '底坎类型',
    instructions: '0：宽顶堰  1：实用堰，用下拉列表框选择',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1E,
    addressHigh: '01',
    addressLow: '1E',
    content: '堰流流量系数',
    instructions: '0.000～1.000(数据放大1000倍)',
    multiple: 1000,
    minValue: 0,
    maxValue: 1.000,
    defaultString: '0.000~1.000',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x20,
    addressHigh: '01',
    addressLow: '20',
    content: '摄像头点号',
    instructions: '1～4',
    minValue: 1,
    maxValue: 4,
    defaultString: '1～4',
  ),

  // RegisterData(
  //   registerAddressHigh: 0x01,
  //   registerAddressLow: 0x22,
  //   addressHigh: '01',
  //   addressLow: '22',
  //   content: '水位计数量',
  //   instructions: '1～2',
  //   minValue: 1,
  //   maxValue: 2,
  //   defaultString: '1～2',
  // ),
];

/// 泄流管道
List<RegisterData> dischargePipe = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x12,
    addressHigh: '01',
    addressLow: '12',
    content: '流量计起始点号',
    instructions: '1-6',
    minValue: 1,
    maxValue: 6,
    defaultString: '1～6',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x14,
    addressHigh: '01',
    addressLow: '14',
    content: '流量计数量',
    instructions: '1-6',
    minValue: 1,
    maxValue: 6,
    defaultString: '1～6',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x16,
    addressHigh: '01',
    addressLow: '16',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x18,
    addressHigh: '01',
    addressLow: '18',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1A,
    addressHigh: '01',
    addressLow: '1A',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1C,
    addressHigh: '01',
    addressLow: '1C',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1E,
    addressHigh: '01',
    addressLow: '1E',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x20,
    addressHigh: '01',
    addressLow: '20',
    content: '摄像头点号',
    instructions: '1～4',
    minValue: 1,
    maxValue: 4,
    defaultString: '1～4',
  ),

  // RegisterData(
  //   registerAddressHigh: 0x01,
  //   registerAddressLow: 0x22,
  //   addressHigh: '01',
  //   addressLow: '22',
  //   content: '水位计数量',
  //   instructions: '1～2',
  //   minValue: 1,
  //   maxValue: 2,
  //   defaultString: '1～2',
  // ),
];


/// 泄流明渠
List<RegisterData> dischargeOpenCanalData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x12,
    addressHigh: '01',
    addressLow: '12',
    content: '明渠底高',
    instructions: '0.00～9999.99，(数据放大100倍)，单位： m',
    multiple: 100,
    unit: 'm',
    minValue: 0.00,
    maxValue: 9999.99,
    defaultString: '0.00~9999.99'
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x14,
    addressHigh: '01',
    addressLow: '14',
    content: '明渠底宽',
    instructions: '0.00～99.99(数据放大100倍)，单位： m',
    multiple: 100,
    unit: 'm',
    minValue: 0,
    maxValue: 99.99,
    defaultString: '0.00~99.99',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x16,
    addressHigh: '01',
    addressLow: '16',
    content: '边坡系数',
    instructions: '0.000～99.999(数据放大1000倍)',
    multiple: 1000,
    minValue: 0,
    maxValue: 99.999,
    defaultString: '0.000~99.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x18,
    addressHigh: '01',
    addressLow: '18',
    content: '糙率',
    instructions: '0.000～1.000(数据放大1000倍)',
    multiple: 1000,
    minValue: 0,
    maxValue: 1,
    defaultString: '0.000~1.000',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1A,
    addressHigh: '01',
    addressLow: '1A',
    content: '底坡',
    instructions: '修改“1:”后面的数,如“1：2000”，改2000，整数',
    minValue: 0,
    maxValue: 9999,
    defaultString: '1～9999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1C,
    addressHigh: '01',
    addressLow: '1C',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1E,
    addressHigh: '01',
    addressLow: '1E',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x20,
    addressHigh: '01',
    addressLow: '20',
    content: '摄像头点号',
    instructions: '1～4',
    minValue: 1,
    maxValue: 4,
    defaultString: '1～4',
  ),

  // RegisterData(
  //   registerAddressHigh: 0x01,
  //   registerAddressLow: 0x22,
  //   addressHigh: '01',
  //   addressLow: '22',
  //   content: '水位计数量',
  //   instructions: '1～2',
  //   minValue: 1,
  //   maxValue: 2,
  //   defaultString: '1～2',
  // ),
];

/// 发电机功率
List<RegisterData> generatorPowerData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x12,
    addressHigh: '01',
    addressLow: '12',
    content: '功率测量起始点号',
    instructions: '下拉框选项为“数据点号1～数据点号7，实际下发为0～6',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x14,
    addressHigh: '01',
    addressLow: '14',
    content: '功率测量点数量',
    instructions: '0～7',
    minValue: 0,
    maxValue: 7,
    defaultString: '0～7',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x16,
    addressHigh: '01',
    addressLow: '16',
    content: '功率值',
    instructions: '0.0～99999.9kW，1位小数(数据放大10倍)',
    multiple: 10,
    unit: 'kw',
    isOnlyRead: true,
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x18,
    addressHigh: '01',
    addressLow: '18',
    content: '流量值',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    unit: 'm³/s',
    isOnlyRead: true,
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1A,
    addressHigh: '01',
    addressLow: '1A',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1C,
    addressHigh: '01',
    addressLow: '1C',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1E,
    addressHigh: '01',
    addressLow: '1E',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x20,
    addressHigh: '01',
    addressLow: '20',
    content: '摄像头点号',
    instructions: '1～4',
    minValue: 1,
    maxValue: 4,
    defaultString: '1～4',
  ),

  // RegisterData(
  //   registerAddressHigh: 0x01,
  //   registerAddressLow: 0x22,
  //   addressHigh: '01',
  //   addressLow: '22',
  //   content: '水位计数量',
  //   instructions: '1～2',
  //   minValue: 1,
  //   maxValue: 2,
  //   defaultString: '1～2',
  // ),
];

/// 量水堰
List<RegisterData> measuringWeirData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x12,
    addressHigh: '01',
    addressLow: '12',
    content: '流量系数',
    instructions: '0.000～1.000(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.000,
    maxValue: 1.000,
    defaultString: '0.000~1.000',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x14,
    addressHigh: '01',
    addressLow: '14',
    content: '淹没系数',
    instructions: '0.000～999.999(数据放大1000倍)',
    multiple: 1000,
    minValue: 0,
    maxValue: 999.999,
    defaultString: '0.000~999.999',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x16,
    addressHigh: '01',
    addressLow: '16',
    content: '堰口宽',
    instructions: '0.000～999.999(数据放大1000倍)，单位：m',
    multiple: 1000,
    unit: 'm',
    minValue: 0.000,
    maxValue: 999.999,
    defaultString: '0.000～999.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x18,
    addressHigh: '01',
    addressLow: '18',
    content: '堰顶高',
    instructions: '0.00～9999.99(数据放大100倍)，单位：m',
    multiple: 100,
    unit: 'm',
    minValue: 0.00,
    maxValue: 9999.99,
    defaultString: '0.00~9999.99',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1A,
    addressHigh: '01',
    addressLow: '1A',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1C,
    addressHigh: '01',
    addressLow: '1C',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1E,
    addressHigh: '01',
    addressLow: '1E',
    content: '0',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x20,
    addressHigh: '01',
    addressLow: '20',
    content: '摄像头点号',
    instructions: '1～4',
    minValue: 1,
    maxValue: 4,
    defaultString: '1~4',
  ),

  // RegisterData(
  //   registerAddressHigh: 0x01,
  //   registerAddressLow: 0x22,
  //   addressHigh: '01',
  //   addressLow: '22',
  //   content: '水位计数量',
  //   instructions: '1～2',
  //   minValue: 1,
  //   maxValue: 2,
  //   defaultString: '1~2',
  // ),
];

/// 泄水孔
List<RegisterData> outletEntranceData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x12,
    addressHigh: '01',
    addressLow: '12',
    content: '孔流流量系数',
    instructions: '0.000～1.000(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.000,
    maxValue: 1.000,
    defaultString: '0.000~1.000',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x14,
    addressHigh: '01',
    addressLow: '14',
    content: '淹没系数',
    instructions: '0.000～1.000(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.000,
    maxValue: 1.000,
    defaultString: '0.000~1.000',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x16,
    addressHigh: '01',
    addressLow: '16',
    content: '孔进口底高',
    instructions: '0.00～9999.99，(数据放大100倍)，单位： m',
    multiple: 100,
    unit: 'm',
    minValue: 0.00,
    maxValue: 9999.99,
    defaultString: '0.00~9999.99',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x18,
    addressHigh: '01',
    addressLow: '18',
    content: '圆孔直径',
    instructions: '0.000～99.999，数(数据放大1000倍)，单位： m',
    multiple: 1000,
    unit: 'm',
    minValue: 0,
    maxValue: 99.999,
    defaultString: '0.000~99.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1A,
    addressHigh: '01',
    addressLow: '1A',
    content: '方孔宽度',
    instructions: '0.000～99.999(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.000,
    maxValue: 99.999,
    defaultString: '0.000~99.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1C,
    addressHigh: '01',
    addressLow: '1C',
    content: '方孔高度',
    instructions: '0.000～99.999(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.000,
    maxValue: 99.999,
    defaultString: '0.000~99.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x1E,
    addressHigh: '01',
    addressLow: '1E',
    content: '堰流流量系数',
    instructions: '0.000～1.000(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.000,
    maxValue: 1.000,
    defaultString: '0.000~1.000',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x20,
    addressHigh: '01',
    addressLow: '20',
    content: '摄像头点号',
    instructions: '1～4',
    minValue: 1,
    maxValue: 4,
    defaultString: '1~4',
  ),

  // RegisterData(
  //   registerAddressHigh: 0x01,
  //   registerAddressLow: 0x22,
  //   addressHigh: '01',
  //   addressLow: '22',
  //   content: '水位计数量',
  //   instructions: '1～2',
  //   minValue: 1,
  //   maxValue: 2,
  //   defaultString: '1~2',
  // ),
];


/// 泄水孔
List<RegisterData> flowNumberData = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x08,
    addressHigh: '01',
    addressLow: '20',
    content: '4位小数(数据放大10000倍)，单位： m3/s',
    unit: 'm³/s',
    multiple: 10000,
    isOnlyRead: true
  ),
];