
import 'package:debug_tools_wifi/model/register.dart';

class GeneratorPowerData {
  List getGeneratorPowerData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(generatorPowerListData);

    for(int i = 0; i < registerList.length; i++) {
      List list = [];
      RegisterData registerData = registerList[i];
      registerList[i].value = data.sublist(registerData.registerAddressLow * 2, registerData.registerAddressLow * 2 + 4);
      List hexList = data.sublist(registerData.registerAddressLow * 2, registerData.registerAddressLow * 2 + 4);
      //List hexList = data.sublist(i*4, (i+1)*4);
      list.add(registerData);
      list.add(hexList);
      allData.add(list);
    }
    return allData;
  }
}


/// 功率测量
List<RegisterData> generatorPowerListData = [

  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x00,
    addressHigh: '11',
    addressLow: '00',
    content: '功率表通讯规约',
    instructions: '0～999',
    minValue: 0,
    maxValue: 999,
    defaultString: '0~999',
  ),
  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x02,
    addressHigh: '11',
    addressLow: '02',
    content: '功率表通讯地址',
    instructions: '0～255',
    isIpAddress: false,
    defaultString: '0～255',
  ),

  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x04,
    addressHigh: '11',
    addressLow: '04',
    content: 'PT变比',
    instructions: '0.000～999.999(数据放大1000倍)',
    multiple: 1000,
    minValue: 0.000,
    maxValue: 999.999,
    defaultString: '0.000～999.999',
  ),

  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x06,
    addressHigh: '11',
    addressLow: '06',
    content: 'CT变比',
    instructions: '1～9999',
    minValue: 1,
    maxValue: 9999,
    defaultString: '1~9999',
  ),

  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x08,
    addressHigh: '11',
    addressLow: '08',
    content: '水轮机效率',
    instructions: '0.00～99.99%(数据放大100倍)',
    multiple: 100,
    unit: '%',
    minValue: 0.00,
    maxValue: 99.99,
    defaultString: '0.00～99.99%',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x0A,
      addressHigh: '11',
      addressLow: '0A',
      content: '功率分段1',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),
  
  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x22,
      addressHigh: '11',
      addressLow: '22',
      content: '流量分段1',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x0C,
      addressHigh: '11',
      addressLow: '0C',
      content: '功率分段2',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x0E,
      addressHigh: '11',
      addressLow: '0E',
      content: '功率分段3',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x10,
      addressHigh: '11',
      addressLow: '10',
      content: '功率分段4',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x12,
      addressHigh: '11',
      addressLow: '12',
      content: '功率分段5',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x14,
      addressHigh: '11',
      addressLow: '14',
      content: '功率分段6',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x16,
      addressHigh: '11',
      addressLow: '16',
      content: '功率分段7',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x18,
      addressHigh: '11',
      addressLow: '18',
      content: '功率分段8',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x1A,
      addressHigh: '11',
      addressLow: '1A',
      content: '功率分段9',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x1C,
      addressHigh: '11',
      addressLow: '1C',
      content: '功率分段10',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x1E,
      addressHigh: '11',
      addressLow: '1E',
      content: '功率分段11',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x20,
      addressHigh: '11',
      addressLow: '20',
      content: '功率分段12',
      instructions: '0.0～99999.9kW(数据放大10倍)',
      multiple: 10,
      unit: 'kw/h',
    minValue: 0.0,
    maxValue: 99999.9,
    defaultString: '0.0～99999.9',
  ),

  

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x24,
      addressHigh: '11',
      addressLow: '24',
      content: '流量分段2',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x26,
      addressHigh: '11',
      addressLow: '26',
      content: '流量分段3',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x28,
      addressHigh: '11',
      addressLow: '28',
      content: '流量分段4',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x2A,
      addressHigh: '11',
      addressLow: '2A',
      content: '流量分段5',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x2C,
      addressHigh: '11',
      addressLow: '2C',
      content: '流量分段6',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x2E,
      addressHigh: '11',
      addressLow: '2E',
      content: '流量分段7',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x30,
      addressHigh: '11',
      addressLow: '30',
      content: '流量分段8',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x32,
      addressHigh: '11',
      addressLow: '32',
      content: '流量分段9',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x34,
      addressHigh: '11',
      addressLow: '34',
      content: '流量分段10',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x36,
      addressHigh: '11',
      addressLow: '36',
      content: '流量分段11',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x38,
      addressHigh: '11',
      addressLow: '38',
      content: '流量分段12',
      instructions: '0.0000～999.9999 m3/s(数据放大10000倍)',
      multiple: 10000,
      unit: 'm³/s',
    minValue: 0.0,
    maxValue: 999.9999,
    defaultString: '0.0～999.9999',
  ),

  RegisterData(
      registerAddressHigh: 0x11,
      registerAddressLow: 0x3A,
      addressHigh: '11',
      addressLow: '3A',
      content: '曲线点数',
      instructions: '1~12',
    minValue: 1,
    maxValue: 12,
    defaultString: '1~12',
  ),

  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x3C,
    addressHigh: '11',
    addressLow: '3C',
    // content: '备用1',
      content: '备用'
  ),

  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x3E,
    addressHigh: '11',
    addressLow: '3E',
    // content: '备用2',
      content: '备用'
  ),

  RegisterData(
    registerAddressHigh: 0x11,
    registerAddressLow: 0x40,
    addressHigh: '11',
    addressLow: '40',
      content: '备用'
    // content: '备用3',
  ),
];