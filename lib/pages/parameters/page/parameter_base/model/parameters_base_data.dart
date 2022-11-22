
import 'package:debug_tools_wifi/model/register.dart';

class ParametersBaseData{

  List parseData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList = [];
    registerList.addAll(_baseData);

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

  List parseSeruakPortData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList = [];
    registerList.addAll(_serialPortData);

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

List<RegisterData> _serialPortData = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x4E,
    addressHigh: '00',
    addressLow: '4E',
    content: '外设用串口',
    instructions: '0:RS485-1 、  1:RS485-2 ，下拉列表选择',
  ),
];


/// 基础信息
List<RegisterData> _baseData = [

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x00,
    addressHigh: '01',
    addressLow: '00',
    content: '核定流量',
    instructions: '0.000～9999.0004位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    unit: 'm³/s',
    minValue: 0.000,
    maxValue: 9999.000,
    defaultString: '0.000～9999.000',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x02,
    addressHigh: '01',
    addressLow: '02',
    content: '数据存储密度',
    instructions: '0～600分钟',
    unit: 'min',
    minValue: 0,
    maxValue: 600,
    defaultString: '0～600分钟',

  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x04,
    addressHigh: '01',
    addressLow: '04',
    content: '电站代码',
    instructions: 'ASCII码,不足字节补0x0',
    length: 20,
    isASCII: true,
    minValue: 1,
    maxValue: 20,
    defaultString: '1-20个字符',
  ),
];