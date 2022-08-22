import 'package:debug_tools_wifi/model/register.dart';


/// 监测点信息
class MonitorPoint{
  /// 序号 16位
  int serial = 0x00;
  /// 基础信息
  List<RegisterData> baseInfo = [];
  /// 类型
  List<RegisterData> typeInfo = [];
  /// 数据
  List<RegisterData> pointInfo = [];
  /// 整体数据结构
  List<RegisterData> data = [];

  MonitorPoint({
    this.serial = 0x00,
    this.baseInfo = const <RegisterData>[],
    this.typeInfo = const <RegisterData>[],
    this.pointInfo = const <RegisterData>[],
    this.data = const <RegisterData>[]
  });

  MonitorPoint getData(int serial) {
    List<RegisterData> list = [];
    list.addAll(_basicData(serial));
    list.addAll(_typeInfo(serial));
    list.addAll(_dischargeGate(serial));

    return MonitorPoint(
      serial: serial,
      baseInfo: _basicData(serial),
      typeInfo: _typeInfo(serial),
      pointInfo: _dischargeGate(serial),
      data: list
    );
  }
}

/// 监测点类型
enum MonitorPointType{
  dischargeGate,      // 0 泄流闸
  dischargePipe,      // 1 泄流管道
  dischargeChannel,   // 2 泄流明渠
  generatorPower,     // 3 发电机功率
  measuringWeir,      // 4 量水堰
  drainHole           // 5 泄水孔
}


/// 基础信息
List<RegisterData> _basicData(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x00,
      content: '核定流量',
      instructions: '0.000~9999.000,4位小数(数据放大10000倍)，单位： m3/s',
      multiple: 10000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x02,
      content: '数据存储密度',
      instructions: '0~600分钟',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x04,
      content: '电站代码',
      length: 20,
      instructions: 'ASCII码,不足字节补0x0',
      isASCII: true
    ),
  ];
}

/// 类型信息
List<RegisterData> _typeInfo(int serial) {
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x0E,
      content: '监测点数量',
      instructions: '范围:1~6',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x10,
      content: '监测类型',
      instructions: '0~5对应6种监测类型:泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔。用下拉列表框选择。',
    ),
  ];
}

/// 泄流闸
List<RegisterData> _dischargeGate(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x12,
      content: '闸流流量系数',
      instructions: '0.000~1.000,(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x14,
      content: '淹没系数',
      instructions: '0.000~1.000,(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x16,
      content: '闸门底坎高',
      instructions: '0.00~9999.99,(数据放大100倍)，单位： m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x18,
      content: '闸门宽度',
      instructions: '0.000~99.999,数(数据放大1000倍)，单位： m',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1A,
      content: '弧形闸半径',
      instructions: '0.000~99.999,数(数据放大1000倍)，单位： m',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1C,
      content: '底坎类型',
      instructions: '0:宽顶堰  1:实用堰,用下拉列表框选择。',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1E,
      content: '堰流流量系数',
      instructions: '0.000~1.000(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x20,
      content: '摄像头点号',
      instructions: '1~4',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x22,
      content: '水位计数量',
      instructions: '0~2',
    ),
  ];
} 

/// 泄流管道
List<RegisterData> _dischargePipe(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x12,
      content: '流量计起始点号',
      instructions: '1~6',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x14,
      content: '流量计数量',
      instructions: '1~6',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x16,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x18,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1A,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1C,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1E,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x20,
      content: '摄像头点号',
      instructions: '1~4',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x22,
      content: '水位计数量',
      instructions: '0~2',
    ),
  ];
}

/// 泄流明渠
List<RegisterData> _dischargeChannel(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x12,
      content: '明渠底高',
      instructions: '0.00~9999.99,(数据放大100倍)，单位： m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x14,
      content: '明渠底宽',
      instructions: '0.00~99.99(数据放大100倍)，单位： m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x16,
      content: '边坡系数',
      instructions: '0.000~99.999(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x18,
      content: '糙率',
      instructions: '0.000~1.000(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1A,
      content: '底坡',
      instructions: '修改“1:”后面的数,如“1:2000”,改2000,整数',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1C,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1E,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x20,
      content: '摄像头点号',
      instructions: '1~4',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x22,
      content: '水位计数量',
      instructions: '0~2',
    ),
  ];
}

/// 发电机功率
List<RegisterData> _generatorPower(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x12,
      content: '功率测量起始点号',
      instructions: '下拉框选项为“数据点号1~数据点号7,实际下发为 0~6',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x14,
      content: '功率测量点数量',
      instructions: '0~7',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x16,
      content: '功率值',
      instructions: '0.0~99999.9kW,1位小数(数据放大10倍)',
      multiple: 10,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x18,
      content: '流量值',
      instructions: '4位小数(数据放大10000倍)，单位： m3/s',
      multiple: 10000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1A,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1C,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1E,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x20,
      content: '摄像头点号',
      instructions: '1~4',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x22,
      content: '水位计数量',
      instructions: '0~2',
    ),
  ];
} 

/// 量水堰
List<RegisterData> _measuringWeir(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x12,
      content: '流量系数',
      instructions: '0.000~1.000(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x14,
      content: '淹没系数',
      instructions: '0.000~999.999(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x16,
      content: '堰口宽',
      instructions: '0.000~999.999(数据放大1000倍),单位:m',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x18,
      content: '堰顶高',
      instructions: '0.00~9999.99(数据放大100倍),单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1A,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1C,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1E,
      content: '0',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x20,
      content: '摄像头点号',
      instructions: '1~4',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x22,
      content: '水位计数量',
      instructions: '0~2',
    ),
  ];
} 

/// 泄水孔
List<RegisterData> _drainHole(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x12,
      content: '流量系数',
      instructions: '0.000~1.000(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x14,
      content: '淹没系数',
      instructions: '0.000~999.999(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x16,
      content: '孔进口底高',
      instructions: '0.00~9999.99(数据放大100倍),单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x18,
      content: '圆孔直径',
      instructions: '0.000~99.999(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1A,
      content: '方孔宽度',
      instructions: '0.000~99.999(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1C,
      content: '方孔高度',
      instructions: '0.000~99.999(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x1E,
      content: '堰流流量系数',
      instructions: '0.000~1.000(数据放大1000倍)',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x20,
      content: '摄像头点号',
      instructions: '1~4',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x22,
      content: '水位计数量',
      instructions: '0~2',
    ),
  ];
} 