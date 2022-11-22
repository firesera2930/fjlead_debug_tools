
import 'package:debug_tools_wifi/model/register.dart';

class AperTureData {
  List getAperTureData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(apertureListData);

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

/// 开度
List<RegisterData> apertureListData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x32,
    addressHigh: '01',
    addressLow: '32',
    content: '开度测量点号',
    instructions: '1～6',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x34,
    addressHigh: '01',
    addressLow: '34',
    content: '量程',
    instructions: '0.000～99.999 m(数据放大1000倍)，单位：m',
    multiple: 1000,
    unit: 'm',
    minValue: 0.000,
    maxValue: 99.999,
    defaultString: '0.000~99.999',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x36,
    addressHigh: '01',
    addressLow: '36',
    content: '修正值',
    instructions: '-9.000～9.999 m(数据放大1000倍)，单位：m',
    multiple: 1000,
    unit: 'm',
    minValue: -9,
    maxValue: 9.999,
    isMinus: true,
    defaultString: '-9.000～9.999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x38,
    addressHigh: '01',
    addressLow: '38',
    content: '获取地址',
    instructions: '获取类型为“FMD55_AI”，只能设为0；获取类型为“ECU500_x”或“规约x”时，设为ECU500模块或485型开度计对应的通讯地址，范围：1～255',
    defaultString: '获取地址',
    // isIpAddress: true
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x3A,
    addressHigh: '01',
    addressLow: '3A',
    content: '获取类型',
    instructions: '用下拉列表选择设置0：FMD55_AI1:ECU500_AI2:规约13:规约24:规约35:规约4',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x3C,
    addressHigh: '01',
    addressLow: '3C',
    content: '获取点表',
    instructions: '获取类型为“FMD55_AI”或“ECU500_x”时，设置范围为0～1；获取类型为“规约x”时，为485型开度计开度数据寄存器地址，范围：0～9999',
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x3E,
    addressHigh: '01',
    addressLow: '3E',
    content: '空量程整定AD',
    instructions: '',
    isOnlyRead: true,
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x40,
    addressHigh: '01',
    addressLow: '40',
    content: '满量程整定AD',
    instructions: '',
    isOnlyRead: true,
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x42,
    addressHigh: '01',
    addressLow: '42',
    content: '当前开度值',
    instructions: '3位小数，(数据放大1000倍)，单位： m',
    unit: 'm',
    isOnlyRead: true,
    multiple: 1000,
  ),

  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x44,
    addressHigh: '01',
    addressLow: '44',
    content: '当前AD值',
    instructions: '',
    isOnlyRead: true,
  ),

];