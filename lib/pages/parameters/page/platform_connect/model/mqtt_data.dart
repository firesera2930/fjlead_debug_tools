
import 'package:debug_tools_wifi/model/register.dart';

class MQTTData {
  List getMQTTData(int platformParmType, List<int> data) {
    List allData = [];
    List<RegisterData> registerList = [];
    switch (platformParmType) {
      case 1:
        registerList.addAll(mqttFristListData);
        break;
      case 2:
        registerList.addAll(mqttLastListData);
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

List<RegisterData> mqttFristListData = [
  RegisterData(
    registerAddressHigh: 0x0B,
    registerAddressLow: 0x00,
    addressHigh: '0B',
    addressLow: '00',
    content: 'Product_id',
    instructions: 'ASCII码,不足字节补0x0',
    length: 16,
    isASCII: true,
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x0B,
    registerAddressLow: 0x08,
    addressHigh: '0B',
    addressLow: '08',
    content: '设备ID',
    instructions: 'ASCII码,不足字节补0x0',
    length: 16,
    isASCII: true,
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x0B,
    registerAddressLow: 0x10,
    addressHigh: '0B',
    addressLow: '10',
    content: '设备key',
    instructions: 'ASCII码,不足字节补0x0',
    length: 128,
    isASCII: true,
    minValue: 0,
    maxValue: 128,
  ),

];



List<RegisterData> mqttLastListData = [

  RegisterData(
    registerAddressHigh: 0x0B,
    registerAddressLow: 0x50,
    addressHigh: '0B',
    addressLow: '50',
    content: 'MEDIA_PATH',
    instructions: 'ASCII码,不足字节补0x0',
    length: 128,
    isASCII: true,
    minValue: 0,
    maxValue: 128,
  ),

  RegisterData(
    registerAddressHigh: 0x0B,
    registerAddressLow: 0x90,
    addressHigh: '0B',
    addressLow: '90',
    content: 'SERVER_ADDR',
    instructions: 'ASCII码,不足字节补0x0',
    length: 64,
    isASCII: true,
    minValue: 0,
    maxValue: 64,
  ),
  RegisterData(
    registerAddressHigh: 0x0B,
    registerAddressLow: 0xB0,
    addressHigh: '0B',
    addressLow: 'B0',
    content: 'SERVER_PORT',
    instructions: 'ASCII码,不足字节补0x0',
    length: 8,
    isASCII: true,
    minValue: 0,
    maxValue: 8,
  ),

];
