
import 'package:debug_tools_wifi/model/register.dart';

class WaterLevelData {
  List getWaterLevelData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(waterLevelListData);

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

/// 水位测量获取类型
Map<int, String> waterLevelType = {
  0: 'FMD55_AI',
  1: 'ECU500_1',
  2: '规约1',
  3: 'ECU500_2',
  4: 'ECU500_3',
  5: '规约2',
  6: '规约3'
};

/// 泄流匣
List<RegisterData> waterLevelListData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x50,
    addressHigh: '01',
    addressLow: '50',
    content: '水位测量点号',
    instructions: '下拉框选项为“数据点号1～数据点号6实际下发为0～5',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x52,
    addressHigh: '01',
    addressLow: '52',
    content: '量程',
    instructions: '0.000～999.99 m(数据放大100倍)，单位：m',
    multiple: 100,
    unit: 'm',
    minValue: 0.000,
    maxValue: 999.99,
    defaultString: '0.000～999.99',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x54,
    addressHigh: '01',
    addressLow: '54',
    content: '修正值',
    instructions: '-99.000～99.99 m(数据放大100倍)，单位：m',
    multiple: 100,
    unit: 'm',
    minValue: -99.00,
    maxValue: 99.99,
    isMinus: true,
    defaultString: '-99.00～99.99',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x56,
    addressHigh: '01',
    addressLow: '56',
    content: '获取地址',
    instructions: '4～20mA类型时，只能设为0；RS-485类型时1～255',
    // isIpAddress: true,
    defaultString: '000.000.000.000',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x58,
    addressHigh: '01',
    addressLow: '58',
    content: '获取类型',
    instructions: '用下拉列表选择设置0：FMD55_AI1:ECU500_AI2:规约13:规约24:规约35:规约4',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x5A,
    addressHigh: '01',
    addressLow: '5A',
    content: '获取点表',
    instructions: '4～20mA类型时，可设为0、1，RS-485类型时，为水位寄存器地址',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x5C,
    addressHigh: '01',
    addressLow: '5C',
    content: '海拔',
    instructions: '0～10000.00m(数据放大100倍)',
    multiple: 100,
    minValue: 0,
    maxValue: 10000,
    defaultString: '0.00~10000.00',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x5E,
    addressHigh: '01',
    addressLow: '5E',
    content: '当前水位值',
    instructions: '2位小数，(数据放大100倍)，单位： m',
    unit: 'm',
    isOnlyRead: true,
    multiple: 100
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x60,
    addressHigh: '01',
    addressLow: '60',
    content: '当前AD值',
    instructions: '',
    isOnlyRead: true,
  ),

];