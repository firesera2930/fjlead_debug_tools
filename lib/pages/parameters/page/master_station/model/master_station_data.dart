
import 'package:debug_tools_wifi/model/register.dart';

class MasterStationData {

  List getmasterStationData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(masterStationListData);

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

List<RegisterData> masterStationListData = [
  RegisterData(
    registerAddressHigh: 0x09,
    registerAddressLow: 0x00,
    addressHigh: '09',
    addressLow: '00',
    content: '客户编码',
    instructions: '1～9999',
    length: 2,
    minValue: 1,
    maxValue: 9999,
    defaultString: '1～9999',
  ),
  RegisterData(
    registerAddressHigh: 0x09,
    registerAddressLow: 0x01,
    addressHigh: '09',
    addressLow: '01',
    content: '电站编码',
    instructions: '1～999',
    length: 2,
    minValue: 1,
    maxValue: 999,
    defaultString: '1~999',
  ),
  RegisterData(
      registerAddressHigh: 0x09,
      registerAddressLow: 0x02,
      addressHigh: '09',
      addressLow: '02',
      content: '机组编码',
      instructions: '1～15',
      length: 2,
    minValue: 1,
    maxValue: 15,
    defaultString: '1~15',
  ),
  RegisterData(
    registerAddressHigh: 0x09,
    registerAddressLow: 0x03,
    addressHigh: '09',
    addressLow: '03',
    content: '主用IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
      registerAddressHigh: 0x09,
      registerAddressLow: 0x05,
      addressHigh: '09',
      addressLow: '05',
      content: '主用端口',
      instructions: '0～65535',
      length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),

  RegisterData(
    registerAddressHigh: 0x09,
    registerAddressLow: 0x03,
    addressHigh: '09',
    addressLow: '03',
    content: '备用IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
    registerAddressHigh: 0x09,
    registerAddressLow: 0x05,
    addressHigh: '09',
    addressLow: '05',
    content: '备用端口',
    instructions: '0～65535',
    length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
  RegisterData(
    registerAddressHigh: 0x09,
    registerAddressLow: 0x06,
    addressHigh: '09',
    addressLow: '06',
    content: '固件版本',
    instructions: 'ASCII码字符',
    isASCII: true,
    length: 16,
    isOnlyRead: true,
  ),
  RegisterData(
    registerAddressHigh: 0x09,
    registerAddressLow: 0x0E,
    addressHigh: '09',
    addressLow: '0E',
    content: '系统版本',
    instructions: 'ASCII码字符',
    length: 16,
    isASCII: true,
    isOnlyRead: true,
  ),
];