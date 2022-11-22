
import 'package:debug_tools_wifi/model/register.dart';

class FlowMeterData {
  List getFlowMeterData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(flowMeterListData);

    for(int i = 0; i < registerList.length; i++) {
      List list = [];
      RegisterData registerData = registerList[i];
      List hexList = data.sublist(i*4, (i+1)*4);
      list.add(registerData);
      list.add(hexList);
      allData.add(list);
    }
    return allData;
  }
}

/// 流量计
List<RegisterData> flowMeterListData = [

  RegisterData(
    registerAddressHigh: 0x10,
    registerAddressLow: 0x10,
    addressHigh: '10',
    addressLow: '10',
    content: '量程',
    instructions: '0.0000～9.9999 m3/s(数据放大10000倍)',
    multiple: 10000,
    unit: 'm³/s',
    minValue: 0.0000,
    maxValue: 9.9999,
    defaultString: '0.0000～9.9999',
  ),
  RegisterData(
    registerAddressHigh: 0x10,
    registerAddressLow: 0x12,
    addressHigh: '10',
    addressLow: '12',
    content: '修正值',
    instructions: '-9.9999～9.9999 m3/s(数据放大10000倍)',
    multiple: 10000,
    unit: 'm³/s',
    minValue: -9.9999,
    isMinus: true,
    maxValue: 9.9999,
    defaultString: '-9.9999～9.9999',
  ),

  RegisterData(
    registerAddressHigh: 0x10,
    registerAddressLow: 0x14,
    addressHigh: '10',
    addressLow: '14',
    content: '获取地址',
    instructions: '0～255',
    // isIpAddress: true,
    defaultString: '0～255',
  ),

  RegisterData(
    registerAddressHigh: 0x10,
    registerAddressLow: 0x16,
    addressHigh: '10',
    addressLow: '16',
    content: '获取点表',
    instructions: '0～999',
    minValue: 0,
    maxValue: 999,
    defaultString: '0~999',
  ),

  RegisterData(
    registerAddressHigh: 0x10,
    registerAddressLow: 0x18,
    addressHigh: '10',
    addressLow: '18',
    content: '获取类型',
    instructions: '用下拉列表选择设置0：FMD55_AI1:ECU500_AI2:规约13:规约24:规约35:规约4',
  ),

  RegisterData(
    registerAddressHigh: 0x10,
    registerAddressLow: 0x1A,
    addressHigh: '10',
    addressLow: '1A',
    content: '流量值',
    instructions: '单位：m3/s，4位小数(数据放大10000倍)',
    isOnlyRead: true,
    unit: 'm³/s',
    multiple: 10000

  ),

  RegisterData(
    registerAddressHigh: 0x10,
    registerAddressLow: 0x1C,
    addressHigh: '10',
    addressLow: '1C',
    content: 'AD值',
    instructions: '单位：mA ，2位小数(数据放大100倍)',
    unit: 'mA',
    isOnlyRead: true,
    multiple: 100,
  ),
];