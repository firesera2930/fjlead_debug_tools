
import 'package:debug_tools_wifi/model/register.dart';

class CameraParmData {
  List getCameraParmData(int cameraType, List<int> data) {
    List allData = [];
    List<RegisterData> registerList = [];
    switch (cameraType) {
      case 1:
        registerList.addAll(cameraOneListData);
        break;
      case 2:
        registerList.addAll(cameraTwoListData);
        break;
      case 3:
        registerList.addAll(cameraThreeListData);
        break;
      case 4:
        registerList.addAll(cameraFourListData);
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
      print(hexList);
      list.add(registerData);
      list.add(hexList);
      allData.add(list);
    }
    return allData;
  }
}

/// 摄像头参数
List<RegisterData> cameraOneListData = [
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x06,
    addressHigh: '08',
    addressLow: '06',
    content: '1#摄像头用户名',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '1#摄像头用户名',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x0E,
    addressHigh: '08',
    addressLow: '0E',
    content: '1#摄像头密码',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '1#摄像头密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x16,
      addressHigh: '08',
      addressLow: '16',
      content: '1#摄像头登录认证',
      instructions: '0:无； 1：basic 2：diges',
      length: 2),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x17,
    addressHigh: '08',
    addressLow: '17',
    content: '1#摄像头IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x19,
      addressHigh: '08',
      addressLow: '19',
      content: '1#摄像头http端口',
      instructions: '0～65535',
      length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
];

List<RegisterData> cameraTwoListData = [
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x1A,
    addressHigh: '08',
    addressLow: '1A',
    content: '2#摄像头用户名',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '2#摄像头用户名',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x22,
    addressHigh: '08',
    addressLow: '22',
    content: '2#摄像头密码',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '2#摄像头密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x2A,
      addressHigh: '08',
      addressLow: '2A',
      content: '2#摄像头登录认证',
      instructions: '0:无； 1：basic 2：diges',
      length: 2),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x2B,
    addressHigh: '08',
    addressLow: '2B',
    content: '2#摄像头IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x2D,
      addressHigh: '08',
      addressLow: '2D',
      content: '2#摄像头http端口',
      instructions: '0～65535',
      length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
];

List<RegisterData> cameraThreeListData = [
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x2E,
    addressHigh: '08',
    addressLow: '2E',
    content: '3#摄像头用户名',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '3#摄像头用户名',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x36,
    addressHigh: '08',
    addressLow: '36',
    content: '3#摄像头密码',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '3#摄像头密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x3E,
      addressHigh: '08',
      addressLow: '3E',
      content: '3#摄像头登录认证',
      instructions: '0:无； 1：basic 2：diges',
      length: 2),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x3F,
    addressHigh: '08',
    addressLow: '3F',
    content: '3#摄像头IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x41,
      addressHigh: '08',
      addressLow: '41',
      content: '3#摄像头http端口',
      instructions: '0～65535',
      length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
];

List<RegisterData> cameraFourListData = [
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x42,
    addressHigh: '08',
    addressLow: '42',
    content: '4#摄像头用户名',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '4#摄像头用户名',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x4A,
    addressHigh: '08',
    addressLow: '4A',
    content: '4#摄像头密码',
    instructions: 'ASCII码,不足16字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '4#摄像头密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x52,
      addressHigh: '08',
      addressLow: '52',
      content: '4#摄像头登录认证',
      instructions: '0:无； 1：basic 2：diges',
      length: 2),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x53,
    addressHigh: '08',
    addressLow: '53',
    content: '4#摄像头IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x55,
      addressHigh: '08',
      addressLow: '55',
      content: '4#摄像头http端口',
      instructions: '0～65535',
      length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
];