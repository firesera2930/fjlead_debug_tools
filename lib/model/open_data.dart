
import 'package:debug_tools_wifi/model/register.dart';

/// 开度数据
class OpenData{
  int serial = 0x00;
  List<RegisterData> openInfo = [];

  OpenData({
    this.serial = 0x00,
    this.openInfo = const <RegisterData>[],
  });

  OpenData getData(int serial){
    return OpenData(
      serial: serial,
      openInfo: _openInfo(serial)
    );
  }
}

/// 开度测量参数
List<RegisterData> _openInfo(int serial){
  return [
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x32,
      content: '开度测量点号',
      instructions: '1~6',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x34,
      content: '量程',
      instructions: '0.000~99.999 m(数据放大100倍),单位:m',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x36,
      content: '修正值',
      instructions: '-9.000~9.999 m(数据放大1000倍),单位:m',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x38,
      content: '获取地址',
      instructions: '4~20mA类型时,只能设为0;RS-485类型时1~255',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x3A,
      content: '获取类型',
      instructions: '用下拉列表选择设置, 0:FMD55_AI, 1:ECU500_AI, 2:规约1, 3:规约2, 4:规约3, 5:规约4',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x3C,
      content: '获取点表',
      instructions: '获取类型=0,获取地址=0, 4~20mA类型时, 电表可设为0、1; 电位器输入时, 可设为2。RS-485类型时, 为开度寄存器地址, 0~999',
      multiple: 1000,
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x3E,
      content: '空量程整定AD',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x40,
      content: '满量程整定AD',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x42,
      content: '当前开度值',
    ),
    RegisterData(
      registerAddressHigh: serial,
      registerAddressLow: 0x44,
      content: '当前AD值',
    ),
  ];
}  