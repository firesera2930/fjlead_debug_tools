
import 'package:debug_tools_wifi/model/register.dart';

class OBSData {
  List getOBSData(int obsType, List<int> data) {
    List allData = [];
    List<RegisterData> registerList = [];
    switch (obsType) {
      case 1:
        registerList.addAll(obsFristListData);
        break;
      case 2:
        registerList.addAll(obsMiddleListData);
        break;
      case 3:
        registerList.addAll(obsLastListData);
        break;
    }
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
      // print(hexList);
      list.add(registerData);
      list.add(hexList);
      allData.add(list);
    }
    return allData;
  }
}

List<RegisterData> obsFristListData = [
  RegisterData(
    registerAddressHigh: 0x0C,
    registerAddressLow: 0x00,
    addressHigh: '0C',
    addressLow: '00',
    content: 'Bucket Name',
    instructions: 'ASCII码,不足字节补0x0',
    length: 32,
    isASCII: true,
    minValue: 0,
    maxValue: 32,
  ),
  RegisterData(
    registerAddressHigh: 0x0C,
    registerAddressLow: 0x10,
    addressHigh: '0C',
    addressLow: '10',
    content: 'Host Name',
    instructions: 'ASCII码,不足字节补0x0',
    length: 64,
    isASCII: true,
    minValue: 0,
    maxValue: 64,
  ),
  RegisterData(
    registerAddressHigh: 0x0C,
    registerAddressLow: 0x30,
    addressHigh: '0C',
    addressLow: '30',
    content: 'User Name',
    instructions: 'ASCII码,不足字节补0x0',
    length: 32,
    isASCII: true,
    minValue: 0,
    maxValue: 32,
  ),

];

List<RegisterData> obsMiddleListData = [
  RegisterData(
    registerAddressHigh: 0x0C,
    registerAddressLow: 0x40,
    addressHigh: '0C',
    addressLow: '40',
    content: 'Access Key Id',
    instructions: 'ASCII码,不足字节补0x0',
    length: 128,
    isASCII: true,
    minValue: 0,
    maxValue: 128,
  ),
];

List<RegisterData> obsLastListData = [

  RegisterData(
    registerAddressHigh: 0x0C,
    registerAddressLow: 0x80,
    addressHigh: '0C',
    addressLow: '80',
    content: 'Secret Access Key',
    instructions: 'ASCII码,不足字节补0x0',
    length: 128,
    isASCII: true,
    minValue: 0,
    maxValue: 128,
  ),

  RegisterData(
    registerAddressHigh: 0x0C,
    registerAddressLow: 0xC0,
    addressHigh: '0C',
    addressLow: 'C0',
    content: 'URI_MODE',
    instructions: 'ASCII码,不足字节补0x0',
    length: 16,
    isASCII: true,
    minValue: 0,
    maxValue: 16,
  ),
];