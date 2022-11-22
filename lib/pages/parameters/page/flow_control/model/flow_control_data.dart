
import 'package:debug_tools_wifi/model/register.dart';

class FlowControlData {

  List getFlowControlData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(flowControlListData);

    int l = 0;
    int al = 0;
    for(int i = 0; i < registerList.length; i++) {
      List list = [];
      RegisterData registerData = registerList[i];
      if (i > 0) {
        RegisterData registerDataOld = registerList[i-1];
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

/// 开度
List<RegisterData> flowControlListData = [
  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x00,
    addressHigh: '07',
    addressLow: '00',
    content: '手自动控制模式',
    instructions: '0:手动  1：自动',
  ),
  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x02,
    addressHigh: '07',
    addressLow: '02',
    content: '控制对象',
    instructions: '0/1    0:阀门  1：闸门',
  ),
  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x04,
    addressHigh: '07',
    addressLow: '04',
    content: '回差上限',
    instructions: '0.0000～999.9999m3/s(数据放大10000倍)，4位小数',
    multiple: 10000,
    unit: 'm³/s',
    minValue: 0.0000,
    maxValue: 999.9999,
    defaultString: '0.0000～999.9999',
  ),

  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x06,
    addressHigh: '07',
    addressLow: '06',
    content: '回差下限',
    instructions: '-999.9999～999.9999m3/s(数据放大10000倍)4位小数',
    multiple: 10000,
    unit: 'm³/s',
    minValue: -999.9999,
    maxValue: 999.9999,
    isMinus: true,
    defaultString: '-999.9999～999.9999',
  ),

  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x08,
    addressHigh: '07',
    addressLow: '08',
    content: '大偏差控制时间',
    instructions: '1~9999 单位：(0.1s)',
    minValue: 1,
    multiple: 10,
    maxValue: 9999,
    defaultString: '1~9999',
    unit: 's',
  ),

  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x0A,
    addressHigh: '07',
    addressLow: '0A',
    content: '小偏差控制时间',
    instructions: '1~9999 单位：(0.01s)',
    minValue: 1,
    maxValue: 9999,
    defaultString: '1~9999',
    multiple: 100,
    unit: 's',
  ),

  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x0C,
    addressHigh: '07',
    addressLow: '0C',
    content: '控制时间间隔',
    instructions: '1~9999(s)',
    minValue: 1,
    maxValue: 9999,
    defaultString: '1~9999',
    unit: 's',
  ),

  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x0E,
    addressHigh: '07',
    addressLow: '0E',
    content: '上限告警',
    instructions: '0.0000～999.9999m3/s(数据放大10000倍)，4位小数',
    unit: 'm³/s',
    multiple: 10000,
    minValue: 0.0000,
    maxValue: 999.9999,
    defaultString: '0.0000～999.9999',
  ),

  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x10,
    addressHigh: '07',
    addressLow: '10',
    content: '下限告警',
    instructions: '0.0000～999.9999m3/s(数据放大10000倍)，4位小数',
    unit: 'm³/s',
    multiple: 10000,
    minValue: 0.0000,
    maxValue: 999.9999,
    defaultString: '0.0000～999.9999',
  ),

  RegisterData(
    registerAddressHigh: 0x07,
    registerAddressLow: 0x12,
    addressHigh: '07',
    addressLow: '12',
    content: '开关量输入/输出状态',
    instructions: '位值=0，显示“断开”，位值=1，显示“闭合”',
    isOnlyRead: true
  ),

];