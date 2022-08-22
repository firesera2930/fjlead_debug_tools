
import 'package:debug_tools_wifi/model/register.dart';

/// 水位数据
class WaterData{
  int serial = 0x00;
  List<RegisterData> waterOne = [];
  List<RegisterData> waterTwo = [];

  WaterData({
    this.serial = 0x00,
    this.waterOne = const <RegisterData>[],
    this.waterTwo = const <RegisterData>[]
  });

  WaterData getData(int serial){
    return WaterData(
      serial: serial,
      waterOne: _waterOne(serial),
      waterTwo: _waterTwo(serial)
    );
  }
}


/// 水位测量点1
List<RegisterData> _waterOne(int serial){
  return  [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x50,
      content: '水位测量点号',
      instructions: '下拉框选项为“数据点号1~数据点号6 实际下发为 0~5',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x52,
      content: '量程',
      instructions: '0.000~999.99 m(数据放大100倍),单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x54,
      content: '修正值',
      instructions: '-99.000~99.99 m(数据放大100倍),单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x56,
      content: '获取地址',
      instructions: '4~20mA类型时,只能设为0;RS-485类型时1~255',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x58,
      content: '获取类型',
      instructions: '用下拉列表选择设置, 0:FMD55_AI, 1:ECU500_AI, 2:规约1, 3:规约2, 4:规约3, 5:规约4',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x5A,
      content: '获取点表',
      instructions: '4~20mA类型时,可设为0、1, RS-485类型时, 为水位寄存器地址',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x5C,
      content: '海拔',
      instructions: '0~10000.00m(数据放大100倍)',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x5E,
      content: '当前水位值',
      instructions: '2位小数, (数据放大100倍), 单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x60,
      content: '当前AD值',
    ),
  ];
}

/// 水位测量点2
List<RegisterData> _waterTwo(int serial){
  return  [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x70,
      content: '水位测量点号',
      instructions: '下拉框选项为“数据点号1~数据点号6 实际下发为 0~5',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x72,
      content: '量程',
      instructions: '0.000~999.99 m(数据放大100倍),单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x74,
      content: '修正值',
      instructions: '-99.000~99.99 m(数据放大100倍),单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x76,
      content: '获取地址',
      instructions: '4~20mA类型时,只能设为0;RS-485类型时1~255',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x78,
      content: '获取类型',
      instructions: '用下拉列表选择设置, 0:FMD55_AI, 1:ECU500_AI, 2:规约1, 3:规约2, 4:规约3, 5:规约4',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x7A,
      content: '获取点表',
      instructions: '4~20mA类型时,可设为0、1, RS-485类型时, 为水位寄存器地址',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x7C,
      content: '海拔',
      instructions: '0~10000.00m(数据放大100倍)',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x7E,
      content: '当前水位值',
      instructions: '2位小数, (数据放大100倍), 单位:m',
      multiple: 100,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x80,
      content: '当前AD值',
    ),
  ];
}