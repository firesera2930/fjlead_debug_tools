
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/parameters/page/camera/model/camera_parm_data.dart';

class PlatformParmData {
  List getPlatformParmData(int platformParmType, List<int> data) {
    List allData = [];
    List<RegisterData> registerList = [];
    switch (platformParmType) {
      case 1:
        registerList.addAll(platformParmOneListData);
        break;
      case 2:
        registerList.addAll(platformParmTwoListData);
        break;
      case 3:
        registerList.addAll(platformParmThreeListData);
        break;
      case 4:
        registerList.addAll(platformParmFourListData);
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

/// 监测类型
/// 0：无1：福建2：四川能投3：福建水雨晴4：雅安天全县
// 5：广东6：江西7:贵州 8：湖南9：浙江丽水
// 10：陕西泾阳县 11：安庆太湖县/潜山市
Map<int, String> platformParmType = {
  0: '无',
  1: '福建',
  2: '四川能投',
  3: '福建水雨晴',
  4: '雅安天全县',
  5: '广东',
  6: '江西',
  7: '贵州',
  8: '湖南',
  9: '浙江丽水',
  10: '陕西泾阳县',
  11: '安庆太湖县/潜山市',
};

List<RegisterData> platformParmOneListData = [
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x08,
    addressHigh: '0A',
    addressLow: '08',
    content: '平台1访问密码',
    instructions: 'ASCII码,不足字节补0x0',
    length: 16,
    isASCII: true,
    defaultString:  '平台1访问密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x10,
    addressHigh: '0A',
    addressLow: '10',
    content: '平台1IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    length: 4,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x12,
    addressHigh: '0A',
    addressLow: '12',
    content: '平台1端口',
    instructions: '0～65535',
    length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x13,
    addressHigh: '0A',
    addressLow: '13',
    content: '平台1规约',
    instructions: '0：无1：福建2：四川能投3：福建水雨晴4：雅安天全县5：广东6：江西7:贵州 8：湖南9：浙江丽水10：陕西泾阳县 11：安庆太湖县/潜山市',
    length: 2,
  ),
];

List<RegisterData> platformParmTwoListData = [
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x14,
    addressHigh: '0A',
    addressLow: '14',
    content: '平台2访问密码',
    instructions: 'ASCII码,不足字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '平台2访问密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x1C,
    addressHigh: '0A',
    addressLow: '1C',
    content: '平台2IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x1E,
    addressHigh: '0A',
    addressLow: '1E',
    content: '平台2端口',
    instructions: '0～65535',
    length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x1F,
    addressHigh: '0A',
    addressLow: '1F',
    content: '平台2规约',
    instructions: '0：无1：福建2：四川能投3：福建水雨晴4：雅安天全县5：广东6：江西7:贵州 8：湖南9：浙江丽水10：陕西泾阳县 11：安庆太湖县/潜山市',
    length: 2,
  ),
];

List<RegisterData> platformParmThreeListData = [
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x20,
    addressHigh: '0A',
    addressLow: '20',
    content: '平台3访问密码',
    instructions: 'ASCII码,不足字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '平台3访问密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x28,
    addressHigh: '0A',
    addressLow: '28',
    content: '平台3IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x2A,
    addressHigh: '0A',
    addressLow: '2A',
    content: '平台3端口',
    instructions: '0～65535',
    length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x2B,
    addressHigh: '0A',
    addressLow: '2B',
    content: '平台3规约',
    instructions: '0：无1：福建2：四川能投3：福建水雨晴4：雅安天全县5：广东6：江西7:贵州 8：湖南9：浙江丽水10：陕西泾阳县 11：安庆太湖县/潜山市',
    length: 2,
  ),
];


List<RegisterData> platformParmFourListData = [
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x2C,
    addressHigh: '0A',
    addressLow: '2C',
    content: '平台4访问密码',
    instructions: 'ASCII码,不足字节补0x0',
    length: 16,
    isASCII: true,
    defaultString: '平台4访问密码',
    minValue: 0,
    maxValue: 16,
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x34,
    addressHigh: '0A',
    addressLow: '34',
    content: '平台4IP地址',
    instructions: '地址段1~地址段4,每段范围0～255',
    isIpAddress: true,
    defaultString: '000.000.000.000',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x36,
    addressHigh: '0A',
    addressLow: '36',
    content: '平台4端口',
    instructions: '0～65535',
    length: 2,
    minValue: 0,
    maxValue: 65535,
    defaultString: '0～65535',
  ),
  RegisterData(
    registerAddressHigh: 0x0A,
    registerAddressLow: 0x37,
    addressHigh: '0A',
    addressLow: '37',
    content: '平台4规约',
    instructions: '0：无1：福建2：四川能投3：福建水雨晴4：雅安天全县5：广东6：江西7:贵州 8：湖南9：浙江丽水10：陕西泾阳县 11：安庆太湖县/潜山市',
    length: 2,
  ),
];